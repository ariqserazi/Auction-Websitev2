import { useEffect, useState } from "react";
import { apiRequest } from "../api/client";

export function AdminPage() {
  const [overview, setOverview] = useState(null);
  const [users, setUsers] = useState([]);
  const [auctions, setAuctions] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    Promise.all([apiRequest("/admin/overview"), apiRequest("/admin/users"), apiRequest("/admin/auctions")])
      .then(([overviewResponse, usersResponse, auctionsResponse]) => {
        setOverview(overviewResponse);
        setUsers(usersResponse);
        setAuctions(auctionsResponse);
      })
      .catch((err) => setError(err.message));
  }, []);

  async function flagAuction(auctionId) {
    try {
      const updated = await apiRequest(`/admin/auctions/${auctionId}`, {
        method: "PATCH",
        body: JSON.stringify({ listingStatus: "FLAGGED", closingNote: "Flagged for admin review." }),
      });
      setAuctions((current) => current.map((auction) => (auction.auctionId === auctionId ? updated : auction)));
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div className="page-shell">
      <section className="page-header">
        <div className="eyebrow">Admin console</div>
        <h1>Oversee users and listings</h1>
        <p>Review platform health, moderate questionable listings, and keep the marketplace trustworthy.</p>
      </section>

      {error ? <div className="error-banner">{error}</div> : null}

      {overview ? (
        <section className="dashboard-grid">
          <div className="panel"><span className="label">Active users</span><strong>{overview.totalUsers}</strong></div>
          <div className="panel"><span className="label">Active auctions</span><strong>{overview.activeAuctions}</strong></div>
          <div className="panel"><span className="label">Gross bid volume</span><strong>${Number(overview.grossBidVolume).toFixed(2)}</strong></div>
        </section>
      ) : null}

      <section className="dashboard-grid">
        <div className="panel">
          <h2>Users</h2>
          {users.map((user) => (
            <div key={user.id} className="history-row">
              <span>{user.fullName} · {user.role}</span>
              <strong>{user.enabled ? "Active" : "Disabled"}</strong>
            </div>
          ))}
        </div>
        <div className="panel">
          <h2>Auctions</h2>
          {auctions.map((auction) => (
            <div key={auction.auctionId} className="history-row">
              <span>{auction.title}</span>
              <div className="action-row">
                <strong>{auction.listingStatus}</strong>
                {auction.listingStatus === "ACTIVE" ? (
                  <button className="button button--ghost" onClick={() => flagAuction(auction.auctionId)}>
                    Flag
                  </button>
                ) : null}
              </div>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}
