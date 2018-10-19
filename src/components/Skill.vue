<template>
  <div>
      <h2>
           <span>
              <a href="javascript:;">共(50)篇文章&nbsp;&nbsp;</a>
           </span>
           一技之长
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
        mounted:function(){
            
        }
    }
</script>
<style scoped>
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
a:link, a:visited,a:hover {
    text-decoration: none;
    color: #666;
}
</style>
