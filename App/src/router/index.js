import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Search from '../views/Search.vue'
import Detail from '../views/Detail.vue'
import Enterprise from '../views/Enterprise.vue'
import Alllist from '../views/Alllist.vue'
import Person from '../views/Person.vue'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import Resume from '../views/Resume.vue'
import Basicinfo from '../views/Basicinfo.vue'
import Sign from '../views/Sign.vue'
import Chatroom from '../views/Chatroom.vue'
import Admin from '../views/Admin.vue'
import NotFound from '../views/NotFound'
import Tabbar from '../components/Tabbar'

Vue.use(VueRouter)

const routes = [
  {path: '/',component: Home},
  {path:'/home',component:Home},
  {path:'/search',component:Search},
  {path:'/detail/:id',component:Detail},
  {path:'/enterprise/:id/:name',component:Enterprise},
  {path:'/alllist',component:Alllist},
  {path:'/person',component:Person},
  {path:'/login',component:Login},
  {path:'/register',component:Register},
  {path:'/resume',component:Resume},
  {path:'/basicinfo',component:Basicinfo},
  {path:'/sign',component:Sign},
  {path:'/chatroom/:id',component:Chatroom},
  {path:'/admin',component:Admin},
  {path: '/tabbar',component: Tabbar},
  {path: '/*',component:NotFound},
]

const router = new VueRouter({
  routes
})

export default router
