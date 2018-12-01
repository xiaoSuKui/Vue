import Vue from 'vue'
import Router from 'vue-router'
import Index from '@/components/Index'
import Header from '@/components/Header'
import Footer from '@/components/Footer'
import Home from '@/components/home'
import NotFound from '@/components/NotFound'
import Skill from '@/components/Skill'
import SelfTalk from '@/components/SelfTalk'
import TimeLine from '@/components/TimeLine'
import Message from '@/components/Message'
import About from '@/components/About'
import ArticleList from '@/components/ArticleList'
import Article from '@/components/Article'
import Idea from '@/components/Idea'
// 后台
import Login from '@/components/Account/Login'
import AccountIndex from '@/components/Account/index'
import AccountHome from '@/components/Account/home'
import AccountArticle from '@/components/Account/article'
import SkillList from '@/components/Account/SkillList'
Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component:Index,
      children:[
        {path:'/',redirect:'/home'},
        {path:'/home',component:Home},
        {path:'/skill',component:Skill},
        {path:'/selfTalk',component:SelfTalk},
        {path:'/timeLine',component:TimeLine},
        {path:'/message',component:Message},
        {path:'/about',component:About},
        {path:'/article/:aid',component:Article},
        {path:'/idea',component:Idea},
      ]
    },
    {
      path: '/login',
      component: Login,
      name: '',
    },
    // hidden: true
    {
      path:'/Account',
      meta: {
        requireAuth: true,  // 添加该字段，表示进入这个路由是需要登录的
      },
      component:AccountHome,
      children:[
        {path:'/',redirect:'/Account/article',meta:{title: '文章编辑'}},
        {path:'/Account/skillList',component:SkillList,meta:{name:'一技之长'}},
        {path:'/Account/home',component:AccountHome,meta:{name:'主页'}},
        {path:'/Account/article',component:AccountArticle,meta:{name: '文章编辑'}}
      ]
    },
    {
      path:'*',
      component:NotFound
    }
  ],
  scrollBehavior (to, from, savedPosition) {
    (function(){
      //百度自动推送爬虫代码
      var bp = document.createElement('script');
      var curProtocol = window.location.protocol.split(':')[0];
      if (curProtocol === 'https') {
          bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';
      }
      else {
          bp.src = 'http://push.zhanzhang.baidu.com/push.js';
      }
      var s = document.getElementsByTagName("script")[0];
      s.parentNode.insertBefore(bp, s);
    })();
      if (savedPosition) {
        return { x: 0, y: 0 }
      } else {
        return { x: 0, y: 0 }
      }
  }
})
