import React, { useEffect, useRef, useState } from 'react'
import axios from 'axios'
import { Html5QrcodeScanner } from 'html5-qrcode'
import MapPicker from '../components/MapPicker'

export default function JoinRide() {
  const [userId, setUserId] = useState('user2')
  const [rideId, setRideId] = useState('')
  const [destination, setDestination] = useState({ lat: 23.795, lng: 90.4 })
  const [quote, setQuote] = useState(null)
  const [ride, setRide] = useState(null)
  const [scanning, setScanning] = useState(false)
  const scannerRef = useRef(null)

  useEffect(() => {
    if (!scanning) return
    const scanner = new Html5QrcodeScanner('reader', { fps: 10, qrbox: 250 }, false)
    scanner.render(
      (text) => {
        try {
          const obj = JSON.parse(text)
          if (obj.rideId) {
            setRideId(obj.rideId)
            setScanning(false)
            scanner.clear().catch(() => {})
          }
        } catch (_) {}
      },
      () => {}
    )
    scannerRef.current = scanner
    return () => {
      scanner.clear().catch(() => {})
    }
  }, [scanning])

  async function requestJoin(e) {
    e.preventDefault()
    if (!rideId) return alert('Scan QR or paste Ride ID')
    try {
      const res = await axios.post(`/api/rides/${rideId}/join`, {
        userId,
        destination,
      })
      setQuote(res.data.quote)
      setRide(res.data.ride)
    } catch (e) {
      alert(e.response?.data?.error || 'Join failed')
    }
  }

  return (
    <div>
      <h3>Join Ride</h3>
      <div style={{ display: 'flex', gap: 16 }}>
        <button onClick={() => setScanning(s => !s)}>{scanning ? 'Stop Scan' : 'Scan QR'}</button>
        <input placeholder="Ride ID" value={rideId} onChange={e => setRideId(e.target.value)} style={{ flex: 1 }} />
      </div>
      {scanning && <div id="reader" style={{ width: 320, marginTop: 12 }} />}

      <form onSubmit={requestJoin} style={{ display: 'grid', gap: 8, maxWidth: 480, marginTop: 12 }}>
        <label>
          Your User ID
          <input value={userId} onChange={e => setUserId(e.target.value)} />
        </label>
        <label>
          Destination (pick on map)
          <MapPicker value={destination} onChange={setDestination} />
        </label>
        <button type="submit">Request to Join</button>
      </form>

      {quote && ride && (
        <div style={{ marginTop: 16, padding: 12, border: '1px solid #ddd', borderRadius: 8 }}>
          <h4>Fare Split</h4>
          <div>Initiator Share: {quote.initiatorShare}</div>
          <div>Your Share: {quote.userShare}</div>
          <div>Shared Distance: {(quote.overlapMeters / 1000).toFixed(2)} km</div>
          <div><a href={`/ride/${ride.id}`}>Go to Ride Summary</a></div>
        </div>
      )}
    </div>
  )
}
