<template>
  <div>
      <div class="header">
          <ul class="top-nav">
            <a>{{dictum}}</a>
          </ul>
      </div>
      <div class="logo" :style="{background:logoBG}"></div>
      <div class="nav" :style="{'background':navBG}">
        <!-- <ul>
          <a href="#/home">首页</a>
          <a href="#/skill">一技之长</a>
          <a href="#/selfTalk">前尘旧事</a>
          <a href="#/timeLine">逝者如斯</a>
          <a href="#/message">雁过留声</a>
          <a href="#/about">关于赵某</a>
        </ul> -->
      <el-menu :default-active="path" mode='horizontal' :background-color="navBG" :text-color="navTextColor" router @select="selectItems">
        <el-menu-item index='/home'>首页</el-menu-item>
        <el-menu-item index='/skill'>一技之长</el-menu-item>
        <el-menu-item index='/selfTalk'>生活杂谈</el-menu-item>
        <el-menu-item index='/idea'>每日一记</el-menu-item>
        <el-menu-item index='/timeLine'>时间轴</el-menu-item>
        <el-menu-item index='/message'>留言板</el-menu-item>
        <!-- <el-menu-item index='/about'>关于我</el-menu-item> -->
      </el-menu>
      
      </div>
     
  </div>
</template>
<script>
    export default{
      data(){
        return {
          path:this.$router.history.current.path,
          dictum:'', 
          logoBG:'url(/static/images/xia.jpg) scroll no-repeat center center',
          navBG:'#1bd1a5',
          navTextColor:'#fff'
        }
      },
      mounted:function(){
        //请求名言
            this.$http.get(this.$store.state.hostaddr+"/home/dictum.php").then((response)=>{
                this.dictum=response.data[0].content;
            });
        // //四季
        var month=parseInt(new Date().toLocaleDateString().slice(5,7));
        if(month==3||month==4||month==5){
          this.logoBG='url(/static/images/chun.jpg) scroll no-repeat center cente';
          this.navBG='#91d941';
          this.navTextColor='#fff';
          // console.log('春');
        }else if(month==6||month==7||month==8){
          this.logoBG='url(/static/images/xia.jpg) scroll no-repeat center cente';
          this.navBG='#1bd1a5';
          this.navTextColor='#fff';
          // console.log('夏');
        }else if(month==9||month==10||month==11){
          // console.log('秋');
          this.logoBG='url(/static/images/new_top-min.jpg) scroll no-repeat center center';
          this.navBG='#BFAB86';
          this.navTextColor='#fff';
        }else{
          // console.log('冬');
          this.logoBG='url(/static/images/dong.jpg) scroll no-repeat center center';
          this.navBG='#e3f9fd';
          this.navTextColor='#b0a4e3';
        }
      },
      methods:{
        // 在别的页面返回指定的路由地址时，更新导航栏path的状态
        getPath(){
          this.path=this.$store.state.path
        },
        // 菜单激活时的回调，把当前激活的菜单传给路由地址
        selectItems(index){
          this.$store.state.path=index
        }
      },
      watch:{
        // 监听路由地址的变化，变化时执行getPath
        '$store.state.path':'getPath'
      }
    }
</script>
<style>
  .nav>ul{
    width: 1000px;
    margin: auto;
  }
  .nav{
    width: 100%;
    background: #BFAB86;
    line-height: 47px;
  }
  .header{
    background: #f3f3f3;
    min-height: 30px;
    line-height: 30px;
    width: 100%;
  }
  .top-nav{
    width: 1000px;
    margin: auto;
    text-align: right;
  }
  .top-nav>a{
    margin-left: 20px;
    font-size:12px;
  }
  .top-nav>a:hover{
    text-decoration: none;
    color: #000;
  }
  .logo{
    margin-top:3px;
    height: 170px;
    overflow: hidden;
    clear: both;
    background: url(/static/images/new_top-min.jpg) scroll no-repeat center center;
    background-size: cover!important;
    -moz-background-size: cover;
    -webkit-background-size: cover;
  }
</style>
