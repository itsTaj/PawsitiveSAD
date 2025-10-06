import React from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter, Routes, Route, Link } from 'react-router-dom'
import CreateRide from './pages/CreateRide'
import JoinRide from './pages/JoinRide'
import RideSummary from './pages/RideSummary'

function AppLayout() {
  return (
    <div style={{ fontFamily: 'system-ui, sans-serif', maxWidth: 960, margin: '0 auto', padding: 16 }}>
      <header style={{ display: 'flex', gap: 12, alignItems: 'center', justifyContent: 'space-between' }}>
        <h2>Rickshaw Share</h2>
        <nav style={{ display: 'flex', gap: 12 }}>
          <Link to="/">Create</Link>
          <Link to="/join">Join</Link>
        </nav>
      </header>
      <Routes>
        <Route path="/" element={<CreateRide />} />
        <Route path="/join" element={<JoinRide />} />
        <Route path="/ride/:rideId" element={<RideSummary />} />
      </Routes>
    </div>
  )
}

createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <BrowserRouter>
      <AppLayout />
    </BrowserRouter>
  </React.StrictMode>
)
