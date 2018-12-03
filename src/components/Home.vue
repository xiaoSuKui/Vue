<template>
  <div>
      <div class="banner">
                <el-carousel :interval="8000" height="260px">
                    <el-carousel-item v-for="val in banner" :key="val.length">
                        <a :href="val.href">
                            <img :src="'/static/'+val.path">
                        </a>
                    </el-carousel-item>
                </el-carousel>
        </div>
            <h2>
                <span>
                    共({{$store.state.count}})篇文章&nbsp;&nbsp;
                </span>
                最新文章
            </h2>
            <ArticleList></ArticleList>
        </div>
</template>
<script>
    import ArticleList from '@/components/ArticleList'
    export default{
        components:{
            ArticleList:ArticleList
        },
        data(){
            return {
                banner:{},
                path:this.$router.history.current.path,
                
            }
        },
        mounted:function(){
            //请求轮播图片
            this.$http.get(this.$store.state.hostaddr+"/home/banner.php").then((response)=>{
                this.banner=response.data;
            });
            
        },
        methods:{
            new_href(e){
                e.preventDefault();
                this.href=e.target.attributes[1].value;
                    //this.$store.state.path=e.target.attributes[1].value;
                this.$store.commit('path_up',e.target.attributes[1].value);
                this.$router.push(e.target.attributes[1].value);
            }
        }
    }
</script>
<style scoped>
h2>span{
float: right;
font-size: 12px;
font-weight: normal;
}
h2>span>a{
    display: inline-block;
    padding: 0 5px;
}

h2{
font-size: 16px;
font-weight: bold;
line-height: 36px;
color: #333;
border-bottom: #db6d4c 4px solid;
}
.banner{
    height: 280px;
    width: 670px;
    overflow: hidden;
    z-index: 0;
}
</style>
