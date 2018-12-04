<template>
  <div id="app" :style="{'background':bgcolor}">
		<link href="//cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
		
    <router-view/>
  </div>
</template>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.js"></script>
<script>
export default {
	name: 'App',
	data(){
        return {
					//  bgcolor:'#f5ffff'
					 bgcolor:'#e5fefe'
        }
  },
	mounted:function(){
		//四季   #f2ffeb   #eafad0
        var month=parseInt(new Date().toLocaleDateString().slice(5,7));
        if(month==3||month==4||month==5){
          this.bgcolor='#f2ffeb';
        }else if(month==6||month==7||month==8){
					this.bgcolor='#e5fefe';
        }else if(month==9||month==10||month==11){
					this.bgcolor='#fffbf0';
        }else{
					this.bgcolor='#f0fcff';
        }
	}
}

</script>

<style>

/* #app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
} */

/* base */
html,dd,dl,p,img,h1,h2,h3,h4,h5,h6,figure{
	margin:0;
	padding:0;
	list-style:none;
}
#app{
	height:100%;
}
.main{
	width:1200px;
	margin:0 auto;
	position:relative;
}

a{
	text-decoration:none;
	font-size:12px;
}
img{
	vertical-align:bottom;
}
.clear:after{
	content:"";
	display:block;
	clear:both;
}
</style>
