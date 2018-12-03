<template>
  <el-table
    :data="skillData"
    style="width: 100%"
    size="medium"
    :default-sort = "{prop: 'date', order: 'descending'}"
    >
    <el-table-column
      prop="date"
      label="日期"
      sortable
      width="180">
    </el-table-column>
    <el-table-column
      prop="name"
      label="姓名"
      sortable
      width="180">
    </el-table-column>
    <el-table-column
      prop="address"
      label="地址"
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
      this.skillData=res;
    })
  }
}
</script>
