import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import Vant from 'vant'
import 'vant/lib/index.css'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
import Tabbar from './components/Tabbar'
import VueParticles from 'vue-particles'  

Vue.config.productionTip = false
Vue.prototype.serverUrl ='http://localhost:8080/'
//配置请求时保存session信息 
axios.defaults.withCredentials = true
//配置请求基础路径
axios.defaults.baseURL = "http://127.0.0.1:8000/"
//注册
Vue.prototype.axios = axios;
Vue.component('Tabbar',Tabbar);
Vue.use(Vant);
Vue.use(ElementUI);
Vue.use(VueParticles);

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
