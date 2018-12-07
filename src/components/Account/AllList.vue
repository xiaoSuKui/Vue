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
    :data="skillData"
    style="width: 100%"
    size="medium"
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
      prop="posted_time"
      label="日期"
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
      prop="md"
      label="内容"
      >
    </el-table-column>
    <el-table-column
      prop="category"
      label="分类"
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
      :page-size="10"
      :current-page="page"
      layout="prev, pager, next, jumper"
      :total="count"
      @current-change="toPage"
      @prev-click="prevPage"
      >
    </el-pagination>
</div>
</template> 
<script>
export default {
  name:"skillList_acc",
  data(){
    return {
      search:"",
      skillData:[],
      count:0,
      page:1,
    }
  },
  mounted:function(){
    this.$http.get(this.$store.state.hostaddr+'/article/articleList.php?path=all&num=0').then((res)=>{
      console.log(res);
      this.skillData=res.data.data;
      this.skillData.forEach((val,i)=>{
        val.md=val.md.slice(0,180)+'...';
      })
      this.count=parseInt(res.data.count[0]);
    })
  },
  methods:{
    onToArticle(){
      this.$router.push('/account/article');
    },
    onSearch(){
      console.log("xxx");
    },
    handleEdit(){

    },
    handleDelete(){

    },
    //分页
    toPage(page){
      this.$http.get(this.$store.state.hostaddr+'/article/articleList.php?path=all&num='+(page-1)*10).then((res)=>{
      console.log(res);
      this.skillData=res.data.data;
      this.skillData.forEach((val,i)=>{
        val.md=val.md.slice(0,180)+'...';
      })
    })
    },
    prevPage(page){
      console.log(page);
    }
  }
}
</script>
