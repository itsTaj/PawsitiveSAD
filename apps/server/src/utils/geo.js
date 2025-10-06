// Simple haversine and route-overlap utilities

function toRad(deg) {
  return (deg * Math.PI) / 180;
}

function haversineMeters(a, b) {
  const R = 6371000; // meters
  const dLat = toRad(b.lat - a.lat);
  const dLon = toRad(b.lng - a.lng);
  const lat1 = toRad(a.lat);
  const lat2 = toRad(b.lat);

  const sinDLat = Math.sin(dLat / 2);
  const sinDLon = Math.sin(dLon / 2);
  const c = sinDLat * sinDLat + Math.cos(lat1) * Math.cos(lat2) * sinDLon * sinDLon;
  const d = 2 * Math.atan2(Math.sqrt(c), Math.sqrt(1 - c));
  return R * d;
}

function linestringLengthMeters(points) {
  if (!points || points.length < 2) return 0;
  let sum = 0;
  for (let i = 1; i < points.length; i++) {
    sum += haversineMeters(points[i - 1], points[i]);
  }
  return sum;
}

function isPointNearSegment(p, a, b, toleranceMeters = 100) {
  // approximate by projecting on the plane; sufficient for short segments
  const toXY = ({ lat, lng }) => {
    const x = lng * 111320 * Math.cos(toRad(lat));
    const y = lat * 110540;
    return { x, y };
  };
  const P = toXY(p);
  const A = toXY(a);
  const B = toXY(b);
  const ABx = B.x - A.x;
  const ABy = B.y - A.y;
  const APx = P.x - A.x;
  const APy = P.y - A.y;
  const ab2 = ABx * ABx + ABy * ABy;
  const t = ab2 === 0 ? 0 : Math.max(0, Math.min(1, (APx * ABx + APy * ABy) / ab2));
  const Hx = A.x + t * ABx;
  const Hy = A.y + t * ABy;
  const dx = P.x - Hx;
  const dy = P.y - Hy;
  const dist = Math.sqrt(dx * dx + dy * dy);
  return dist <= toleranceMeters;
}

function isPointOnPolyline(point, polyline, toleranceMeters = 100) {
  if (!polyline || polyline.length < 2) return false;
  for (let i = 1; i < polyline.length; i++) {
    if (isPointNearSegment(point, polyline[i - 1], polyline[i], toleranceMeters)) {
      return true;
    }
  }
  return false;
}

function overlapDistanceMeters(polyA, polyB) {
  // Approximate overlap by sampling segments and summing shared portions
  if (!polyA || !polyB || polyA.length < 2 || polyB.length < 2) return 0;
  let shared = 0;
  const tolerance = 100; // meters
  for (let i = 1; i < polyA.length; i++) {
    const mid = {
      lat: (polyA[i - 1].lat + polyA[i].lat) / 2,
      lng: (polyA[i - 1].lng + polyA[i].lng) / 2,
    };
    if (isPointOnPolyline(mid, polyB, tolerance)) {
      shared += haversineMeters(polyA[i - 1], polyA[i]);
    }
  }
  return shared;
}

module.exports = {
  haversineMeters,
  linestringLengthMeters,
  isPointOnPolyline,
  overlapDistanceMeters,
};
