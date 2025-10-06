import React, { useState } from 'react'
import axios from 'axios'
import MapPicker from '../components/MapPicker'

export default function CreateRide() {
  const [initiatorId, setInitiatorId] = useState('user1')
  const [start, setStart] = useState({ lat: 23.7806, lng: 90.2792 })
  const [end, setEnd] = useState({ lat: 23.8103, lng: 90.4125 })
  const [totalFare, setTotalFare] = useState(100)
  const [qr, setQr] = useState(null)
  const [ride, setRide] = useState(null)
  const [loading, setLoading] = useState(false)

  async function createRide(e) {
    e.preventDefault()
    setLoading(true)
    try {
      const res = await axios.post('/api/rides', { initiatorId, start, end, totalFare })
      setRide(res.data.ride)
      setQr(res.data.qr)
    } catch (e) {
      alert('Failed to create ride')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div>
      <h3>Create Ride</h3>
      <form onSubmit={createRide} style={{ display: 'grid', gap: 8, maxWidth: 480 }}>
        <label>
          Initiator ID
          <input value={initiatorId} onChange={e => setInitiatorId(e.target.value)} />
        </label>
        <label>
          Start (pick on map)
          <MapPicker value={start} onChange={setStart} />
        </label>
        <label>
          End (pick on map)
          <MapPicker value={end} onChange={setEnd} />
        </label>
        <label>
          Total Fare
          <input type="number" value={totalFare} onChange={e => setTotalFare(parseFloat(e.target.value))} />
        </label>
        <button disabled={loading} type="submit">{loading ? 'Creating...' : 'Create Ride'}</button>
      </form>

      {qr && (
        <div style={{ marginTop: 16 }}>
          <h4>Share QR to Join</h4>
          <img src={qr} alt="ride-qr" style={{ width: 240, height: 240 }} />
          {ride && (
            <div style={{ marginTop: 8, fontSize: 12 }}>
              <div>Ride ID: {ride.id}</div>
              <div>Distance: {(ride.distanceMeters / 1000).toFixed(2)} km</div>
              <div>Total Fare: {ride.totalFare}</div>
            </div>
          )}
        </div>
      )}
    </div>
  )
}
