<template>
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
  </el-table>
</template> 
<script>
export default {
  name:"skillList_acc",
  data(){
    return {
      skillData:[]
    }
  },
  mounted:function(){
    this.$http.get(this.$store.state.hostaddr+'/article/articleList.php?path=/skill&num=0').then((res)=>{
      console.log(res);
      this.skillData=res.data.data;
    })
  }
}
</script>
