import React, { useEffect, useState } from 'react'
import axios from 'axios'
import { useParams } from 'react-router-dom'

export default function RideSummary() {
  const { rideId } = useParams()
  const [ride, setRide] = useState(null)
  const [payments, setPayments] = useState([])
  const [rating, setRating] = useState({ toUserId: '', stars: 5, comment: '' })
  const [ratings, setRatings] = useState([])

  useEffect(() => {
    async function fetch() {
      try {
        const r = await axios.get(`/api/rides/${rideId}`)
        setRide(r.data)
      } catch (e) {
        setRide(null)
      }
    }
    fetch()
  }, [rideId])

  async function completeRide() {
    if (!ride) return
    const res = await axios.post(`/api/rides/${ride.id}/complete`, { payments })
    setRide(res.data.ride)
  }

  async function submitRating(e) {
    e.preventDefault()
    if (!ride) return
    await axios.post(`/api/rides/${ride.id}/ratings`, {
      fromUserId: 'user-any',
      toUserId: rating.toUserId,
      stars: rating.stars,
      comment: rating.comment,
    })
    const list = await axios.get(`/api/rides/${ride.id}/ratings`)
    setRatings(list.data)
  }

  return (
    <div>
      <h3>Ride Summary</h3>
      {!ride && <div>Ride not found. It might be completed or invalid.</div>}
      {ride && (
        <div>
          <div>Ride ID: {ride.id}</div>
          <div>Status: {ride.status}</div>
          <div>Total Fare: {ride.totalFare}</div>
          <div>Participants:</div>
          <ul>
            {ride.participants.map(p => (
              <li key={p.userId}>{p.userId}: {p.share}</li>
            ))}
          </ul>

          <h4>Complete & Payments</h4>
          <button onClick={completeRide}>Mark Completed</button>
          <div style={{ marginTop: 8 }}>
            <button onClick={() => setPayments(ride.participants.map(p => ({ userId: p.userId, amount: p.share })))}>
              Autofill Payments by Shares
            </button>
            <pre>{JSON.stringify(payments, null, 2)}</pre>
          </div>

          <h4>Ratings</h4>
          <form onSubmit={submitRating} style={{ display: 'grid', gap: 8, maxWidth: 360 }}>
            <label>
              To User ID
              <input value={rating.toUserId} onChange={e => setRating({ ...rating, toUserId: e.target.value })} />
            </label>
            <label>
              Stars
              <input type="number" min={1} max={5} value={rating.stars} onChange={e => setRating({ ...rating, stars: parseInt(e.target.value) })} />
            </label>
            <label>
              Comment
              <input value={rating.comment} onChange={e => setRating({ ...rating, comment: e.target.value })} />
            </label>
            <button type="submit">Submit Rating</button>
          </form>
          <div style={{ marginTop: 8 }}>
            <button onClick={async () => setRatings((await axios.get(`/api/rides/${ride.id}/ratings`)).data)}>Refresh Ratings</button>
            <pre>{JSON.stringify(ratings, null, 2)}</pre>
          </div>
        </div>
      )}
    </div>
  )
}
