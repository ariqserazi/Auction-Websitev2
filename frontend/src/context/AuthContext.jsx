import { createContext, useContext, useEffect, useState } from "react";
import { apiRequest } from "../api/client";

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [booting, setBooting] = useState(true);

  useEffect(() => {
    const token = localStorage.getItem("threadline-token");
    if (!token) {
      setBooting(false);
      return;
    }

    apiRequest("/auth/me")
      .then((currentUser) => setUser(currentUser))
      .catch(() => {
        localStorage.removeItem("threadline-token");
        setUser(null);
      })
      .finally(() => setBooting(false));
  }, []);

  async function authenticate(path, payload) {
    const response = await apiRequest(path, {
      method: "POST",
      body: JSON.stringify(payload),
    });

    localStorage.setItem("threadline-token", response.token);
    setUser(response.user);
    return response.user;
  }

  function logout() {
    localStorage.removeItem("threadline-token");
    setUser(null);
  }

  return (
    <AuthContext.Provider
      value={{
        user,
        booting,
        isAuthenticated: Boolean(user),
        login: (payload) => authenticate("/auth/login", payload),
        register: (payload) => authenticate("/auth/register", payload),
        logout,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within AuthProvider");
  }
  return context;
}
