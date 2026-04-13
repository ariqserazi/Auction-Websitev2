import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { apiRequest } from "../api/client";

export function DashboardPage() {
  const [dashboard, setDashboard] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    apiRequest("/dashboard")
      .then(setDashboard)
      .catch((err) => setError(err.message));
  }, []);

  if (!dashboard) {
    return <div className="page-shell">Loading dashboard...</div>;
  }

  return (
    <div className="page-shell">
      <section className="page-header">
        <div className="eyebrow">Dashboard</div>
        <h1>Your marketplace activity</h1>
        <p>Track your own listings, your latest bids, and any auctions you’ve already won.</p>
      </section>

      {error ? <div className="error-banner">{error}</div> : null}

      <section className="dashboard-grid">
        <div className="panel">
          <h2>My listings</h2>
          {dashboard.myListings.map((auction) => (
            <Link key={auction.auctionId} className="history-row" to={`/auctions/${auction.auctionId}`}>
              <span>{auction.title}</span>
              <strong>${Number(auction.currentPrice).toFixed(2)}</strong>
            </Link>
          ))}
        </div>
        <div className="panel">
          <h2>Recent bids</h2>
          {dashboard.recentBids.map((bid) => (
            <Link key={bid.bidId} className="history-row" to={`/auctions/${bid.auctionId}`}>
              <span>{bid.title}</span>
              <strong>${Number(bid.amount).toFixed(2)}</strong>
            </Link>
          ))}
        </div>
        <div className="panel">
          <h2>Wins</h2>
          {dashboard.wins.map((auction) => (
            <Link key={auction.auctionId} className="history-row" to={`/auctions/${auction.auctionId}`}>
              <span>{auction.title}</span>
              <strong>${Number(auction.currentPrice).toFixed(2)}</strong>
            </Link>
          ))}
        </div>
      </section>
    </div>
  );
}
