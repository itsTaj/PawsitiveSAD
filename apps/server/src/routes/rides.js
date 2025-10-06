const { Router } = require('express');
const { z } = require('zod');
const { v4: uuidv4 } = require('uuid');
const QRCode = require('qrcode');
const { getRides, saveRides, addRating, getRatingsForRide } = require('../utils/datastore');
const { linestringLengthMeters, overlapDistanceMeters } = require('../utils/geo');

const router = Router();
// Get ride by id
router.get('/:rideId', async (req, res) => {
  const paramsSchema = z.object({ rideId: z.string().uuid() });
  const p = paramsSchema.safeParse(req.params);
  if (!p.success) return res.status(400).json({ error: p.error.flatten() });
  const { rideId } = p.data;
  const rides = await getRides();
  const ride = rides.find(r => r.id === rideId);
  if (!ride) return res.status(404).json({ error: 'Ride not found' });
  res.json(ride);
});

const pointSchema = z.object({ lat: z.number(), lng: z.number() });
const pathSchema = z.array(pointSchema).min(2);

// Create ride
router.post('/', async (req, res) => {
  const bodySchema = z.object({
    initiatorId: z.string(),
    start: pointSchema,
    end: pointSchema,
    route: pathSchema.optional(), // optional polyline; if absent, we use [start,end]
    totalFare: z.number().positive(),
  });
  const parse = bodySchema.safeParse(req.body);
  if (!parse.success) return res.status(400).json({ error: parse.error.flatten() });
  const { initiatorId, start, end, route, totalFare } = parse.data;

  const id = uuidv4();
  const polyline = route && route.length >= 2 ? route : [start, end];
  const distanceMeters = linestringLengthMeters(polyline);
  const ride = {
    id,
    initiatorId,
    start,
    end,
    route: polyline,
    distanceMeters,
    totalFare,
    isOpen: true,
    createdAt: Date.now(),
    participants: [
      {
        userId: initiatorId,
        start,
        end,
        share: totalFare, // temporary until split; will adjust when someone joins
        approved: true,
      },
    ],
    payments: [],
    status: 'ongoing', // 'ongoing' | 'completed'
  };

  const rides = await getRides();
  rides.push(ride);
  await saveRides(rides);

  // Generate simple QR payload with ride id
  const qrData = JSON.stringify({ rideId: id });
  const qr = await QRCode.toDataURL(qrData);

  res.json({ ride, qr });
});

// Discover open rides (list)
router.get('/open', async (_req, res) => {
  const rides = await getRides();
  res.json(rides.filter(r => r.isOpen && r.status === 'ongoing'));
});

// Join ride (request with destination)
router.post('/:rideId/join', async (req, res) => {
  const paramsSchema = z.object({ rideId: z.string().uuid() });
  const bodySchema = z.object({
    userId: z.string(),
    destination: pointSchema,
    joiningPoint: pointSchema.optional(),
  });
  const p = paramsSchema.safeParse(req.params);
  const b = bodySchema.safeParse(req.body);
  if (!p.success) return res.status(400).json({ error: p.error.flatten() });
  if (!b.success) return res.status(400).json({ error: b.error.flatten() });
  const { rideId } = p.data;
  const { userId, destination, joiningPoint } = b.data;

  const rides = await getRides();
  const ride = rides.find(r => r.id === rideId);
  if (!ride) return res.status(404).json({ error: 'Ride not found' });
  if (!ride.isOpen || ride.status !== 'ongoing') return res.status(400).json({ error: 'Ride not open' });

  // Eligibility: destination must lie along route; if not, reject
  const userRoute = [joiningPoint || ride.start, destination];
  const overlap = overlapDistanceMeters(userRoute, ride.route);
  const userDist = Math.max(1, linestringLengthMeters(userRoute));
  const routeDist = Math.max(1, linestringLengthMeters(ride.route));

  if (overlap < userDist * 0.7) {
    return res.status(400).json({ error: 'Destination not sufficiently along the route' });
  }

  // Fare split logic: proportional to overlap distance share between riders
  // We calculate shares so that total equals ride.totalFare
  const existingRider = ride.participants[0];
  const initiatorOverlap = overlapDistanceMeters([ride.start, existingRider.end], userRoute);
  const userOverlap = overlap;
  const soloInitiatorDist = linestringLengthMeters([ride.start, existingRider.end]) - initiatorOverlap;
  const totalSharedWeight = initiatorOverlap + userOverlap; // shared portions counted per-rider
  const totalSoloWeight = soloInitiatorDist; // new user has no solo portion beyond overlap on main route
  const totalWeight = totalSharedWeight + totalSoloWeight;

  // Avoid division by zero
  const initiatorShare = (ride.totalFare * (initiatorOverlap + soloInitiatorDist)) / totalWeight;
  const userShare = (ride.totalFare * userOverlap) / totalWeight;

  const quote = {
    initiatorShare: Number(initiatorShare.toFixed(2)),
    userShare: Number(userShare.toFixed(2)),
    overlapMeters: Math.round(overlap),
    riderDistanceMeters: Math.round(userDist),
    rideDistanceMeters: Math.round(routeDist),
  };

  // Append pending participant (needs confirmation step in UI)
  const existing = ride.participants.find(p => p.userId === userId);
  if (!existing) {
    ride.participants.push({ userId, start: joiningPoint || ride.start, end: destination, share: quote.userShare, approved: true });
  }
  // Update initiator share
  ride.participants[0].share = quote.initiatorShare;
  ride.isOpen = false; // close once joined for simplicity (limit 2 riders for now)

  await saveRides(rides);
  res.json({ ride, quote });
});

// Complete ride
router.post('/:rideId/complete', async (req, res) => {
  const paramsSchema = z.object({ rideId: z.string().uuid() });
  const bodySchema = z.object({ payments: z.array(z.object({ userId: z.string(), amount: z.number().nonnegative() })).optional() });
  const p = paramsSchema.safeParse(req.params);
  const b = bodySchema.safeParse(req.body);
  if (!p.success) return res.status(400).json({ error: p.error.flatten() });
  if (!b.success) return res.status(400).json({ error: b.error.flatten() });
  const { rideId } = p.data;
  const rides = await getRides();
  const ride = rides.find(r => r.id === rideId);
  if (!ride) return res.status(404).json({ error: 'Ride not found' });

  ride.status = 'completed';
  ride.completedAt = Date.now();
  if (b.data.payments) {
    ride.payments = b.data.payments;
  }
  await saveRides(rides);
  res.json({ ride });
});

// Ratings
router.post('/:rideId/ratings', async (req, res) => {
  const paramsSchema = z.object({ rideId: z.string().uuid() });
  const bodySchema = z.object({ fromUserId: z.string(), toUserId: z.string(), stars: z.number().int().min(1).max(5), comment: z.string().optional() });
  const p = paramsSchema.safeParse(req.params);
  const b = bodySchema.safeParse(req.body);
  if (!p.success) return res.status(400).json({ error: p.error.flatten() });
  if (!b.success) return res.status(400).json({ error: b.error.flatten() });
  const { rideId } = p.data;
  const rating = { rideId, ...b.data, createdAt: Date.now() };
  await addRating(rating);
  res.json({ ok: true });
});

router.get('/:rideId/ratings', async (req, res) => {
  const paramsSchema = z.object({ rideId: z.string().uuid() });
  const p = paramsSchema.safeParse(req.params);
  if (!p.success) return res.status(400).json({ error: p.error.flatten() });
  const { rideId } = p.data;
  const ratings = await getRatingsForRide(rideId);
  res.json(ratings);
});

module.exports = router;
