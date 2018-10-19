// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from 'axios'
import store from './vuex/store'
// 添加自定义过滤器
import * as filters from './filters/'
Object.keys(filters).forEach((key)=>{
  Vue.filter(key,filters[key]);
});

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
