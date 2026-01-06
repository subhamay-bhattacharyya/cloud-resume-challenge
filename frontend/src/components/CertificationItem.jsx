import React from "react";
import { NavLink } from "react-router-dom";

export default function CertificationItem(props) {
  const certification = props.certification;
  return (
    <div className="certification_item">
      <div className="certification_info">
        
      </div>
      <figure>
      <a href={certification.certificate_url} target="_blank" rel="noopener noreferrer">
        <img className = "thumb" src={certification.image_url} alt={certification.name} />
      </a>
      <figcaption className="caption">{certification.validity}</figcaption>
      </figure>
    </div>
  );
}