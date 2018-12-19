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
    height="72vh"
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
    
    <el-dialog title="编辑文章" @close="clo" :visible.sync="dialogFormVisible">
      <AccountArticle v-if="hackReset" :list_msg="form"></AccountArticle>
    </el-dialog>
</div>
</template> 
<script>
import AccountArticle from '@/components/Account/article'
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
            aid:0,
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
      hackReset:true,
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
     // console.log(row);
     this.hackReset=true;
      this.dialogFormVisible = true;
      this.form.title=row.title,
      this.form.md=row.md,
      this.form.classify=row.category_id,
      this.form.imageUrl=row.img,
      this.form.aid=row.aid;
    },
    clo(){
      this.hackReset=false;
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
  },
  destroyed() {
    console.log('组件销毁');
  },
  components: {
      AccountArticle
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