<template>
  <div>
      <timeline>
        <timeline-title>2018</timeline-title>
        <timeline-item v-for="value in line" :key="value.length" bg-color="#9dd8e0"><a :href="'/article/'+value.aid">{{value.title}}</a><span>{{value.posted_time.slice(5)}}</span></timeline-item>
    </timeline>
  </div>
</template>
<script>
import { Timeline, TimelineItem, TimelineTitle } from 'vue-cute-timeline'
  export default{
      data(){
          return {
              line:[]
          }
      },
      mounted:function(){
            this.$http.get(this.$store.state.hostaddr+"/timeLine/time.php?num=0").then((response)=>{
                this.line=response.data;
            });
      },
      components: {
        Timeline,
        TimelineItem,
        TimelineTitle
    }
  }
</script>
<style>
 .timeline-item>a{
    position: absolute;
    left:0;
}
.timeline-item{
    position: relative;
    text-align: right;
} 
.box{
  margin: 20px 0;
}
.event_year {
    width: 60px;
    border-bottom: 2px solid #DDD;
    text-align: center;
    position:fixed;
    left:150px;
    margin-top: 10px;
}
.event_year li.current {
    width: 50px;
    background: #db6d4c url(/static/images/jian.png?v=1.5) 60px 0 no-repeat;
    color: #FFF;
    text-align: left;
    padding-left: 9px;
}
.event_year li {
    height: 40px;
    line-height: 40px;
    background: #FFF;
    margin-bottom: 1px;
    font-size: 18px;
    color: #828282;
    cursor: pointer;
}
.event_list {
    width: 850px;
    float: right;
    background: url(/static/images/dian3.png) 139px 0 repeat-y;
    margin: 10px 0 20px 0;
}
.event_list h3 {
    margin: 0 0 10px 132px;
    font-size: 24px;
    font-family: Georgia;
    color: #db6d4c;
    padding-left: 25px;
    background: url(/static/images/jian.png?v=1.5) 0 -45px no-repeat;
    height: 38px;
    line-height: 30px;
    font-style: italic;
}
.event_list li {
    background: url(/static/images/jian.png?v=1.5) 136px -80px no-repeat;
}
.event_list li span {
    width: 127px;
    text-align: right;
    display: block;
    float: left;
    margin-top: 10px;
}
.event_list li p {
    width: 680px;
    margin-left: 24px;
    display: inline-block;
    padding-left: 10px;
    background: url(/static/images/jian.png?v=1.5) -21px 0 no-repeat;
    line-height: 25px;
}
.event_list li p span {
    width: 650px;
    text-align: left;
    border-bottom: 2px solid #DDD;
    padding: 10px 15px;
    background: #FFF;
    margin: 0;
}
.event_list li span {
    width: 127px;
    text-align: right;
    display: block;
    float: left;
    margin-top: 10px;
}
</style>