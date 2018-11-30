<template>
    <div>
        <el-form ref="form" :model="form" label-width="80px" size="mini">
            <el-form-item label="文章标题" style="width:300px;">
                <el-input v-model="form.title"></el-input>
            </el-form-item>
            <el-form-item label="缩略图">
                <el-upload
                ref="upload"
                class="avatar-uploader"
                :action="$store.state.hostaddr+'/uploadImg.php'"
                :auto-upload="false"
                :on-change="imgurl"
                :show-file-list="false"
                :on-success="handleAvatarSuccess"
                :before-upload="beforeAvatarUpload">
                <img v-if="form.imageUrl" :src="form.imageUrl" class="avatar">
                <i v-else class="el-icon-plus avatar-uploader-icon" slot="trigger" type="primary"></i>
                </el-upload>
            </el-form-item>
            <el-form-item label="文章内容">
                <div id="editor">
                    <mavon-editor style="height: 100%" v-on:change="gain" ref=md @imgAdd="$imgAdd" @imgDel="$imgDel" ></mavon-editor>
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
    </div>
</template>
<script>
import { mavonEditor } from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
import axios from 'axios'
export default {
     data() {
      return {
        form: {
            title:'',
            md:"",
            
            date:"",
            classify:"1",
            stick:0,
            imageUrl: '',
        },
        classify:[],
        i:true,
        img_file:{}
      }
    },
    methods: {
        imgurl(file,filelist){
            if(this.i){
                this.form.imageUrl=file.url;
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
        handleAvatarSuccess(res, file,$e) {
            console.log(this.$refs.upload);
            this.form.imageUrl = res;
            this.i=false;
            this.$http.post(this.$store.state.hostaddr+'/account/article.php?title='+encodeURIComponent(this.form.title)+'&md='+encodeURIComponent(this.form.md)+'&posted_time='+this.form.date+'&category_id='+this.form.classify+'&stick='+Number(this.form.stick)+'&accessory='+encodeURIComponent(this.form.imageUrl)).then((response)=>{
                console.log(response.data);
                location.assign("/home");
             })
        },
        beforeAvatarUpload(file) {
            const isJPG = file.type === 'image/jpeg'||'image/png';
            const isLt2M = file.size / 1024 / 1024 < 2;

            if (!isJPG) {
            this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
            }
            if (!isLt2M) {
            this.$message.error('上传头像图片大小不能超过 2MB!');
            }
            return isJPG && isLt2M;
        },
        gain(value,reder){
            this.form.md=value;
            
        },
        onSubmit() {
            if(!this.form.date) this.form.date=new Date().getTime();
            if(this.$refs.upload.$data.uploadFiles.length==0){
                this.$http.post(this.$store.state.hostaddr+'/account/article.php?title='+encodeURIComponent(this.form.title)+'&md='+encodeURIComponent(this.form.md)+'&posted_time='+this.form.date+'&category_id='+this.form.classify+'&stick='+Number(this.form.stick)+'&accessory='+encodeURIComponent(this.form.imageUrl)).then((response)=>{
                console.log(response.data);
                location.assign("/home");
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
    }
  }
</script>
<style>
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
</style>
