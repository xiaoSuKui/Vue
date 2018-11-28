<template>
  <div>
      <h2>
           <span>
              <a href="javascript:;">共({{count}})篇日记&nbsp;&nbsp;</a>
           </span>
           每日一记
      </h2>

      <div class="mood" v-for="value in list" :key="value.length">
        <div><img style="display:inline-block;width:34px;height:34px;" :src="'https://cdn.heweather.com/cond_icon/'+value.cond_code+'.png'"></img><span style="display:inline-block;position:relative;bottom:10px;left:5px;">{{value.title}}</span></div>
		<!--内容区-->
		<div style="margin-left:40px;border:none;margin-right: 10px;margin-bottom:10px;" v-html="value.content">
		</div>
        <div class="images" v-if="value.img">
			<img v-for="image in value.img.split(',')" :src="image" width="33.3333%">
		</div>
		<!--页脚，放置补充信息或支持的操作-->
		<div style="font-size:11px;padding-bottom:0;text-align:right;position:relative;left:66px;">{{value.posted_time}} {{value.weather}} 发表于{{value.posted_site}} </div>
      </div>
      <h1 style="textalign:center" v-if="no">没有更多日记加载了...</h1>
  </div>
</template>
<script>
import 'mavon-editor/dist/css/index.css'
import axios from 'axios'
    export default{
        data(){
            return{
                list:[],
                num:0,
                no:false,
                count:0
            }
        },
        mounted:function(){
            this.$http.get(this.$store.state.hostaddr+"/article/ideaList.php?num=0").then((response)=>{
                
                // response.data.forEach((val,i)=>{
                //     console.log(val.content);
                //     val.content=val.content.replace(/\r\n/ig, "<br>");
                // })
                this.list=response.data.data;
                this.count=response.data.count[0];
                console.log(this.list);
            }); 
            // 设置一个开关来避免重负请求数据
            let sw = true;
            window.addEventListener('scroll',()=>{
                // 判断是否滚动到底部
                if(document.documentElement.scrollTop + window.innerHeight >= document.body.offsetHeight-20) {
                    if(sw==true&&(this.no==false)){
                        sw = false;
                         this.num+=10;
                        axios.get(this.$store.state.hostaddr+"/article/ideaList.php?num="+this.num).then((response)=>{
                        if(response.data.data==""){
                            this.no=true;
                        }
                        (response.data.data).forEach((val,index)=>{
                            this.list.push(val);
                        })
                        sw = true;
                    });
                    }
                   
                }
            })  
        }
    }    
</script>
<style>
 h2 {
    font-size: 16px;
    font-weight: bold;
    line-height: 36px;
    color: #333;
    border-bottom: #db6d4c 4px solid;
}
h2 span {
    float: right;
    font-size: 12px;
    font-weight: normal;
}
h2 span a {
    display: inline-block;
    padding: 0 5px;
}

.mood {
    width: 570px;
    background: #fafafa;
    border: 1px solid #e0e0e0;
    color: #4d4d4d;
    line-height: 22px;
    padding-top: 10px;
    padding-left: 20px;
    padding-right: 77px;
    padding-bottom: 7px;
    margin-bottom: 10px;
    border-radius: 5px;
    position:relative;
}
.images>img{
    vertical-align: middle;
}
</style>
