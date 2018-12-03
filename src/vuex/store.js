import Vue from 'vue'
import Vuex from 'vuex' 
Vue.use(Vuex)


const state={
    // 导航地址、
    path:'/home',
    // 服务器地址
    hostaddr:'http://zhaohs.cn/data',
    count:0,        //文章总数
}
const mutations={
    // 改变/更新导航地址调用的方法
    path_up(state,p){
        if(p=="一技之长") p='/skill';
        if(p=="生活杂谈") p='/selfTalk';
        state.path=p
    }
}

export default new Vuex.Store({
    state,
    mutations
})