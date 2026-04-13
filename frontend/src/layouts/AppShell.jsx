import { Link, NavLink } from "react-router-dom";
import { useAuth } from "../context/AuthContext";

export function AppShell({ children }) {
  const { user, logout } = useAuth();

  return (
    <div className="app-shell">
      <header className="topbar">
        <Link to="/" className="brandmark">
          Threadline
        </Link>
        <nav className="topnav">
          <NavLink to="/marketplace">Marketplace</NavLink>
          <NavLink to="/sell">Sell</NavLink>
          {user && <NavLink to="/dashboard">Dashboard</NavLink>}
          {user?.role === "ROLE_ADMIN" && <NavLink to="/admin">Admin</NavLink>}
        </nav>
        <div className="topbar__actions">
          {user ? (
            <>
              <span className="user-pill">{user.firstName}</span>
              <button className="button button--ghost" onClick={logout}>
                Log out
              </button>
            </>
          ) : (
            <>
              <Link className="button button--ghost" to="/login">
                Login
              </Link>
              <Link className="button" to="/register">
                Create account
              </Link>
            </>
          )}
        </div>
      </header>
      <main>{children}</main>
    </div>
  );
}
