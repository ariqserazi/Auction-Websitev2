import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { apiRequest } from "../api/client";
import { useAuth } from "../context/AuthContext";

export function AuctionDetailPage() {
  const { auctionId } = useParams();
  const { user } = useAuth();
  const [auction, setAuction] = useState(null);
  const [bidAmount, setBidAmount] = useState("");
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");

  function loadAuction() {
    apiRequest(`/auctions/${auctionId}`)
      .then(setAuction)
      .catch((err) => setError(err.message));
  }

  useEffect(() => {
    loadAuction();
  }, [auctionId]);

  async function handleBid(event) {
    event.preventDefault();
    setMessage("");
    setError("");
    try {
      const updated = await apiRequest(`/auctions/${auctionId}/bids`, {
        method: "POST",
        body: JSON.stringify({ amount: Number(bidAmount) }),
      });
      setAuction(updated);
      setBidAmount("");
      setMessage("Bid placed successfully.");
    } catch (err) {
      setError(err.message);
    }
  }

  if (!auction) {
    return <div className="page-shell">Loading auction details...</div>;
  }

  const minimumBid = auction.bidHistory.length
    ? Number(auction.currentPrice) + Number(auction.bidIncrement)
    : Number(auction.startingPrice);

  return (
    <div className="page-shell detail-layout">
      <img src={auction.imageUrl} alt={auction.title} className="detail-image" />
      <section className="detail-card">
        <div className="eyebrow">{auction.category} · {auction.condition}</div>
        <h1>{auction.title}</h1>
        <p className="muted">{auction.brand} · Size {auction.size} · {auction.color}</p>
        <p>{auction.description}</p>

        <div className="detail-metrics">
          <div>
            <span className="label">Current bid</span>
            <strong>${Number(auction.currentPrice).toFixed(2)}</strong>
          </div>
          <div>
            <span className="label">Increment</span>
            <strong>${Number(auction.bidIncrement).toFixed(2)}</strong>
          </div>
          <div>
            <span className="label">Reserve</span>
            <strong>{auction.reservePrice ? `$${Number(auction.reservePrice).toFixed(2)}` : "None"}</strong>
          </div>
          <div>
            <span className="label">Ends</span>
            <strong>{new Date(auction.endTime).toLocaleString()}</strong>
          </div>
        </div>

        {message ? <div className="success-banner">{message}</div> : null}
        {error ? <div className="error-banner">{error}</div> : null}

        {user ? (
          <form className="panel form-stack" onSubmit={handleBid}>
            <label>
              Your bid
              <input
                type="number"
                min={minimumBid}
                step="0.01"
                value={bidAmount}
                onChange={(event) => setBidAmount(event.target.value)}
                placeholder={`Minimum $${minimumBid.toFixed(2)}`}
                required
              />
            </label>
            <button className="button" type="submit">
              Place bid
            </button>
          </form>
        ) : (
          <div className="panel">Sign in to place bids and track wins from your dashboard.</div>
        )}
      </section>

      <section className="panel">
        <div className="section-header">
          <div>
            <div className="eyebrow">Bid history</div>
            <h2>Live bidding activity</h2>
          </div>
        </div>
        <div className="history-list">
          {auction.bidHistory.map((bid) => (
            <div key={bid.bidId} className="history-row">
              <span>{bid.bidderName}</span>
              <strong>${Number(bid.amount).toFixed(2)}</strong>
              <span>{new Date(bid.createdAt).toLocaleString()}</span>
            </div>
          ))}
          {!auction.bidHistory.length ? <div className="muted">No bids yet. Be the first to set the pace.</div> : null}
        </div>
      </section>
    </div>
  );
}
