<template>
<div>
  <el-form :inline="true">
    <el-form-item>
      <el-input v-model="search"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button @click="onSearch">查询</el-button>
    </el-form-item>
    <el-form-item>
      <el-button @click="onToArticle">新增</el-button>
    </el-form-item>
  </el-form>
  <el-table
  v-loading="loading"
    :data="skillData"
    style="width: 100%"
    size="medium"
    max-height="72vh"
    :default-sort = "{prop: 'date', order: 'descending'}"
    >
    <el-table-column type="selection" :show-overflow-tooltip="true"></el-table-column>
    <el-table-column
      prop="aid"
      label="ID"
      sortable
      >
    </el-table-column>
    <el-table-column
      prop="title"
      label="标题"
      sortable
     >
    </el-table-column>
    
    <el-table-column
      prop="img"
      label="缩略图"
      sortable
      >
    </el-table-column>
    
    <el-table-column
      prop="md"
      label="内容"
      >
    </el-table-column>
    <el-table-column
      prop="category"
      label="分类"
      :filters="[{ text: '一技之长', value: '一技之长' }, { text: '生活杂谈', value: '生活杂谈' }]"
      :filter-method="filterTag"
      >
    </el-table-column>
    <el-table-column
      prop="posted_time"
      label="日期"
      sortable
      >
    </el-table-column>
    <el-table-column label="操作">
      <template slot-scope="scope">
        <el-button
          size="mini"
          @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
        <el-button
          size="mini"
          type="danger"
          @click="handleDelete(scope.$index, scope.row)">删除</el-button>
      </template>
    </el-table-column>
  </el-table>
    <el-pagination
      style="text-align:right"
      :page-size="pageSize"
      :current-page="page"
      layout="prev, pager, next, jumper,sizes,total"
      :total="count"
      @current-change="toPage"
      @size-change="upPageSize"
      >
    </el-pagination>

    <!-- form -->
    <el-dialog title="编辑文章" :visible.sync="dialogFormVisible">
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
                <mavon-editor style="height: 100%" :value="form.md" v-on:change="gain" ref=md @imgAdd="$imgAdd" @imgDel="$imgDel" ></mavon-editor>
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
    </el-dialog>
</div>
</template> 
<script>
  import { mavonEditor } from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
export default {
  name:"skillList_acc",
  data(){
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
        img_file:{},

      dialogFormVisible: false,
      search:"",
      skillData:[],
      count:0,    //总条数
      page:1,     //第几页
      pageSize:10,  //每页条数
      loading:true,
    }
  },
  mounted:function(){
    this.$http.get(this.$store.state.hostaddr+'/account/classify.php').then((response)=>{
               this.classify=response.data;
            //    console.log(this.classify);
            })
    this.$http.get(this.$store.state.hostaddr+'/article/articleList.php?path=all&num=0').then((res)=>{
      console.log(res);
      this.skillData=res.data.data;
      this.count=parseInt(res.data.count[0]);
      this.loading=false;
    })
  },
  methods:{
    onToArticle(){
      this.$router.push('/account/article');
    },
    onSearch(){
      console.log("xxx");
    },
    handleEdit(index,row){
      console.log(row);
      this.dialogFormVisible = true;
      this.form.title=row.title,
      this.form.md=row.md,
      this.form.classify=row.category_id,
      this.form.imageUrl=row.img;
    },
    handleDelete(){

    },
    //分页
    toPage(page){
      this.loading=true;
      this.$http.get(this.$store.state.hostaddr+'/article/articleList.php?path=all&num='+(page-1)*this.pageSize+'&pageSize='+this.pageSize).then((res)=>{
        console.log(res);
        this.skillData=res.data.data;
        this.loading=false;
      })
    },
    upPageSize(pageSize){
      this.pageSize=pageSize;
      this.loading=true;
      this.$http.get(this.$store.state.hostaddr+'/article/articleList.php?path=all&num='+(this.page-1)*pageSize+'&pageSize='+pageSize).then((res)=>{
        console.log(res);
        this.skillData=res.data.data;
        this.loading=false;
      })
    },
    //分类筛选
    filterTag(value,row,column){
      return value==row.category;
    },
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
            if(!this.form.date) this.form.date=new Date().getTime();
            this.$http.post(this.$store.state.hostaddr+'/account/article.php?title='+encodeURIComponent(this.form.title)+'&md='+encodeURIComponent(this.form.md)+'&posted_time='+this.form.date+'&category_id='+this.form.classify+'&stick='+Number(this.form.stick)+'&accessory='+encodeURIComponent(this.form.imageUrl)).then((response)=>{
            console.log(response.data);
            if(response.data.code==1){
                this.$message({message: '发表成功',type: 'success'});
            }else{
                this.$message.error('发表失败'+response.data);
            }
            //location.assign("/home");
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
                if(response.data.code==1){
                    this.$message({message: '发表成功',type: 'success'});
                }else{
                    this.$message.error('发表失败'+response.data);
                }
                //location.assign("/home");
             })
            }else{
                this.$refs.upload.submit();     //触发预览图的图片上传
            }
            
        },
  },
  destroyed() {
    console.log('组件销毁');
  },
  components: {
      mavonEditor
    },
}
</script>
<style>
  .cell{
    max-height:100px;
    overflow: auto !important;
  }
  .el-upload img{
    max-width: 150px;
  }
</style>