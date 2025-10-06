import React, { useEffect, useState } from 'react'
import { MapContainer, TileLayer, Marker, useMapEvents } from 'react-leaflet'
import 'leaflet/dist/leaflet.css'

function ClickHandler({ onClick }) {
  useMapEvents({
    click(e) {
      onClick({ lat: e.latlng.lat, lng: e.latlng.lng })
    },
  })
  return null
}

export default function MapPicker({ value, onChange, height = 260 }) {
  const [pos, setPos] = useState(value)
  useEffect(() => setPos(value), [value])
  return (
    <div style={{ border: '1px solid #ddd', borderRadius: 8, overflow: 'hidden' }}>
      <MapContainer center={[pos.lat, pos.lng]} zoom={13} style={{ height }}>
        <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
        <Marker position={[pos.lat, pos.lng]} />
        <ClickHandler onClick={(p) => { setPos(p); onChange?.(p) }} />
      </MapContainer>
    </div>
  )
}
