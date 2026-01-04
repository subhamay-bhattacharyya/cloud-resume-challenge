import React from "react";
import 'css/pages/certifications.css'
import certificationsData from 'data/certificationsData.json'
import CertificationItem from 'comps/CertificationItem'

export default function CertificationsPage() {
  return (
    <>
      <h1 className='fancy'>Certifications</h1>
      <div className="certifications-grid">
        {certificationsData.map((certification) => (
          <CertificationItem key={certification.handle} certification={certification} />
        ))}
      </div>
    </>
  )
}