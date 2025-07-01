import { createApp } from 'vue'
import App from './App.vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import './registerServiceWorker'
import axios from './api/request.js'
import router from './router'
import qs from 'qs';

const app = createApp(App)
app.use(ElementPlus)
app.use(router)
app.provide("$axios", axios);
app.mount('#app')
window.addEventListener('beforeunload', function() {
    localStorage.removeItem('Authorization');
});
app.config.globalProperties.$axios = axios
app.config.globalProperties.$qs = qs
