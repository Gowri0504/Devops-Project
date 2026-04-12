import axios from "axios";

const getBaseURL = () => {
  // Always use relative /api for Docker/Nginx environments
  return '/api';
};

const api = axios.create({
  baseURL: getBaseURL(),
});

// Request interceptor for adding the bearer token
api.interceptors.request.use(
  (config) => {
    const userInfo = JSON.parse(localStorage.getItem("userInfo"));
    if (userInfo && userInfo.token) {
      config.headers.Authorization = `Bearer ${userInfo.token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export default api;
