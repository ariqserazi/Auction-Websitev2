import { Link } from "react-router-dom";

export function AuctionCard({ auction }) {
  return (
    <article className="auction-card">
      <img src={auction.imageUrl} alt={auction.title} className="auction-card__image" />
      <div className="auction-card__body">
        <div className="eyebrow">{auction.category} · {auction.condition}</div>
        <h3>{auction.title}</h3>
        <p className="muted">
          {auction.brand} · Size {auction.size} · {auction.color}
        </p>
        <div className="auction-card__price-row">
          <div>
            <span className="label">Current bid</span>
            <strong>${Number(auction.currentPrice).toFixed(2)}</strong>
          </div>
          <div>
            <span className="label">Ends</span>
            <strong>{new Date(auction.endTime).toLocaleDateString()}</strong>
          </div>
        </div>
        <Link to={`/auctions/${auction.auctionId}`} className="button button--ghost">
          View auction
        </Link>
      </div>
    </article>
  );
}
