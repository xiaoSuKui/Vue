<template>
  <div>
      <Header></Header>
      <div class="main clear">
        <div class="m_left">
            <router-view></router-view>
        </div>
        <div class="m_right">
            <div class="about">
                <h3>关注我</h3>
                <ul  style="list-style:none;">
                    <li><a target="_blank" href="https://weibo.com/p/1005052798944913/home?from=page_100505&mod=TAB&is_all=1#place" class="xlwb">新浪微博</a></li>
                    <li><a href="tencent://message/?uin=1787600886&amp;Site=有事Q我&amp;Menu=yes" class="txwb">腾讯QQ</a></li>
                    <li><a href="mailto:1787600886@qq.com" class="yx">邮箱</a></li>
                    <!-- <li><a href="#" class="feedback">WeChat</a></li> -->
                </ul>
            </div>
            <div class="hot">
                <h3>热门文章</h3>
                <ul style="list-style:none;" v-for="val in hot" :key="val.length">
                    <li><a target="_blank" :href="'/article/'+val.aid">{{val.title}}</a></li>
                </ul>
            </div>
            <div class="links">
                <h3>友情链接</h3>
                <ul  style="list-style:none;">
                    <li v-for="val in links"  :key="val.length"><a :href="val.href" target="_blank">{{val.bname}}</a></li>
                </ul>
            </div>
        </div>
      </div>

      <!-- 返回顶部 -->
      <el-button @click="toTop"  icon="el-icon-arrow-up" circle class="toTop"></el-button>
  </div>
</template>
<script>
    import Header from '@/components/Header'
    export default{
        components:{
            Header:Header
        },
        data(){
            return{
                links:{},
                hot:[]
            }
        },
        mounted:function(){
             //请求友情链接
            this.$http.get(this.$store.state.hostaddr+"/home/blogroll.php").then((response)=>{
                this.links=response.data;
            });
            //请求热门文章
            this.$http.get(this.$store.state.hostaddr+"/home/hot.php").then((response)=>{
                this.hot=response.data;
            })
        },
        methods:{
            toTop(){
                document.documentElement.scrollTop=0
            }
        }
    }
</script>
<style>
.toTop{
    position: fixed;
    bottom:50px;
    right:50px;
    z-index: 100;
}
.hot>ul{
    margin: 10px 0;
}
.hot>ul>li{
    height: 25px;
    line-height: 25px;
    clear: both;
    overflow: hidden;
    padding-left: 15px;
    background: url(/static/images/li.jpg) no-repeat left center;
}
.xlwb {
    background: url(/static/images/ico.png) no-repeat -216px -138px ;
}
.txwb {
    background: url(/static/images/ico.png) no-repeat -30px -23px;
}
.yx {
    background: url(/static/images/ico.png) no-repeat -310px -242px;
}
.feedback {
    background: url(/static/images/ico.png) no-repeat -30px -137px;
}
.m_right>.about ul {
    width: 100%;
    margin: 30px 0;
    overflow: hidden;
}
.m_right>.about li {
    width: 52px;
    margin: 0 18px 0 5px;
    float: left;
}
.m_right>.about li a {
    color: #747F8C;
    width: 52px;
    text-align: center;
    padding-top: 60px;
    float: left;
}
.m_right>.about h3,.m_right>.hot h3,.m_right>.links h3 {
    line-height: 40px;
    color: #38485A;
    font-size: 18px;
    border-bottom: 1px solid #E6E6E6;
    height: 40px;
}
.links h3{
    margin-bottom: 20px;
}
.links ul {
    background: #fff;
    padding: 10px;
    overflow: hidden;
    border: #e9e9e9 1px solid;
}
.links ul li {
    float: left;
    padding: 5px 8px;
}
a:hover{
    text-decoration: none;
    color: #666;
}
.main{
    width: 1000px;
    margin: 20px auto;
}
.main>.m_left{
    width: 670px;
    float: left;
}
.main>.m_right{
    width:300px;
    float:right;
}
</style>
