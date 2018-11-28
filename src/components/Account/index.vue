<template>
    <div>
      <div class="logo"></div>
        <div class="side" :style="{height:h}">
            <el-menu
                default-active="1-1"
                class="el-menu-vertical-demo"
                unique-opened="false">
                <el-submenu index="1-1">
                    <template slot="title">
                    <i class="el-icon-location"></i>
                    <span>博客管理</span>
                    </template>
                    <el-menu-item-group>
                    <el-menu-item index="1-1">一技之长</el-menu-item>
                    <el-menu-item index="1-2">生活杂谈</el-menu-item>
                    <el-menu-item index="1-3">每日一记</el-menu-item>
                    </el-menu-item-group>
                </el-submenu>
                <el-menu-item index="2">
                    <i class="el-icon-menu"></i>
                    <span slot="title">账户管理</span>
                </el-menu-item>
                <el-menu-item index="3" disabled>
                    <i class="el-icon-document"></i>
                    <span slot="title">留言管理</span>
                </el-menu-item>
                <el-menu-item index="4">
                    <i class="el-icon-setting"></i>
                    <span slot="title">其他管理</span>
                </el-menu-item>
                </el-menu>
        </div>
        <div style="overflow:hidden;height:100%;">
            <div class="Amain">
                <router-view></router-view>
            </div>
        </div>
    </div>    
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
  .logo{
    height: 80px;
    overflow: hidden;
    clear: both;
    background: #E8F0E8 url(/static/images/00.png) scroll no-repeat;
    background-size: cover;
    -moz-background-size: cover;
    -webkit-background-size: cover;
  }
</style>
