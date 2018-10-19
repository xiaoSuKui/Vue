SET NAMES UTF8;
DROP DATABASE IF EXISTS zhs;
CREATE DATABASE zhs CHARSET=UTF8;
USE zhs;

#用户信息表
CREATE TABLE zhs_user(
  uid INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户表',
  uname VARCHAR(32),          #用户账号
  upwd VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),
  avatar VARCHAR(128),        #头像图片路径
  monicker VARCHAR(32),      #用户名/昵称
  gender INT,                  #性别  0-女  1-男
  jurisdiction INT,            #权限   0-总管理员   1-二级管理员  2-普通用户
  v1 VARCHAR(128),
  v2 VARCHAR(128),
  v3 VARCHAR(128),
  v4 VARCHAR(128)
);
INSERT INTO zhs_user VALUES(NULL,"dingding","123456","1787600886@qq.com","17638353243","images/headshot.png","赵恒盛",1,0,"","","","");
#文章表
CREATE TABLE zhs_article(
  aid INT PRIMARY KEY AUTO_INCREMENT COMMENT '文章表',
  title VARCHAR (64),         #标题
  md TEXT,               #编辑时内容
  html TEXT,              #显示时内容
  posted_time DATETIME,             #发表时间
  category_id INT,               #所属分类ID
  user_id VARCHAR (32),       #发表人
  praise INT,                   #点赞
  pageView INT,                   #浏览人数
  publicity INT,                  #公开     0-不公开     1-公开
  stick INT,                       #置顶     0-不置顶     1-置顶
  accessory VARCHAR (64),     #预览图
  tag_id INT (16),        #标签ID
  v4 VARCHAR (64)
);
#每日一记表
CREATE TABLE zhs_everyday(
  eid INT PRIMARY KEY AUTO_INCREMENT  COMMENT '每日一记',
  title VARCHAR (64),   #标题
  content TEXT,         #内容
  posted_time DATETIME, #发表时间
  posted_site VARCHAR (64), #发表地点
  weather VARCHAR(32),  #天气
  img VARCHAR (512)	#图片
);
#名人名言表
CREATE TABLE zhs_dictum(
  did  INT PRIMARY KEY AUTO_INCREMENT  COMMENT '名言表',
  content VARCHAR(1024),
  writer VArchar(64)		#作者
);
INSERT INTO zhs_dictum VALUES(null,'为善者常受福，为利者常受祸，心安为福，心劳为祸。','');
INSERT INTO zhs_dictum VALUES(null,'知者不惑，仁者不忧，勇者不惧。','');
INSERT INTO zhs_everyday VALUES(NULL,'公园','今天和东震一起去了公园，看到了很多跳广场舞的中老年同志，我感觉很高兴','2018-03-02 12:22:12','郑州市二七区.人民公园','晴','');
INSERT INTO zhs_everyday VALUES(NULL,'动物园','今天和老焦一起去了动物园，看到了很多动物，我感觉很高兴','2018-03-03 12:22:12','郑州市二七区.人民动物园','晴','');
INSERT INTO zhs_everyday VALUES(NULL,'【2018-03-01】','今天和东震一起去了公园，看到了很多跳广场舞的中老年同志，我感觉很高兴','2018-03-02 12:22:12','郑州市二七区.人民公园','晴','');
INSERT INTO zhs_everyday VALUES(NULL,'博物馆','今天和小黄一起去了博物馆，看到了很多展览品，我感觉很高兴','2018-03-02 12:22:12','郑州市二七区.人民博物馆','晴','');
INSERT INTO zhs_article VALUES(NULL,'一段html代码','## Vue-markdownEditor
# 一季报提
```
    var a=0;
    console.log(xxx);
```
![Vue](https://cn.vuejs.org/images/logo.png)

header 1 | header 2
---|---
row 1 col 1 | row 1 col 2
row 2 col 1 | row 2 col 2

* 第三方
1. 水电费
[Vue](https://cn.vuejs.org/images/logo.png)
> 是非得失

----
首付多少地方
*第三方*','<h2 id="vue-markdowneditor">Vue-markdownEditor</h2>
<h1 id="-">一季报提</h1>
<pre><code>    <span class="hljs-keyword">var</span> a=<span class="hljs-number">0</span>;
    <span class="hljs-built_in">console</span>.log(xxx);
</code></pre><p><img src="https://cn.vuejs.org/images/logo.png" alt="Vue"></p>
<table>
<thead>
<tr>
<th>header 1</th>
<th>header 2</th>
</tr>
</thead>
<tbody>
<tr>
<td>row 1 col 1</td>
<td>row 1 col 2</td>
</tr>
<tr>
<td>row 2 col 1</td>
<td>row 2 col 2</td>
</tr>
</tbody>
</table>
<ul>
<li>第三方</li>
</ul>
<ol>
<li>水电费
<a href="https://cn.vuejs.org/images/logo.png">Vue</a><blockquote>
<p>是非得失</p>
</blockquote>
</li>
</ol>
<hr>
<p>首付多少地方
<em>第三方</em></p>','2018-04-11 11:11:11','1','1','999','123','1','0','',1,'');
INSERT INTO zhs_article VALUES(NULL,"三袋麦子",'快要过年了，土地爷爷给小猪、小牛和小猴各送了一份节日礼物——一口袋麦子。
　　小猪看着黄灿灿的麦子，开心地喊道：“太棒啦！我最爱吃白面馒头和烙饼了！”他迫不及待地把麦子磨成面粉，做成了各种各样的食品。
　　小牛捧起饱满的麦粒，看了又看，心想：多好的麦子呀，我要先把它保存起来，等家里的草料和杂粮都吃完了，再慢慢吃这好东西。为了防止发霉和虫蛀，小牛经常把那袋麦子搬到屋外透透风，晒晒太阳。
　　小猴呢，他觉得面前的这袋麦子上等的麦种，便把一口袋麦子全种下了地。
　　一年以后，土地爷爷又来拜访小猪、小牛和小猴。
　　他先到小猪家，小猪说：“感谢您去年送给我那袋麦子，让我吃到了最好吃的东西。”说着，不由得舔了舔舌头。看着小猪憨厚可爱的样子，土地爷爷忍不住哈哈大笑。
　　告别了小猪，土地爷爷来到小牛家。小牛告诉老人：“去年您送我的麦子至今还没吃完呢。”小牛抱出那只口袋，里面仍有半袋麦子。老人点点头。
　　最后，土地爷爷又来到小猴家。谈起去年那口袋麦子，小猴拉着老人的手，神秘地说：“请跟我来。”
　　土地爷爷跟着小猴到里屋一看，啊，麦囤里堆得满满的。小猴说：“我把麦子种下了地，这都是我的收获。您带一些回家吧。”老人抚摸着小猴的头，兴奋地说：“你真聪明！真能干！”','快要过年了，土地爷爷给小猪、小牛和小猴各送了一份节日礼物——一口袋麦子。
　　小猪看着黄灿灿的麦子，开心地喊道：“太棒啦！我最爱吃白面馒头和烙饼了！”他迫不及待地把麦子磨成面粉，做成了各种各样的食品。
　　小牛捧起饱满的麦粒，看了又看，心想：多好的麦子呀，我要先把它保存起来，等家里的草料和杂粮都吃完了，再慢慢吃这好东西。为了防止发霉和虫蛀，小牛经常把那袋麦子搬到屋外透透风，晒晒太阳。
　　小猴呢，他觉得面前的这袋麦子上等的麦种，便把一口袋麦子全种下了地。
　　一年以后，土地爷爷又来拜访小猪、小牛和小猴。
　　他先到小猪家，小猪说：“感谢您去年送给我那袋麦子，让我吃到了最好吃的东西。”说着，不由得舔了舔舌头。看着小猪憨厚可爱的样子，土地爷爷忍不住哈哈大笑。
　　告别了小猪，土地爷爷来到小牛家。小牛告诉老人：“去年您送我的麦子至今还没吃完呢。”小牛抱出那只口袋，里面仍有半袋麦子。老人点点头。
　　最后，土地爷爷又来到小猴家。谈起去年那口袋麦子，小猴拉着老人的手，神秘地说：“请跟我来。”
　　土地爷爷跟着小猴到里屋一看，啊，麦囤里堆得满满的。小猴说：“我把麦子种下了地，这都是我的收获。您带一些回家吧。”老人抚摸着小猴的头，兴奋地说：“你真聪明！真能干！”',"2018-4-16 12:11:20","1","1","999","123","1","0","",1,""),
(NULL,"桂林山水","人们都说：“桂林山水甲天下。”我们乘着木船，荡漾在漓江上，来观赏桂林的山水。
　　我看见过波澜壮阔的大海，玩赏过水平如镜的西湖，却从没看见过漓江这样的水。漓江的水真静啊，静得让你感觉不到它在流动；漓江的水真清啊，清得可以看见江底的沙石；漓江的水真绿啊，绿得仿佛那是一块无瑕的翡翠。船桨激起的微波扩散出一道道水纹，才让你感觉到船在前进，岸在后移。
　　我攀登过峰峦雄伟的泰山，游览过红叶似火的香山，却从没看见过桂林这一带的山，桂林的山真奇啊，一座座拔地而起，各不相连，像老人，像巨象，像骆驼，奇峰罗列，形态万千；桂林的山真秀啊，像翠绿的屏障，像新生的竹笋，色彩明丽，倒映水中；桂林的山真险啊，危峰兀立，怪石嶙峋，好像一不小心就会栽倒下来。
　　这样的山围绕着这样的水，这样的水倒映着这样的山，再加上空中云雾迷蒙，山间绿树红花，江上竹筏小舟，让你感到像是走进了连绵不断的画卷，真是“舟行碧波上，人在画中游","人们都说：“桂林山水甲天下。”我们乘着木船，荡漾在漓江上，来观赏桂林的山水。
　　我看见过波澜壮阔的大海，玩赏过水平如镜的西湖，却从没看见过漓江这样的水。漓江的水真静啊，静得让你感觉不到它在流动；漓江的水真清啊，清得可以看见江底的沙石；漓江的水真绿啊，绿得仿佛那是一块无瑕的翡翠。船桨激起的微波扩散出一道道水纹，才让你感觉到船在前进，岸在后移。
　　我攀登过峰峦雄伟的泰山，游览过红叶似火的香山，却从没看见过桂林这一带的山，桂林的山真奇啊，一座座拔地而起，各不相连，像老人，像巨象，像骆驼，奇峰罗列，形态万千；桂林的山真秀啊，像翠绿的屏障，像新生的竹笋，色彩明丽，倒映水中；桂林的山真险啊，危峰兀立，怪石嶙峋，好像一不小心就会栽倒下来。
　　这样的山围绕着这样的水，这样的水倒映着这样的山，再加上空中云雾迷蒙，山间绿树红花，江上竹筏小舟，让你感到像是走进了连绵不断的画卷，真是“舟行碧波上，人在画中游”。","2018-4-15 11:11:20","1","1","999","123","1","0","",1,""),
(NULL,"日月潭","日月潭是我国台湾省最大的一个湖。它在台湾省中部的山区。那里群山环绕，树木茂盛，周围有许多名胜古迹。
　　日月潭很深，湖水碧绿。湖中央有个美丽的小岛，叫光华岛。小岛把湖水分成两半，北边像圆圆的太阳，叫日潭；南边像弯弯的月亮，叫月潭。
　　清晨，湖面上飘着薄薄的雾。天边的晨星和山上的点点灯光，隐隐约约地倒映在湖水中。
　　中午，太阳高照，整个日月潭的美景和周围的建筑，都清晰地展现在眼前。要是下起蒙蒙细雨，日月潭好像披上轻纱，周围的景物一片朦胧，就像童话中的仙境。
　　日月潭风光秀丽，吸引了许许多多的中外游客。","日月潭是我国台湾省最大的一个湖。它在台湾省中部的山区。那里群山环绕，树木茂盛，周围有许多名胜古迹。
　　日月潭很深，湖水碧绿。湖中央有个美丽的小岛，叫光华岛。小岛把湖水分成两半，北边像圆圆的太阳，叫日潭；南边像弯弯的月亮，叫月潭。
　　清晨，湖面上飘着薄薄的雾。天边的晨星和山上的点点灯光，隐隐约约地倒映在湖水中。
　　中午，太阳高照，整个日月潭的美景和周围的建筑，都清晰地展现在眼前。要是下起蒙蒙细雨，日月潭好像披上轻纱，周围的景物一片朦胧，就像童话中的仙境。
　　日月潭风光秀丽，吸引了许许多多的中外游客。","2018-4-16 12:11:20","2","1","999","123","1","0","",1,""),
(NULL,"将心比心","　奶奶给我讲过这样一件事：有一次她去商店，走在她前面的一位阿姨推开沉重的大门，一直等到她跟上来才松开手。当奶奶向她道谢的时候，那位阿姨轻轻地说：“我的妈妈和您的年龄差不多，我希望她遇到这种时候，也有人为她开门。”听了这件事，我的心温暖了许久。
　　一天，我陪患病的母亲去医院输液，年轻的护士为母亲扎了两针也没有扎进血管里，眼见针眼鼓起青包。我正要抱怨几句，一抬头看见了母亲平静的眼神——她正在注视着护士额头上密密的汗珠，我不禁收住了涌到嘴边的话。只见母亲轻轻地对护士说：“不要紧，再来一次！”第三针果然成功了。那位护士终于长出了一口气，她连声说：“阿姨，真对不起。我是来实习的，这是我第一次给病人扎针，太紧张了。要不是您的鼓励，我真不敢给您扎了。”母亲用另一只手拉着我，平静地对护士说：“这是我女儿，和你差不多大小，正在医科大学读书，她也将面对自己的第一个患者。我真希望她第一次扎针的时候，也能得到患者的宽容和鼓励。听了母亲的话，我的心里充满了温暖与幸福。
　　是啊，如果我们在生活中能将心比心，就会对老人生出一份尊重，对孩子增加一份关爱，就会使人与人之间多一些宽容和理解。","　奶奶给我讲过这样一件事：有一次她去商店，走在她前面的一位阿姨推开沉重的大门，一直等到她跟上来才松开手。当奶奶向她道谢的时候，那位阿姨轻轻地说：“我的妈妈和您的年龄差不多，我希望她遇到这种时候，也有人为她开门。”听了这件事，我的心温暖了许久。
　　一天，我陪患病的母亲去医院输液，年轻的护士为母亲扎了两针也没有扎进血管里，眼见针眼鼓起青包。我正要抱怨几句，一抬头看见了母亲平静的眼神——她正在注视着护士额头上密密的汗珠，我不禁收住了涌到嘴边的话。只见母亲轻轻地对护士说：“不要紧，再来一次！”第三针果然成功了。那位护士终于长出了一口气，她连声说：“阿姨，真对不起。我是来实习的，这是我第一次给病人扎针，太紧张了。要不是您的鼓励，我真不敢给您扎了。”母亲用另一只手拉着我，平静地对护士说：“这是我女儿，和你差不多大小，正在医科大学读书，她也将面对自己的第一个患者。我真希望她第一次扎针的时候，也能得到患者的宽容和鼓励。听了母亲的话，我的心里充满了温暖与幸福。
　　是啊，如果我们在生活中能将心比心，就会对老人生出一份尊重，对孩子增加一份关爱，就会使人与人之间多一些宽容和理解。","2018-4-16 12:11:20","1","1","999","123","1","0","",1,"");
#图片表
CREATE  TABLE  zhs_img(
  iid INT PRIMARY KEY AUTO_INCREMENT  COMMENT '图片表',
  user_id INT,			#用户ID
  article_aid INT,		#文章ID
  title VARCHAR (64),
  path VARCHAR (128),       #图片路径
  details VARCHAR (64),    #描述
  v1 VARCHAR (64),
  v2 VARCHAR (64)
);
INSERT INTO zhs_img VALUES(NULL,"1","1","xxx","images/banner (1).jpg","xxx","","");
INSERT INTO zhs_img VALUES(NULL,"1","2","xxx","images/banner (1).jpg","xxx","","");
INSERT INTO zhs_img VALUES(NULL,"1","3","xxx","images/banner (1).jpg","xxx","","");
INSERT INTO zhs_img VALUES(NULL,"1","4","xxx","images/banner (1).jpg","xxx","","");
#轮播表
CREATE TABLE zhs_banner(
  bid INT PRIMARY KEY AUTO_INCREMENT COMMENT '轮播图片表',
  path VARCHAR (128),
  title VARCHAR (32),
  href VARCHAR (128),
  V1 VARCHAR (64)
);
INSERT INTO zhs_banner VALUES(NULL,"images/banner (1).jpg","轮播图片1","javascript:;",""),
(NULL,"images/banner (2).jpg","轮播图片2","javascript:;",""),
(NULL,"images/banner (3).jpg","轮播图片3","javascript:;",""),
(NULL,"images/banner (4).jpg","轮播图片4","javascript:;",""),
(NULL,"images/banner (5).jpg","轮播图片5","javascript:;","");
#留言表
CREATE TABLE zhs_leaveWord(
  lid INT PRIMARY KEY AUTO_INCREMENT  COMMENT '留言表',
  article_aid INT,
  time INT,
  title VARCHAR (128),
  v1 VARCHAR (64),
  v2 VARCHAR (64)
);
#评论表
CREATE TABLE zhs_comment(
  cid INT PRIMARY KEY AUTO_INCREMENT  COMMENT '评论表',
  article_aid INT,
  comment_time INT,
  title VARCHAR (128),
  v1 VARCHAR (64),
  v2 VARCHAR (64)
);
#类别表
CREATE TABLE zhs_category(
  cid INT PRIMARY KEY AUTO_INCREMENT  COMMENT '类别表',
  cname VARCHAR (16),
  v1 VARCHAR (32)
);
INSERT INTO zhs_category VALUES(NULL,"一技之长","");
INSERT INTO zhs_category VALUES(NULL,"生活杂谈","");
INSERT INTO zhs_category VALUES(NULL,"每日一记","");
INSERT INTO zhs_category VALUES(NULL,"名人名言","");

#标签表
CREATE TABLE zhs_tag(
  tid INT PRIMARY KEY AUTO_INCREMENT COMMENT '标签表',
  tname VARCHAR(16),
  v1 VARCHAR(16)
);
INSERT INTO zhs_tag VALUES(NULL,"JavaScript","");
#友情链接表
CREATE TABLE zhs_blogroll(
  bid INT PRIMARY KEY AUTO_INCREMENT COMMENT '友情链接表',
  bname VARCHAR(16),
  href VARCHAR(128),
  v1 VARCHAR(64)
);
INSERT INTO zhs_blogroll VALUES(NULL,"jQuery官网","https://jquery.com/","");
INSERT INTO zhs_blogroll VALUES(NULL,"PHP100","http://www.php100.com/","");
INSERT INTO zhs_blogroll VALUES(NULL,"Vue官网","https://cn.vuejs.org/","");
INSERT INTO zhs_blogroll VALUES(NULL,"RN中文网","https://reactnative.cn/","");