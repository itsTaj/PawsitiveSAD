const fs = require('fs').promises;
const path = require('path');

const DATA_DIR = path.resolve('/workspace/data');
const RIDES_FILE = path.join(DATA_DIR, 'rides.json');

async function ensureDataFile() {
  await fs.mkdir(DATA_DIR, { recursive: true });
  try {
    await fs.access(RIDES_FILE);
  } catch {
    const initial = { rides: [], ratings: [] };
    await fs.writeFile(RIDES_FILE, JSON.stringify(initial, null, 2), 'utf-8');
  }
}

async function readAll() {
  await ensureDataFile();
  const raw = await fs.readFile(RIDES_FILE, 'utf-8');
  return JSON.parse(raw || '{"rides":[],"ratings":[]}');
}

async function writeAll(data) {
  await ensureDataFile();
  const tmp = RIDES_FILE + '.tmp';
  await fs.writeFile(tmp, JSON.stringify(data, null, 2), 'utf-8');
  await fs.rename(tmp, RIDES_FILE);
}

async function getRides() {
  const { rides } = await readAll();
  return rides;
}

async function saveRides(rides) {
  const data = await readAll();
  data.rides = rides;
  await writeAll(data);
}

async function addRating(rating) {
  const data = await readAll();
  data.ratings.push(rating);
  await writeAll(data);
}

async function getRatingsForRide(rideId) {
  const data = await readAll();
  return data.ratings.filter(r => r.rideId === rideId);
}

module.exports = {
  getRides,
  saveRides,
  addRating,
  getRatingsForRide,
};
