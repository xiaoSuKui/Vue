<template>
    <el-container>
    <el-header>
            <div class="header">
                <!-- 折叠按钮 -->
                <div class="collapse-btn" @click="collapseChage">
                    <i class="el-icon-menu"></i>
                </div>
                <div class="logo">后台管理系统</div>
                <div class="header-right">
                    <div class="header-user-con">
                        <!-- 全屏显示 -->
                        <div class="btn-fullscreen" @click="handleFullScreen">
                            <el-tooltip effect="dark" :content="fullscreen?`取消全屏`:`全屏`" placement="bottom">
                                <i class="el-icon-rank"></i>
                            </el-tooltip>
                        </div>
                        <!-- 消息中心 -->
                        <div class="btn-bell">
                            <el-tooltip effect="dark" :content="message?`有${message}条未读消息`:`消息中心`" placement="bottom">
                                <router-link to="/tabs">
                                    <i class="el-icon-bell"></i>
                                </router-link>
                            </el-tooltip>
                            <span class="btn-bell-badge" v-if="message"></span>
                        </div>
                        <!-- 用户头像 -->
                        <div class="user-avator"><img src="static/img/img.jpg"></div>
                        <!-- 用户名下拉菜单 -->
                        <el-dropdown class="user-name" trigger="click" @command="handleCommand">
                            <span class="el-dropdown-link">
                                {{username}} <i class="el-icon-caret-bottom"></i>
                            </span>
                            <el-dropdown-menu slot="dropdown">
                                <a href="http://blog.gdfengshuo.com/about/" target="_blank">
                                    <el-dropdown-item>关于作者</el-dropdown-item>
                                </a>
                                <a href="https://github.com/lin-xin/vue-manage-system" target="_blank">
                                    <el-dropdown-item>项目仓库</el-dropdown-item>
                                </a>
                                <el-dropdown-item divided  command="loginout">退出登录</el-dropdown-item>
                            </el-dropdown-menu>
                        </el-dropdown>
                    </div>
                </div>
            </div>
    </el-header>
        <el-aside width="200px">
            <div class="sidebar">
                <el-menu default-active="1-4-1" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose" :collapse="isCollapse">
  <el-submenu index="1">
    <template slot="title">
      <i class="el-icon-location"></i>
      <span slot="title">导航一</span>
    </template>
    <el-menu-item-group>
      <span slot="title">分组一</span>
      <el-menu-item index="1-1">选项1</el-menu-item>
      <el-menu-item index="1-2">选项2</el-menu-item>
    </el-menu-item-group>
    <el-menu-item-group title="分组2">
      <el-menu-item index="1-3">选项3</el-menu-item>
    </el-menu-item-group>
    <el-submenu index="1-4">
      <span slot="title">选项4</span>
      <el-menu-item index="1-4-1">选项1</el-menu-item>
    </el-submenu>
  </el-submenu>
  <el-menu-item index="2">
    <i class="el-icon-menu"></i>
    <span slot="title">导航二</span>
  </el-menu-item>
  <el-menu-item index="3" disabled>
    <i class="el-icon-document"></i>
    <span slot="title">导航三</span>
  </el-menu-item>
  <el-menu-item index="4">
    <i class="el-icon-setting"></i>
    <span slot="title">导航四</span>
  </el-menu-item>
</el-menu>
            </div>
        </el-aside>
        <el-container>
            <el-main>
                <router-view></router-view>
            </el-main>
            <el-footer>Footer</el-footer>
        </el-container>
    </el-container>
    
</template>
<script>
 export default {
     data(){
         return{
             h:document.body.offsetHeight+'px'
         }
     },
     beforeCreate() {
         this.$http.get(this.$store.state.hostaddr+'/account/isLogin.php').then((res)=>{
             
             if(res.data.ok!=0){
                 console.log(res.data.ok);
             }else{
                // location.assign("/login");
                 alert("您没有权限进入此页面");
             }
         })
     },
     mounted:function(){
         this.h=document.body.offsetHeight+'px'
     }
 }
</script>
<style scoped>
.side{
    width:200px;
    float:left;
    background:#fff;
    border-right: 1px solid #e6e6e6;
}
.Amain{
    float:left;
    width:100%;
    height:100%;
    overflow:auto;
    margin-top:30px;
}
  /*.logo{
    height: 80px;
    overflow: hidden;
    clear: both;
    background: #E8F0E8 url(/static/images/00.png) scroll no-repeat;
    background-size: cover;
    -moz-background-size: cover;
    -webkit-background-size: cover;
  }*/
  .el-header{
      min-height:70px;
      padding:0;
  }
   .header {
        background:#242f42;
        position: relative;
        box-sizing: border-box;
        width: 100%;
        height: 70px;
        font-size: 22px;
        color: #fff;
    }
    .collapse-btn{
        float: left;
        padding: 0 21px;
        cursor: pointer;
        line-height: 70px;
    }
    .header .logo{
        float: left;
        width:250px;
        line-height: 70px;
    }
    .header-right{
        float: right;
        padding-right: 50px;
    }
    .header-user-con{
        display: flex;
        height: 70px;
        align-items: center;
    }
    .btn-fullscreen{
        transform: rotate(45deg);
        margin-right: 5px;
        font-size: 24px;
    }
    .btn-bell, .btn-fullscreen{
        position: relative;
        width: 30px;
        height: 30px;
        text-align: center;
        border-radius: 15px;
        cursor: pointer;
    }
    .btn-bell-badge{
        position: absolute;
        right: 0;
        top: -2px;
        width: 8px;
        height: 8px;
        border-radius: 4px;
        background: #f56c6c;
        color: #fff;
    }
    .btn-bell .el-icon-bell{
        color: #fff;
    }
    .user-name{
        margin-left: 10px;
    }
    .user-avator{
        margin-left: 20px;
    }
    .user-avator img{
        display: block;
        width:40px;
        height:40px;
        border-radius: 50%;
    }
    .el-dropdown-link{
        color: #fff;
        cursor: pointer;
    }
    .el-dropdown-menu__item{
        text-align: center;
    }
    .sidebar{
        display: block;
        position: absolute;
        left: 0;
        top: 70px;
        bottom:0;
        overflow-y: scroll;
    }
    .sidebar::-webkit-scrollbar{
        width: 0;
    }
    .sidebar-el-menu:not(.el-menu--collapse){
        width: 250px;
    }
    .sidebar > ul {
        height:100%;
    }
</style>
