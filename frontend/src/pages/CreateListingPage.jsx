import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { apiRequest } from "../api/client";

const INITIAL_FORM = {
  title: "",
  brand: "",
  category: "",
  size: "",
  condition: "",
  color: "",
  description: "",
  imageUrl: "",
  startingPrice: "",
  bidIncrement: "",
  reservePrice: "",
  endTime: "",
};

export function CreateListingPage() {
  const navigate = useNavigate();
  const [form, setForm] = useState(INITIAL_FORM);
  const [error, setError] = useState("");

  async function handleSubmit(event) {
    event.preventDefault();
    setError("");

    try {
      const response = await apiRequest("/auctions", {
        method: "POST",
        body: JSON.stringify({
          ...form,
          startingPrice: Number(form.startingPrice),
          bidIncrement: Number(form.bidIncrement),
          reservePrice: form.reservePrice ? Number(form.reservePrice) : null,
          endTime: new Date(form.endTime).toISOString(),
        }),
      });
      navigate(`/auctions/${response.auctionId}`);
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div className="page-shell">
      <section className="page-header">
        <div className="eyebrow">Sell on Threadline</div>
        <h1>Create a new auction listing</h1>
        <p>Package a clothing item with clear pricing rules, reserve protection, and a sharp storefront card.</p>
      </section>

      <form className="panel form-grid" onSubmit={handleSubmit}>
        {Object.entries(INITIAL_FORM).map(([key]) => (
          <label key={key} className={key === "description" ? "form-grid__full" : ""}>
            {key.replace(/([A-Z])/g, " $1")}
            {key === "description" ? (
              <textarea value={form[key]} onChange={(event) => setForm((current) => ({ ...current, [key]: event.target.value }))} required />
            ) : (
              <input
                type={key.includes("Price") || key === "bidIncrement" ? "number" : key === "endTime" ? "datetime-local" : "text"}
                step={key.includes("Price") || key === "bidIncrement" ? "0.01" : undefined}
                value={form[key]}
                onChange={(event) => setForm((current) => ({ ...current, [key]: event.target.value }))}
                required={key !== "reservePrice"}
              />
            )}
          </label>
        ))}
        {error ? <div className="error-banner form-grid__full">{error}</div> : null}
        <button className="button form-grid__full" type="submit">
          Publish auction
        </button>
      </form>
    </div>
  );
}
