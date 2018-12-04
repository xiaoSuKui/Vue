// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import './assets/css/mavon.css'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from 'axios'
import store from './vuex/store'
import hljs from 'highlight.js';
import './assets/css/icon/iconfont.css'

// 添加自定义过滤器
import * as filters from './filters/'
Object.keys(filters).forEach((key)=>{
  Vue.filter(key,filters[key]);
});
//自定义指令v-highlight  指定标签里面代码内容高亮
Vue.directive('highlight',function (el) {
  let blocks = el.querySelectorAll('pre code');
  blocks.forEach((block)=>{
    hljs.highlightBlock(block)
  })
})

Vue.prototype.$http=axios;
Vue.use(ElementUI);
Vue.config.productionTip = false



/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})
