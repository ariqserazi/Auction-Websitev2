import { useEffect, useState } from "react";
import { apiRequest } from "../api/client";
import { AuctionCard } from "../components/AuctionCard";

const DEFAULT_FILTERS = {
  query: "",
  category: "",
  size: "",
  condition: "",
};

export function MarketplacePage() {
  const [filters, setFilters] = useState(DEFAULT_FILTERS);
  const [auctions, setAuctions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const params = new URLSearchParams();
    Object.entries(filters).forEach(([key, value]) => value && params.set(key, value));

    setLoading(true);
    apiRequest(`/auctions?${params.toString()}`)
      .then(setAuctions)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }, [filters]);

  return (
    <div className="page-shell">
      <section className="page-header">
        <div className="eyebrow">Marketplace</div>
        <h1>Browse active auctions</h1>
        <p>Search by brand, narrow by fit, and jump into auctions that still have runway left.</p>
      </section>

      <section className="filters">
        <input
          placeholder="Search title, brand, category"
          value={filters.query}
          onChange={(event) => setFilters((current) => ({ ...current, query: event.target.value }))}
        />
        <input
          placeholder="Category"
          value={filters.category}
          onChange={(event) => setFilters((current) => ({ ...current, category: event.target.value }))}
        />
        <input
          placeholder="Size"
          value={filters.size}
          onChange={(event) => setFilters((current) => ({ ...current, size: event.target.value }))}
        />
        <input
          placeholder="Condition"
          value={filters.condition}
          onChange={(event) => setFilters((current) => ({ ...current, condition: event.target.value }))}
        />
      </section>

      {loading ? <div className="page-shell">Loading auctions...</div> : null}
      {error ? <div className="error-banner">{error}</div> : null}

      <section className="auction-grid">
        {auctions.map((auction) => (
          <AuctionCard key={auction.auctionId} auction={auction} />
        ))}
      </section>
    </div>
  );
}
