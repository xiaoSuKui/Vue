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
  </el-table>
    <el-pagination
      style="text-align:right"
      :page-size="10"
      layout="prev, pager, next, jumper"
      :total="count">
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
    }
  },
  mounted:function(){
    this.$http.get(this.$store.state.hostaddr+'/article/articleList.php?path=all&num=0').then((res)=>{
      console.log(res);
      this.skillData=res.data.data;
      this.count=parseInt(res.data.count[0]);
    })
  },
  methods:{
    onToArticle(){
      this.$router.push('/account/article');
    },
    onSearch(){
      console.log("xxx");
    }
  }
}
</script>
