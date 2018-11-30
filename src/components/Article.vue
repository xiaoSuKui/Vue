<template>
    <div>
        <!-- 导航条 -->
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/' }" @click.native="$store.commit('path_up','/home')">首页</el-breadcrumb-item>
            <el-breadcrumb-item :to="{path:article.category=='一技之长'?'/skill':'/selfTalk'}" @click.native="$store.commit('path_up',(article.category=='一技之长'?'/skill':'/selfTalk'))">{{article.category}}</el-breadcrumb-item>
            <el-breadcrumb-item>{{article.title}}</el-breadcrumb-item>
        </el-breadcrumb>
        <div class="news_title">{{article.title}}</div>
        <div class="news_author">
	  		<span class="au01">{{article.uname}}</span>
	  		<span class="au02">{{article.posted_time}}</span>
	  	</div>
          <!-- 文章内容 -->
        <div class="article " style="overflow:hidden;" v-html="Mark.render(article.md)">
        </div>
        <!-- 版权 -->
        <div class="copyright_author">
			<p><strong>版权声明：</strong>本站原创文章，于{{article.posted_time}}，由<a href="javascript:;" target="_blank" style="font-size:14px;">{{article.uname}}</a>发表</p>
			<p class="p-hidden"><strong>转载请注明：</strong><a href="javascript:;" target="_self">{{article.title}}</a> | <a href="javascript:;">赵恒盛的博客</a></p>
		</div>
        <!-- 打赏 -->
        <div align="center" style="width: 99%; display: block; padding: 10px 0; color: forestgreen; border: 1px solid #f2f2f2; background-color: #fff; height: 220px;">
            <div style="width: 48%; float: left; height: 220px;">
                  <img src="/static/images/zfbhb.jpg" alt="yezismile wechat" style="width: 150px; max-width: 100%;">
            </div>
            <div style="width: 48%; float: left;">
				<img src="/static/images/wxgzh.jpg" alt="yezismile wechat" style="width: 200px; max-width: 100%;">
			    <div>欢迎关注我的公众号</div>
            </div>
            <div style="clear:both;"></div>
		</div>
        <mavon-editor style="height:0;width:0;display:none"></mavon-editor>
        <!-- 评论 -->
        <Message></Message>
    </div>
</template>
<script>
import { mavonEditor } from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
import Message from '@/components/Message'
    export default{
        data(){
            return {
                article:[],
                result:'',
                Mark:''
            }
        },
        mounted:function(){
            this.$http.get(this.$store.state.hostaddr+'/article/article.php?aid='+this.$route.params.aid).then((response)=>{
               this.article=response.data[0];
                document.title=this.article.title;
                this.Mark = mavonEditor.getMarkdownIt();
            });
            
        },
        components: {
            mavonEditor,
            Message
        },
        methods:{
           
        },
        beforeDestroy:function(){
            document.title="赵恒盛的个人博客";
        }
    }
</script>

<style>
.article ul,.article ol{
    margin:fgdf;
    padding-left:40px;
}
.news_title {
    font-size: 24px;
    font-weight: 400;
    padding: 20px 0 10px 0;
    color: #38485A;
}
.news_author {
    width: 100%;
    color: #999999;
    line-height: 18px;
    margin-bottom:10px;
}
.news_author span {
    margin-right: 20px;
    padding-left: 20px;
    font-size:13px;
}
.au01 {
    background: url(/static/images/author2.png) no-repeat left center;
}
.au02 {
    background: url(/static/images/date.png) no-repeat left center;
}
.article {
    line-height: 24px;
    font-size: 14px;
}
.copyright_author {
    background: #f3f3f3;
    border: #e9e9e9 1px solid;
    margin-bottom: 20px;
    color: #a0a0a0;
    padding: 25px 20px;
}
#cyReward .cy-reward-btn-red {
    background-position: 0 0;
}
#cyReward .cy-reward-btn {
    width: 134px;
    height: 49px;
    display: inline-block;
    background-image: url(/static/images/all-btn.png);
    background-repeat: no-repeat;
    background-position: 0 -196px;
    background-color: none;
    border: 0;
    cursor: pointer;
}
#cyReward #cy-reward-pop {
    width: 548px;
    height: 548px;
    border: 1px solid #e9e9e9;
    border-radius: 8px;
    position: fixed;
    box-shadow: 0 0 5px #999;
    top: 50%;
    left: 50%;
    margin-left: -274px;
    margin-top: -274px;
    display: none;
    background: #FFF;
    z-index: 9999;
}
</style>
