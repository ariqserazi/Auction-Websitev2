import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { apiRequest } from "../api/client";
import { AuctionCard } from "../components/AuctionCard";

export function LandingPage() {
  const [featured, setFeatured] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    apiRequest("/auctions/featured")
      .then(setFeatured)
      .catch((err) => setError(err.message));
  }, []);

  return (
    <div className="page-shell">
      <section className="hero">
        <div className="hero__copy">
          <div className="eyebrow">Curated clothing auctions</div>
          <h1>Modern resale for standout pieces, built like a real marketplace.</h1>
          <p>
            Launch fresh listings, bid with confidence, and manage your wardrobe side hustle from a dashboard
            that feels product-ready instead of classroom-ready.
          </p>
          <div className="hero__actions">
            <Link to="/marketplace" className="button">
              Explore auctions
            </Link>
            <Link to="/sell" className="button button--ghost">
              Start selling
            </Link>
          </div>
        </div>
        <div className="hero__panel">
          <div className="stat-card">
            <span className="label">What’s inside</span>
            <strong>JWT auth, dashboards, admin review, reserve-aware bidding</strong>
          </div>
          <div className="stat-card">
            <span className="label">Portfolio angle</span>
            <strong>Spring Boot + React + MySQL with a production-style layout</strong>
          </div>
        </div>
      </section>

      <section className="section-header">
        <div>
          <div className="eyebrow">Featured now</div>
          <h2>Auctions ending soon</h2>
        </div>
        <Link to="/marketplace" className="text-link">
          View all listings
        </Link>
      </section>

      {error ? <div className="error-banner">{error}</div> : null}

      <section className="auction-grid">
        {featured.map((auction) => (
          <AuctionCard key={auction.auctionId} auction={auction} />
        ))}
      </section>
    </div>
  );
}
