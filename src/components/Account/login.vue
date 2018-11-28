<template>
  <el-form   class="demo-ruleForm login-container">
    <h3 class="title">系统登录</h3>
    <el-form-item>
      <el-input type="text"  placeholder="账号" v-model="id"></el-input>
    </el-form-item>
    <el-form-item>
      <el-input type="password"  placeholder="密码" v-model="pwd"></el-input>
    </el-form-item>
    <el-form-item style="width:100%;">
      <el-button type="primary" style="width:100%;" @click="register" >登录</el-button>
    </el-form-item>
    <img src="/static/images/login_x.gif" width="100%">
  </el-form>
</template>

<script>

  export default {
    data() {
      return {
        id:'',
        pwd:'',
      };
    },
    methods: {
     register(){
        var formdata = new FormData();
        formdata.append('uname',this.id);
        formdata.append('upwd',this.pwd);
       if(this.id&&this.pwd){
         this.$http.post(this.$store.state.hostaddr+'/account/login.php',formdata).then((res)=>{
           console.log(res);
           if(res.data.code==1){
              sessionStorage.setItem("uid",res.data.uid);
              sessionStorage.setItem("uname",'admin');
              location.assign("/account");
           }else{
             alert("用户名或密码不正确");
           }
         })
       }else{
         alert("请输入账号或密码");
       }
     }
    }
  }

</script>

<style scoped>
  .login-container {
    height:100vh;
    /*box-shadow: 0 0px 8px 0 rgba(0, 0, 0, 0.06), 0 1px 0px 0 rgba(0, 0, 0, 0.02);*/
    -webkit-border-radius: 5px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    background-clip: padding-box;
    margin: 0px auto;
    width: 350px;
    padding: 35px 35px 15px 35px;
    background: #fff;
    border: 1px solid #eaeaea;
    box-shadow: 0 0 25px #cac6c6;
    .title {
      margin: 0px auto 40px auto;
      text-align: center;
      color: #505458;
    }
    .remember {
      margin: 0px 0px 35px 0px;
    }
  }
</style>