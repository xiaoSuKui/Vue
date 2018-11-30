<template>
  <div class="article">
                <div class="blogs" v-for="value in articleList" :key="value.length">
                    <figure>
                        <a :href="'/article/'+value.aid" @click="new_href($event,value.category)">
                            <img :src="(value.img==''||null?'/static/images/No_pictures.png':value.img)" alt="xxx" style="width: 167.5px; height: 137px; display: block;">
                        </a>
                    </figure>
                    <div style="min-height:140px;">
                        <h3 style="margin-bottom:0;"><a :href="'/article/'+value.aid" @click="new_href($event,value.category)">{{value.title}}</a></h3>
                        <a :href="'/article/'+value.aid" @click="new_href($event,value.category)"><p style="color:#747F8C;">{{MarkdownIt.render(value.md).replace(/<.*?>/ig,'').slice(0,128)+"..."}}</p></a>
                        <div class="message" style="position:absolute;bottom:34px;">
                            <ul style="padding-left:0;">
                                <el-tag size="small">{{value.category}}</el-tag>
                                <b class="read"><a><i class="el-icon-tickets"></i> 浏览量({{value.pageView}})</a></b>
                                <b class="time"><a><i class="el-icon-time"></i> {{value.posted_time}}</a></b>
                            </ul>
                        </div>
                    </div>
                </div>
                <h1 style="textalign:center" v-if="no">没有更多文章加载了...</h1>
    </div>
</template>
<script>
import axios from 'axios'
import { mavonEditor } from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
    export default{
        data(){
            return {
                articleList:{},
                num:0,
                no:false,
                MarkdownIt:''
            }
        },
        mounted:function(){
            this.$http.get(this.$store.state.hostaddr+"/article/articleList.php?num=0&path="+this.$router.history.current.path).then((response)=>{
                //response=JSON.parse(response);
                this.articleList=response.data;
                this.MarkdownIt = mavonEditor.mixins[0].data().markdownIt;
                console.log(this.articleList);
                //this.articleList.html=MarkdownIt.render(this.articleList.md);
                console.log(this.articleList.html);
            });
            // 设置一个开关来避免重负请求数据
            let sw = true;
            window.addEventListener('scroll',()=>{
                // 判断是否滚动到底部
                if(document.documentElement.scrollTop + window.innerHeight >= document.body.offsetHeight-20) {
                    if(sw==true&&(this.no==false)){
                        sw = false;
                         this.num+=10;
                        axios.get(this.$store.state.hostaddr+"/article/articleList.php?num="+this.num+"&path="+this.$router.history.current.path).then((response)=>{
                           // response=JSON.parse(response);
                        if(response.data==""){
                            this.no=true;
                        }
                        (response.data).forEach((val,index)=>{
                            this.articleList.push(val);
                        })
                        sw = true;
                    });
                    }
                   
                }
            })
        },
        methods:{
            new_href(e,c){
                e.preventDefault();
                console.log(e.currentTarget);
                var href=e.currentTarget.href.slice(e.currentTarget.href.indexOf("/",9));
                    //this.$store.state.path=e.target.attributes[1].value;
                 this.$store.commit('path_up',c);
                 this.$router.push(href);
            }
        }
    }
</script>
<style>
@import '../assets/css/list.css';
</style>
