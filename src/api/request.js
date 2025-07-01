import axios from "axios";

const request = axios.create({
    baseURL: "http://localhost:8888", // 替换为你的后端 API 基础 URL
    withCredentials: true,
    timeout: 5000,
});

request.interceptors.request.use(
    config => {
        const token = sessionStorage.getItem('Authorization');
        if (token) {
            config.headers['Authorization'] = `Bearer ${token}`;
        }
        return config; 
    },
    error => {
        console.error('Request error:', error);
        return Promise.reject(error);
    }
);

request.interceptors.response.use(response => {
    return response;
  }, error => {
    if (error.response) {
      switch (error.response.status) {
        case 401:
          // token过期或未登录
          alert('您的登录状态已过期，请重新登录。');
          localStorage.removeItem('token');  // 清除过期的Token
          window.location.href = '/login';  // 重定向到登录页面
          break;
        case 403:
          // 权限不足
          alert('您没有权限执行此操作。');
          break;
        default:
          return Promise.reject(error);
      }
    }
  });

export default request;
