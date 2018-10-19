export default (value)=>{
    switch(value){
        case '一技之长': value='/skill'; break;
        case '生活杂谈': value='/selfTalk'; break;
        case '/skill':  value='一技之长'; break;
        case '/selfTalk': value='生活杂谈'; break;
    }
    return value;
}