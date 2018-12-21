<template>
    <div>
        <el-form ref="form" :model="form" label-width="80px" size="mini">
            <el-form-item label="文章标题" style="width:300px;">
                <el-input autofocus="autofocus" v-model="form.title"></el-input>
            </el-form-item>
            <el-form-item label="缩略图">
                <el-upload
                ref="upload"
                class="avatar-uploader"
                :multiple="false"
                :limit=2
                accept="image/*"
                :on-exceed="onExceed"
                :action="$store.state.hostaddr+'/uploadImg.php'"
                :auto-upload="false"
                :on-change="imgurl"
                :file-list="updateImgList"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload">
                <img v-if="form.imageUrl" :src="form.imageUrl" class="avatar">
                <i v-else class="el-icon-plus avatar-uploader-icon" slot="trigger" type="primary"></i>
                </el-upload>
            </el-form-item>
            <el-form-item label="文章内容">
                <div id="editor">
                    <mavon-editor style="height: 100%" :value="form.md" v-on:change="gain" @save="mdSave" ref=md @imgAdd="$imgAdd" @imgDel="$imgDel" ></mavon-editor>
                </div>
            </el-form-item>
            <el-form-item label="发表时间">
                <el-date-picker
                    v-model="form.date"
                    type="datetime"
                    placeholder="默认提交当前时间为发表时间">
                </el-date-picker>
            </el-form-item>
            <el-form-item label="所属分类">
                <el-select v-model="form.classify">
                    <el-option v-for="item in classify" :key="item.cid"  :label="item.cname" :value="item.cid" ></el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="是否置顶">
                <el-switch
                    v-model="form.stick"
                    active-color="#13ce66"
                    inactive-color="#ff4949">
                </el-switch>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="onSubmit">提交</el-button>
            </el-form-item>
        </el-form>
        <!-- <button @click="onClick">click me</button> -->
    </div>
</template>
<script>
import { mavonEditor } from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
import axios from 'axios'
export default {
    name:"article_acc",
    props:['list_msg'],     //从列表页传来的数据
     data() {
      return {
        form: {
            title:'',
            md:"",
            date:"",
            classify:"1",   
            stick:0,
            imageUrl: '',
            aid:0,
        },
        updateImgList:[],   //上传图片列表
        classify:[],    //分类列表数据
        img_file:{},
        timer:"",       //定时保存 的 定时器
      }
    },
    created:function(){
        //console.log(this.list_msg);
        if(this.list_msg!=undefined){   //点列表页编辑会执行
            this.form.title=this.list_msg.title,
            this.form.md=this.list_msg.md,
            this.form.classify=this.list_msg.classify,
            this.form.imageUrl=this.list_msg.imageUrl,
            this.form.stick=this.list_msg.stick,
            this.form.aid=this.list_msg.aid;
        }else if(window.localStorage.blog_md){  //localstarg里面有数据会执行
            console.log(window.localStorage.blog_md);
            if(window.localStorage.blog_md.length>50){
                this.$confirm('检测到上次在本电脑有未保存文章,是否加载?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning',
                center:true
                }).then(() => {
                    this.$message({
                            type: 'success',
                            message: '已加载上次数据'
                        });
                    this.form.md=window.localStorage.blog_md;
                }).catch(() => {
                        this.$message({
                            type: 'info',
                            message: '已取消加载上次数据'
                        });
                })
            }
        }
        this.timer="";
        this.timer=window.setInterval(()=>{
            window.localStorage.blog_title=this.form.title;
            window.localStorage.blog_md=this.form.md;
        }, 1000*60*5);
    },
    methods: {
        mdSave(val,render){
            window.localStorage.blog_title=this.form.title;
            window.localStorage.blog_md=val;
        },
        imgurl(file,filelist){
            console.log(file);
            this.form.imageUrl=file.url;
            if(filelist.length>1){
                filelist.pop();
            }
        },
         // 绑定@imgAdd event
        $imgAdd(pos, $file){
            
            // 第一步.将图片上传到服务器.
           var formdata = new FormData();
           formdata.append('image', $file);
           axios({
               url:this.$store.state.hostaddr+'/uploadImg.php',
               method: 'post',
               data: formdata,
               headers: { 'Content-Type': 'multipart/form-data' },
           }).then((url) => {
               // 第二步.将返回的url替换到文本原位置![...](0) -> ![...](url)
               // $vm.$img2Url 详情见本页末尾
               console.log(url);
               this.$refs.md.$img2Url(pos, url.data);
           })
        },
        $imgDel(pos){
            delete this.img_file[pos];
        },
        up(file){
            this.$refs.upload.submit();
        },
        //超出上传文件个数
        onExceed(file,filelist){
            
            filelist.push(file);
            //filelist=[];
            //console.log(file,filelist);
            //filelist[0]=file[0];
        },
        handleAvatarSuccess(res, file,$e) {
            console.log(this.$refs.upload);
            this.form.imageUrl = res;
            //this.i=false;
            if(!this.form.date) this.form.date=new Date().getTime();
            this.$http.post(this.$store.state.hostaddr+'/account/article.php?title='+encodeURIComponent(this.form.title)+'&md='+encodeURIComponent(this.form.md)+'&posted_time='+this.form.date+'&category_id='+this.form.classify+'&stick='+Number(this.form.stick)+'&accessory='+encodeURIComponent(this.form.imageUrl)+(this.form.aid==0?'':'&aid='+encodeURIComponent(this.form.aid))).then((response)=>{
            console.log(response.data);
            if(response.data.code==1){
                this.$message({message: response.data.msg,type: 'success'});
                this.form={
                        title:'',
                        md:"",
                        date:"",
                        classify:"1",   
                        stick:0,
                        imageUrl: '',
                        aid:0,
                    };
                this.$store.state.dialogFormVisible = false;    //关闭列表页遮罩
                this.$refs.upload.$data.uploadFiles.pop();  //移除上次添加的图片
                //清除保存在storg里的数据和定时器
                window.localStorage.removeItem("blog_md");  
                    this.timer="";
                    window.localStorage.removeItem("blog_title"); 
            }else{
                this.$message.error(response.data);
            }
            //location.assign("/home");
            })
        },
        beforeAvatarUpload(file) {
           // const isJPG = file.type === 'image/*';
            const isLt10M = file.size / 1024 / 1024 < 10;

            // if (!isJPG) {
            // this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
            // }
            if (!isLt10M) {
            this.$message.error('上传头像图片大小不能超过 10MB!');
            }
            return isLt10M;
        },
        //md编辑器内容
        gain(value,reder){
            this.form.md=value;
        },
        onSubmit() {
            if(!this.form.date) this.form.date=new Date().getTime();
            if(this.$refs.upload.$data.uploadFiles.length==0){
                this.$http.post(this.$store.state.hostaddr+'/account/article.php?title='+encodeURIComponent(this.form.title)+'&md='+encodeURIComponent(this.form.md)+'&posted_time='+this.form.date+'&category_id='+this.form.classify+'&stick='+Number(this.form.stick)+'&accessory='+encodeURIComponent(this.form.imageUrl)+(this.form.aid==0?'':'&aid='+encodeURIComponent(this.form.aid))).then((response)=>{
                console.log(response.data);
                if(response.data.code==1){
                    this.$message({message: response.data.msg,type: 'success'});
                    this.form={
                        title:'',
                        md:"",
                        date:"",
                        classify:"1",   
                        stick:0,
                        imageUrl: '',
                        aid:0,
                    };
                    this.$store.state.dialogFormVisible = false;
                    window.localStorage.removeItem("blog_md");
                    this.timer="";
                    window.localStorage.removeItem("blog_title");  
                }else{
                    this.$message.error(response.data);
                }
                
                //location.assign("/home");
             })
            }else{
                this.$refs.upload.submit();     //触发预览图的图片上传
            }
            
        },
    }, 
    components: {
      mavonEditor
    },
    mounted:function(){
        this.$http.get(this.$store.state.hostaddr+'/account/classify.php').then((response)=>{
               this.classify=response.data;
            //    console.log(this.classify);
        })
    },
    destroyed() {
        console.log("组件销毁");
    },
  }
</script>
<style scoped>
#editor {
    height: 580px;
  }
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
  .el-upload{
      border: 2px dotted #FFFFFF;
  }
</style>
