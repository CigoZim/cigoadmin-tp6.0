-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: cigoadmin
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cg_admin_log`
--

DROP TABLE IF EXISTS `cg_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '管理员编号',
  `module` int NOT NULL DEFAULT '0' COMMENT '系统模块(区分后台)',
  `controller` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '控制器',
  `action` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作',
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '访问路径',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数',
  `create_time` int NOT NULL DEFAULT '0' COMMENT '请求时间',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IP地址',
  `client` tinyint NOT NULL DEFAULT '0' COMMENT '终端(1-PC;2-Android;3-IOS;4-微信；5-手机网页)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_admin_log`
--

LOCK TABLES `cg_admin_log` WRITE;
/*!40000 ALTER TABLE `cg_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_comment`
--

DROP TABLE IF EXISTS `cg_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_comment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` int NOT NULL DEFAULT '0' COMMENT '用户编号',
  `target_type` tinyint NOT NULL DEFAULT '0' COMMENT '被评论数据类型（0-商品；1-疗程；2-团购；3-砍价；4-积分订单；5-发现；6-好文；7-预约；8-接待；10-思TV）',
  `target_id` int NOT NULL DEFAULT '0' COMMENT '被评论数据编号',
  `score` tinyint NOT NULL DEFAULT '0' COMMENT '打分（打分详情汇总）',
  `score_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '打分详情（JSON字符串：key=>value形式）',
  `anonymous_flag` tinyint NOT NULL DEFAULT '1' COMMENT '匿名评论标识',
  `report_num` int unsigned NOT NULL DEFAULT '0' COMMENT '举报数量',
  `view_num` int unsigned NOT NULL DEFAULT '0' COMMENT '浏览数量',
  `thumbs_up_num` int unsigned NOT NULL DEFAULT '0' COMMENT '点赞数量',
  `img_show` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '评论图片集合',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '评论内容',
  `create_time` int NOT NULL DEFAULT '0' COMMENT '评论时间',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0-新发布待审核；1-已审核）',
  `verify_admin_id` int NOT NULL DEFAULT '0' COMMENT '审核管理员编号',
  `verify_time` int NOT NULL DEFAULT '0' COMMENT '审核时间',
  `reply_admin_id` int NOT NULL DEFAULT '0' COMMENT '回复管理员编号',
  `admin_reply_comment` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '管理员回复内容',
  `admin_reply_time` int NOT NULL DEFAULT '0' COMMENT '管理员回复时间',
  `add_img_show` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '追评图片集合',
  `add_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '追评内容',
  `add_status` tinyint NOT NULL DEFAULT '1' COMMENT '状态（0-新发布待审核；1-已审核）',
  `add_time` int NOT NULL DEFAULT '1' COMMENT '追评时间',
  `add_verify_admin_id` int NOT NULL DEFAULT '1' COMMENT '追评审核管理员编号',
  `add_verify_time` int NOT NULL DEFAULT '1' COMMENT '追评审核时间',
  `add_reply_admin_id` int NOT NULL DEFAULT '1' COMMENT '追评回复管理员编号',
  `add_admin_reply_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '追评管理员回复内容',
  `add_admin_reply_time` int NOT NULL DEFAULT '0' COMMENT '追评管理员回复时间',
  `order_data_id` int NOT NULL DEFAULT '0' COMMENT '关联order_goods或者order_course表ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_comment`
--

LOCK TABLES `cg_comment` WRITE;
/*!40000 ALTER TABLE `cg_comment` DISABLE KEYS */;
INSERT INTO `cg_comment` VALUES (1,3,0,7,3,'{\"cservice\":5,\"science\":2,\"cproduct\":4,\"effect\":2}',1,0,12,2,'1304,1303','这是拼团订单评论',1567771028,1,1,1567771653,1,'这是拼团回复',1567771762,'1303,1304','三人拼团追评',1,1567771080,1,1567771787,1,'这是三人拼团追评回复',1567771827,9),(2,3,0,6,3,'{\"cservice\":3,\"science\":2,\"cproduct\":3,\"effect\":2}',1,0,0,0,'1303,1304','评价',1567779945,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,18),(3,12,0,2,3,'{\"cservice\":5,\"science\":2,\"cproduct\":4,\"effect\":2}',0,0,1,3,'','电饭锅电饭锅',1567781638,1,1,1567781676,0,'',0,'','',1,1,1,1,1,'',0,37),(4,4,0,17,3,'{\"logistics\":2,\"cservice\":2,\"cproduct\":4}',0,0,0,0,'1412,1410,1417,1416,1418','恶露欧诺',1567781896,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,43),(5,16,5,2,0,'',1,1,0,1,'','机器人评论',1567793120,1,1,1567793119,0,'',0,'','',1,1,1,1,1,'',0,0),(6,3,0,14,5,'{\"logistics\":5,\"cservice\":4,\"cproduct\":5}',1,0,0,0,'1303,1304','砍价评论哈哈',1567794523,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,68),(7,4,0,15,4,'{\"logistics\":5,\"cservice\":4,\"cproduct\":4}',1,0,6,1,'','我是三刀成0匿名',1567795445,1,1,1567795462,0,'',0,'','我是追评',0,1567795562,1,1,1,'',0,26),(8,14,5,2,0,'',1,0,0,0,'','请问请问请问请问请问',1567795815,1,1,1567795814,0,'',0,'','',1,1,1,1,1,'',0,0),(9,4,6,1,0,'',1,0,0,0,'','fsdfsdf ',1567818551,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(10,17,6,1,0,'',1,0,0,0,'','    ',1567820353,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(11,17,5,3,0,'',1,0,0,0,'','     ',1567820392,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(12,3,0,6,4,'{\"cservice\":5,\"science\":2,\"cproduct\":5,\"effect\":2}',1,0,0,0,'1303,1304','两人团评论',1567823564,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,8),(13,3,0,16,5,'{\"logistics\":5,\"cservice\":5,\"cproduct\":4}',1,0,2,1,'1304,1303','闺蜜一刀砍评价',1567823956,1,1,1567824023,0,'',0,'','',1,1,1,1,1,'',0,84),(14,16,10,1,0,'',1,1,0,0,'','我是泰山',1567824433,1,1,1567824433,0,'',0,'','',1,1,1,1,1,'',0,0),(15,12,5,3,0,'',1,0,0,0,'','234234',1567825348,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(16,12,10,1,0,'',1,0,0,0,'','杀对方水电费',1567825645,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(17,12,6,1,0,'',1,0,0,0,'','我是测试评论11111',1567825770,1,1,1567825785,0,'',0,'','',1,1,1,1,1,'',0,0),(18,15,6,1,0,'',1,0,0,0,'','我是庐山',1567825840,1,1,1567825841,0,'',0,'','',1,1,1,1,1,'',0,0),(19,12,0,14,4,'{\"logistics\":2,\"cservice\":4,\"cproduct\":5}',0,0,0,0,'','sdfsdfsdf',1567826282,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,87),(20,6506,0,6,3,'{\"cservice\":4,\"science\":2,\"cproduct\":2,\"effect\":2}',0,0,2,2,'','是电饭锅是的法规',1567839290,1,1,1567839304,0,'',0,'','杀对方水电费是的',1,1567839456,1,1567839478,1,'',0,90),(21,6506,0,2,3,'{\"cservice\":4,\"science\":2,\"cproduct\":5,\"effect\":2}',0,0,7,2,'2061','46546546',1567839894,1,1,1567839924,0,'',0,'2061','我是追加评价',1,1567839962,1,1567839967,1,'',0,91),(22,6506,0,2,3,'{\"cservice\":2,\"science\":2,\"cproduct\":4,\"effect\":2}',0,0,0,0,'2199,2231,2233,2200,2201','得得',1567866874,0,0,0,0,'',0,'2198,2202,2202','名模',0,1567866888,1,1,1,'',0,106),(23,6506,0,14,3,'{\"logistics\":2,\"cservice\":2,\"cproduct\":5}',0,0,0,0,'','您',1567867210,0,0,0,0,'',0,'','哦搜狗',0,1567867223,1,1,1,'',0,108),(24,5843,0,2,3,'{\"cservice\":2,\"science\":2,\"cproduct\":4,\"effect\":2}',1,0,5,2,'2262,2263','2人团测试评价',1567869947,1,1,1567870013,0,'',0,'2262','2人团追评测试',0,1567869985,1,1,1,'',0,109),(25,5843,0,19,4,'{\"logistics\":5,\"cservice\":4,\"cproduct\":4}',1,0,0,0,'2263,2262','积分订单评价',1567902584,0,0,0,0,'',0,'2262,2263','积分订单追评',0,1567902616,1,1,1,'',0,133),(26,5843,0,19,5,'{\"logistics\":5,\"cservice\":5,\"cproduct\":4}',1,0,0,0,'2263','积分订单轻轻坤坤',1567902665,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,132),(27,6509,0,20,4,'{\"logistics\":4,\"cservice\":4,\"cproduct\":4}',0,0,0,0,'2218,2218,2218','公共邮箱看看',1567922542,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,205),(28,5843,0,2,3,'{\"cservice\":5,\"science\":2,\"cproduct\":3,\"effect\":2}',1,0,0,0,'2262,2263','这是两人团评论',1567927979,0,0,0,0,'',0,'2262','我两人团追评',0,1567928009,1,1,1,'',0,211),(29,5843,0,6,4,'{\"cservice\":5,\"science\":2,\"cproduct\":5,\"effect\":2}',1,0,0,0,'2391,2392','这是评价',1567931344,0,0,0,0,'',0,'2393','2人团追评',0,1567931384,1,1,1,'',0,210),(30,5935,5,82,0,'',1,0,0,0,'','好 赞',1567995850,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(31,5935,5,65,0,'',1,0,0,0,'','😄',1567996036,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(32,5906,5,91,0,'',1,0,0,0,'','👿',1568171158,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(33,5906,5,86,0,'',1,0,0,0,'','👀',1568171314,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(34,5888,5,89,0,'',1,0,0,0,'','龙敏',1568171337,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(35,6554,6,12,0,'',1,0,0,0,'','说说',1568186041,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(36,6544,5,89,0,'',1,0,0,0,'','哈哈😄 ',1568190394,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(37,6549,0,20,5,'{\"logistics\":5,\"cservice\":5,\"cproduct\":4}',0,0,0,0,'','呵呵呵',1568216879,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,311),(38,6508,6,23,0,'',1,0,0,0,'','好诶',1568221403,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(39,6554,5,91,0,'',1,0,0,0,'','兴民哦哦',1568222305,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(40,5888,6,12,0,'',1,0,0,0,'','好评，收藏',1568226622,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(41,5888,6,12,0,'',1,0,0,0,'','诶呦，不错哦',1568226635,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(42,6554,6,12,0,'',1,0,0,0,'','POS民',1568248115,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(43,6554,10,4,0,'',1,0,0,0,'','挺便宜异形魔怪',1568248670,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(44,5888,5,88,0,'',1,0,0,0,'','哈哈哈',1568251533,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(45,5906,6,19,0,'',1,0,0,0,'','看不到',1568277560,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(46,5906,10,4,0,'',1,0,0,0,'','看到了，看到了',1568277688,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(47,6554,10,2,0,'',1,0,0,0,'','鱼死网破红呢额',1568279768,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(48,6554,10,2,0,'',1,0,0,0,'','这是行尸走肉',1568279786,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(49,6554,10,2,0,'',1,0,0,0,'','太可怜了',1568279803,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(50,6577,0,19,5,'{\"logistics\":5,\"cservice\":5,\"cproduct\":5}',0,0,0,0,'','很好',1568294866,0,0,0,0,'',0,'','非常好',0,1568294876,1,1,1,'',0,460),(51,6573,5,90,0,'',1,0,0,0,'','           1',1568295434,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(52,6577,5,89,0,'',1,0,0,0,'','哼哼',1568303113,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(53,6576,10,3,0,'',1,0,0,0,'',' 乐色',1568307056,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(54,6572,5,80,0,'',1,0,0,0,'','测试',1568880726,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(55,3,0,7,5,'{\"logistics\":5,\"cservice\":5,\"cproduct\":5}',1,0,0,0,'','',1569498902,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,9),(56,3,0,6,5,'{\"logistics\":5,\"cservice\":5,\"cproduct\":5}',1,0,0,0,'','',1569498906,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,8),(57,3,0,6,5,'{\"logistics\":5,\"cservice\":5,\"cproduct\":5}',1,0,0,0,'','',1569507916,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,18),(58,12,0,2,5,'{\"logistics\":5,\"cservice\":5,\"cproduct\":5}',1,0,0,0,'','',1569509139,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,37),(59,4,0,17,5,'{\"logistics\":5,\"cservice\":5,\"cproduct\":5}',1,0,0,0,'','',1569510138,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,42),(60,42,10,2,0,'',1,0,0,0,'','超强清洁🧽',1569580289,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(61,42,5,87,0,'',1,0,0,0,'','🎀🎀🎀',1569588185,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(62,6604,5,90,0,'',1,0,0,0,'','666\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nd\n\n\n\n\n\n\n\n\n\n\n\ne\n\n',1570788187,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0),(63,42,5,90,0,'',1,0,0,2,'','非常好用的一款洗面奶',1571716797,1,64,1572580647,0,'',0,'','',1,1,1,1,1,'',0,0),(64,6933,5,90,0,'',1,0,0,0,'','花木兰保湿化妆水，用上皮肤非常水润',1573339112,0,0,0,0,'',0,'','',1,1,1,1,1,'',0,0);
/*!40000 ALTER TABLE `cg_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_comment_interaction`
--

DROP TABLE IF EXISTS `cg_comment_interaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_comment_interaction` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `comment_id` int NOT NULL DEFAULT '0' COMMENT '隶属评论编号',
  `root_id` int NOT NULL DEFAULT '0' COMMENT '根编号',
  `pid` int NOT NULL DEFAULT '0' COMMENT '父级编号（用于追评）',
  `user_id` int NOT NULL DEFAULT '0' COMMENT '用户编号',
  `target_user_id` int NOT NULL DEFAULT '0' COMMENT '被回复者编号',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '交互内容',
  `report_num` int unsigned NOT NULL DEFAULT '0' COMMENT '举报数量',
  `view_num` int unsigned NOT NULL DEFAULT '0' COMMENT '浏览数量',
  `thumbs_up_num` int unsigned NOT NULL DEFAULT '0' COMMENT '点赞数量',
  `create_time` int NOT NULL DEFAULT '0' COMMENT '交互时间',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态（0-新发布待审核；1-已审核）',
  `verify_admin_id` int NOT NULL DEFAULT '0' COMMENT '审核管理员编号',
  `verify_time` int NOT NULL DEFAULT '0' COMMENT '审核时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='评论下用户互动表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_comment_interaction`
--

LOCK TABLES `cg_comment_interaction` WRITE;
/*!40000 ALTER TABLE `cg_comment_interaction` DISABLE KEYS */;
INSERT INTO `cg_comment_interaction` VALUES (1,1,0,0,14,3,'评论交互下',0,0,0,1567771997,1,1,1567771997),(2,1,1,1,15,14,'跟robot交互下',0,0,0,1567772065,1,1,1567772065),(3,1,1,2,14,15,'回复',0,0,0,1567772101,1,1,1567772101),(4,5,0,0,17,16,'哈哈啊哈哈哈',0,0,0,1567793189,1,1,1567793200),(5,5,4,0,16,17,'我厄齐尔切 切',0,0,0,1567794061,1,1,1567794061),(6,5,5,0,17,16,'我是庐山',0,0,0,1567794102,1,1,1567794102),(7,5,6,0,16,17,'1312313',0,0,0,1567794141,1,1,1567794142),(8,5,7,0,17,16,'驱蚊器群无若',0,0,0,1567794170,1,1,1567794170),(9,5,8,0,16,17,'4354343',0,0,0,1567794580,1,1,1567794580),(10,5,9,0,17,16,'234433',0,0,0,1567794662,1,1,1567794662),(11,5,10,0,14,17,'恶趣味群无',0,0,0,1567794893,1,1,1567794893),(12,5,10,0,17,14,'啥意思啊',0,0,0,1567794909,1,1,1567794916),(13,5,12,0,15,17,'我知道',0,0,0,1567794938,1,1,1567794938),(14,5,12,0,17,15,'怎么',0,0,0,1567794986,1,1,1567794993),(15,5,12,0,17,15,'咋地',0,0,0,1567795870,1,1,1567795877),(16,14,0,0,17,16,'什么鬼',0,0,0,1567824451,-1,1,1567824459),(17,18,0,0,12,15,'3423423',0,0,0,1567825854,1,1,1567825888),(18,18,17,0,14,12,'我是机器人',0,0,0,1567825900,1,1,1567825900),(19,21,0,0,5843,6506,'啦啦啦啦啦啦',0,0,0,1567870078,1,1,1567870109),(20,7,0,0,5906,4,'好的',0,0,0,1568001454,0,0,0),(21,24,0,0,6508,5843,'hello',0,0,0,1568251491,0,0,0),(22,21,19,19,6508,5843,'hello',0,0,0,1568251508,0,0,0),(23,63,0,0,6100,42,'是的',0,0,0,1572580764,-1,64,1572580693);
/*!40000 ALTER TABLE `cg_comment_interaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_comment_like_log`
--

DROP TABLE IF EXISTS `cg_comment_like_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_comment_like_log` (
  `log_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `comment_id` int NOT NULL DEFAULT '0' COMMENT '评论id',
  `user_id` int NOT NULL DEFAULT '0' COMMENT '点赞人id',
  `vote_time` int NOT NULL DEFAULT '0' COMMENT '点赞时间',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态：0 已取消，1 已点赞',
  `create_time` int DEFAULT '0' COMMENT '创建时间',
  `update_time` int DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='评价点赞日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_comment_like_log`
--

LOCK TABLES `cg_comment_like_log` WRITE;
/*!40000 ALTER TABLE `cg_comment_like_log` DISABLE KEYS */;
INSERT INTO `cg_comment_like_log` VALUES (1,1,3,1567771719,1,1567771719,0),(2,3,3,1567828673,1,1567828673,0),(3,21,5843,1567870067,1,1567870067,0),(4,24,5843,1567923223,1,1567923223,0),(5,3,5843,1567923226,1,1567923226,0),(6,24,6544,1568095319,1,1568095319,0),(7,21,6544,1568098465,1,1568098465,0),(8,3,6544,1568098467,1,1568098467,0),(9,20,6548,1568110660,1,1568110660,0),(10,20,6544,1568277444,1,1568277444,0),(11,1,6555,1568284294,1,1568284294,0),(12,13,6558,1568301206,0,1568301206,1568301264),(13,13,6576,1568303074,1,1568303074,1568303115),(14,7,6576,1568303154,1,1568303154,1568303166);
/*!40000 ALTER TABLE `cg_comment_like_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_comment_report_log`
--

DROP TABLE IF EXISTS `cg_comment_report_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_comment_report_log` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `comment_id` int NOT NULL DEFAULT '0' COMMENT '评论id',
  `user_id` int NOT NULL DEFAULT '0' COMMENT '举报人id',
  `report_time` int NOT NULL DEFAULT '0' COMMENT '举报时间',
  `create_time` int DEFAULT '0' COMMENT '创建时间',
  `update_time` int DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='评价举报日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_comment_report_log`
--

LOCK TABLES `cg_comment_report_log` WRITE;
/*!40000 ALTER TABLE `cg_comment_report_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_comment_report_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_files`
--

DROP TABLE IF EXISTS `cg_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_files` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'file' COMMENT '文件类型( file；img；video)',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件全名',
  `prefix` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `ext` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件后缀',
  `name_saved` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '保存名',
  `mime` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int NOT NULL DEFAULT '0' COMMENT '文件大小',
  `attach` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '附属信息',
  `path` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件路径名',
  `path_cover` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件封面图片路径字符串',
  `thumb_small` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '图片缩略图-小',
  `thumb_middle` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '图片缩略图-中',
  `md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `hash` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件hash',
  `platform` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '上传平台(‘local’-本地服务器；’qiniu’-七牛云；’aliyun’-阿里云；’tencent’-腾讯云)',
  `platform_bucket` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `platform_key` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '平台相关参数',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态(0-禁用；1-启用；-1：删除)',
  `create_time` int NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='上传文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_files`
--

LOCK TABLES `cg_files` WRITE;
/*!40000 ALTER TABLE `cg_files` DISABLE KEYS */;
INSERT INTO `cg_files` VALUES (17,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','f75aff36-e4ce-4833-9d46-5665b517b7d4','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','f75aff36-e4ce-4833-9d46-5665b517b7d4',1,1599550985),(18,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','30405a04-c08d-4dce-8910-1ed91e42f380','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','30405a04-c08d-4dce-8910-1ed91e42f380',1,1599551898),(19,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','cd3d78a9-c137-481d-bcc0-ef582e9197ae','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','cd3d78a9-c137-481d-bcc0-ef582e9197ae',1,1599554997),(20,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','9985529a-c5e9-4263-b09a-b6fd0f57edfb','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','9985529a-c5e9-4263-b09a-b6fd0f57edfb',1,1599555001),(21,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','4cde7118-5d2b-4485-b8cd-78671e371553','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','4cde7118-5d2b-4485-b8cd-78671e371553',1,1599555101),(22,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','020c92e8-0153-4b02-ac69-23fd21ff7849','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','020c92e8-0153-4b02-ac69-23fd21ff7849',1,1599555103),(23,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','7ad6b12b-ea2f-4a54-88ea-cee3786f8747','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','7ad6b12b-ea2f-4a54-88ea-cee3786f8747',1,1599555155),(24,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','e8df8e47-3547-45dd-a8d7-cbce369b3b5d','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','e8df8e47-3547-45dd-a8d7-cbce369b3b5d',1,1599555155),(25,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','ad908416-4658-4cd6-bcf0-5875ea3b4444','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','ad908416-4658-4cd6-bcf0-5875ea3b4444',1,1599555155),(26,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','956e2eef-63ca-4d17-923d-71abaf45b22c','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','956e2eef-63ca-4d17-923d-71abaf45b22c',1,1599555157),(27,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','8a6b3671-a8e8-44bd-b3a0-d51fd15610ac','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','8a6b3671-a8e8-44bd-b3a0-d51fd15610ac',1,1599555285),(28,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','78a067e4-a8fa-4b01-ba17-db862124b952','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','78a067e4-a8fa-4b01-ba17-db862124b952',1,1599555285),(29,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','026dd7c5-0e51-4f2b-9e08-4c6f177cf4f8','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','026dd7c5-0e51-4f2b-9e08-4c6f177cf4f8',1,1599555398),(30,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','08fa0192-1257-46c4-9281-da4eca097f6a','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','08fa0192-1257-46c4-9281-da4eca097f6a',1,1599555398),(31,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','790f320f-10fa-4a18-aa3b-92230e38d7df','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','790f320f-10fa-4a18-aa3b-92230e38d7df',1,1599555398),(32,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','7fc8b2d6-3019-4b57-a19e-b6fb5d20e550','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','7fc8b2d6-3019-4b57-a19e-b6fb5d20e550',1,1599555480),(33,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','23e10211-47de-4274-a1ab-eb12c77c5983','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','23e10211-47de-4274-a1ab-eb12c77c5983',1,1599555480),(34,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','834c4a6e-fb54-4218-a697-d747e98b87c5','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','834c4a6e-fb54-4218-a697-d747e98b87c5',1,1599555480),(35,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','3601746d-029e-4597-a911-91b61ae0617d','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','3601746d-029e-4597-a911-91b61ae0617d',1,1599555535),(36,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','8b08f26f-9ef2-4d4c-8fac-69bb4076629b','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','8b08f26f-9ef2-4d4c-8fac-69bb4076629b',1,1599555535),(37,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','ffc35564-121c-4f72-846f-8b47d4ecf157','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','ffc35564-121c-4f72-846f-8b47d4ecf157',1,1599555536),(38,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','cbbdf43a-c1e5-47ba-96fa-a8f4faf326a8','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','cbbdf43a-c1e5-47ba-96fa-a8f4faf326a8',1,1599557842),(39,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','b6e60dc8-f22c-4364-86ca-c01219e15534','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','b6e60dc8-f22c-4364-86ca-c01219e15534',1,1599557842),(40,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','fb0b1918-61c5-43cf-9c35-2c0053f4c6da','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','fb0b1918-61c5-43cf-9c35-2c0053f4c6da',1,1599557944),(41,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','589e7553-0cd9-41bc-bba5-97072410ce04','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','589e7553-0cd9-41bc-bba5-97072410ce04',1,1599557944),(42,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','a72c49e7-5292-45ee-9504-3590c29797e3','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','a72c49e7-5292-45ee-9504-3590c29797e3',1,1599557944),(43,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','1e05ee84-274d-4c0c-9de1-fa595178d98f','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','1e05ee84-274d-4c0c-9de1-fa595178d98f',1,1599557985),(44,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','52df9f88-aadf-4f1c-9e1e-1861a260d892','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','52df9f88-aadf-4f1c-9e1e-1861a260d892',1,1599557985),(45,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','264676c1-dd10-432f-b7df-ec2dc3da7d37','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','264676c1-dd10-432f-b7df-ec2dc3da7d37',1,1599557985),(46,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','6cf969f4-8894-47d1-9656-e96e8051261b','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','6cf969f4-8894-47d1-9656-e96e8051261b',1,1599558216),(47,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','fa030aaf-f5a7-434d-897e-839e591e7a29','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','fa030aaf-f5a7-434d-897e-839e591e7a29',1,1599558216),(48,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','3e4f65da-386d-4e95-b9e1-fe8ee366af46','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','3e4f65da-386d-4e95-b9e1-fe8ee366af46',1,1599558216),(49,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','c399622a-e947-4ed2-b1a5-deba2424b425','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','c399622a-e947-4ed2-b1a5-deba2424b425',1,1599558323),(50,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','4a6b634f-5aca-4ba1-b1a6-e239a8aa31ec','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','4a6b634f-5aca-4ba1-b1a6-e239a8aa31ec',1,1599558323),(51,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','f606323f-36cd-45c9-82b8-b37f50b03401','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','f606323f-36cd-45c9-82b8-b37f50b03401',1,1599558323),(52,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','d578e2d3-fa9f-49a2-bb4d-84237358626d','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','d578e2d3-fa9f-49a2-bb4d-84237358626d',1,1599559274),(53,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','79c4b09b-086e-4d35-817a-0369c3ed6319','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','79c4b09b-086e-4d35-817a-0369c3ed6319',1,1599559465),(54,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','33222987-81dc-427b-977a-6e4fcb3bc1f6','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','33222987-81dc-427b-977a-6e4fcb3bc1f6',1,1599559465),(55,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','b75998e5-3a85-488d-9f12-e0d754e8f80e','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','b75998e5-3a85-488d-9f12-e0d754e8f80e',1,1599559512),(56,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','aa5cb01b-460f-4837-8e0a-6c8be7108681','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','aa5cb01b-460f-4837-8e0a-6c8be7108681',1,1599559512),(57,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','c5aefae8-e640-4086-9991-bc5d5a366162','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','c5aefae8-e640-4086-9991-bc5d5a366162',1,1599559512),(58,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','0b47d6c8-47ce-4728-b8c5-df2320e541ca','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','0b47d6c8-47ce-4728-b8c5-df2320e541ca',1,1599559852),(59,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','d58a0fa3-0676-43b8-aeaa-78ddb893e942','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','d58a0fa3-0676-43b8-aeaa-78ddb893e942',1,1599559852),(60,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','0eb02b84-d728-41fb-adb6-208a91f2a87e','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','0eb02b84-d728-41fb-adb6-208a91f2a87e',1,1599559852),(61,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','4ecdf6ff-f601-42d9-85b6-fcc0cd9bb21e','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','4ecdf6ff-f601-42d9-85b6-fcc0cd9bb21e',1,1599559981),(62,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','a48f0a47-0c57-4485-8659-888dbcf0367a','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','a48f0a47-0c57-4485-8659-888dbcf0367a',1,1599559981),(63,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','6d751e2a-9121-42a2-b992-e56f18730d15','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','6d751e2a-9121-42a2-b992-e56f18730d15',1,1599559982),(64,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','224fa396-446f-407f-89ac-8d543a11e3c1','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','224fa396-446f-407f-89ac-8d543a11e3c1',1,1599560016),(65,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','d89dabcd-0886-4a38-b9f0-f591109359a3','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','d89dabcd-0886-4a38-b9f0-f591109359a3',1,1599560016),(66,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','95aa794a-5eb7-4a00-9bae-2d147f02d6e7','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','95aa794a-5eb7-4a00-9bae-2d147f02d6e7',1,1599560016),(67,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','ab86b8e9-d20c-4869-b477-11b41788769d','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','ab86b8e9-d20c-4869-b477-11b41788769d',1,1599560016),(68,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','d5e6321a-2076-4966-8754-e2d9d30571eb','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','d5e6321a-2076-4966-8754-e2d9d30571eb',1,1599560115),(69,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','cf0ce03f-548c-4ff7-b83d-585c32b74c06','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','cf0ce03f-548c-4ff7-b83d-585c32b74c06',1,1599560115),(70,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','7ea3d6e8-d151-40ce-b4ec-6160532146ad','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','7ea3d6e8-d151-40ce-b4ec-6160532146ad',1,1599560115),(71,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','e131c197-8e8e-4575-86d5-70bbb613dc97','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','e131c197-8e8e-4575-86d5-70bbb613dc97',1,1599560116),(72,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','26a11394-c1c2-4515-a45f-dd8e057d7d62','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','26a11394-c1c2-4515-a45f-dd8e057d7d62',1,1599560116),(73,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','d3f1e01c-23b0-4440-a0c0-6dfc3a7074db','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','d3f1e01c-23b0-4440-a0c0-6dfc3a7074db',1,1599560116),(74,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','07b0918e-eee6-4b6a-84de-be1931f5b439','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','07b0918e-eee6-4b6a-84de-be1931f5b439',1,1599560361),(75,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','8b5e9da6-92d3-4a44-9d36-df6e88c01554','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','8b5e9da6-92d3-4a44-9d36-df6e88c01554',1,1599560364),(76,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','42b0805d-df97-4bbe-817f-39b6e2d9a7d2','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','42b0805d-df97-4bbe-817f-39b6e2d9a7d2',1,1599560367),(77,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','12562b60-91da-488e-bbf1-c491485a5549','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','12562b60-91da-488e-bbf1-c491485a5549',1,1599560398),(78,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','4c9b86b1-af3c-4af9-aa58-41790db5cff2','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','4c9b86b1-af3c-4af9-aa58-41790db5cff2',1,1599560422),(79,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','21657bad-c84f-4f3a-9088-ed1bde78e04b','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','21657bad-c84f-4f3a-9088-ed1bde78e04b',1,1599560450),(80,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','3bce3aba-aae2-4e5f-aa26-bd2c96e97f21','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','3bce3aba-aae2-4e5f-aa26-bd2c96e97f21',1,1599560461),(81,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','d6cf058f-6436-46e6-bfb2-ec4b7285ef8f','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','d6cf058f-6436-46e6-bfb2-ec4b7285ef8f',1,1599560611),(82,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','395998dc-d954-4241-a967-89657ff093cd','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','395998dc-d954-4241-a967-89657ff093cd',1,1599560690),(83,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','951e4fd5-a7c3-4580-bfaa-53b6b4e8f3aa','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','951e4fd5-a7c3-4580-bfaa-53b6b4e8f3aa',1,1599560693),(84,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','f72ac469-821f-4204-b789-7f9d0d268aca','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','f72ac469-821f-4204-b789-7f9d0d268aca',1,1599560813),(85,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','3b99e622-eb0a-426e-bfb2-4975c84ffbce','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','3b99e622-eb0a-426e-bfb2-4975c84ffbce',1,1599560816),(86,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','b0d7643a-acef-4e0e-9d99-571494446992','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','b0d7643a-acef-4e0e-9d99-571494446992',1,1599560819),(87,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','4ed65ce4-b303-4fb3-be63-17b093df7e55','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','4ed65ce4-b303-4fb3-be63-17b093df7e55',1,1599560822),(88,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','5151d80b-5eb4-4443-a68b-a2155cbe1053','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','5151d80b-5eb4-4443-a68b-a2155cbe1053',1,1599561131),(89,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','0591c958-a38d-4504-9288-64b395d1e528','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','0591c958-a38d-4504-9288-64b395d1e528',1,1599561134),(90,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','f039b6bf-295d-4377-962b-d6f178994307','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','f039b6bf-295d-4377-962b-d6f178994307',1,1599561137),(91,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','e14a2b58-4332-4be0-944e-84af2f1d85cb','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','e14a2b58-4332-4be0-944e-84af2f1d85cb',1,1599561140),(92,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','055e60a4-b376-4a82-9563-2819d2f77a14','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','055e60a4-b376-4a82-9563-2819d2f77a14',1,1599561196),(93,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','deb4ef9d-e847-4f9d-8e0b-8e6964406242','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','deb4ef9d-e847-4f9d-8e0b-8e6964406242',1,1599561199),(94,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','0d5933b4-6c88-4c1f-a88a-b00a0d71b09d','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','0d5933b4-6c88-4c1f-a88a-b00a0d71b09d',1,1599561202),(95,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','72e85bb7-b2d5-48db-a6f3-2e1bf4181588','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','72e85bb7-b2d5-48db-a6f3-2e1bf4181588',1,1599561205),(96,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','c7900a11-48de-499b-bf5f-8f956d9cf032','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','c7900a11-48de-499b-bf5f-8f956d9cf032',1,1599561323),(97,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','3936f5f1-e46d-420d-aed8-958cd61924e0','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','3936f5f1-e46d-420d-aed8-958cd61924e0',1,1599561323),(98,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','3a34f171-a2cb-4bc2-b814-c5676b87e0b6','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','3a34f171-a2cb-4bc2-b814-c5676b87e0b6',1,1599561324),(99,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','9647286a-0afe-4c2f-9a44-dc8ee996ecf6','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','9647286a-0afe-4c2f-9a44-dc8ee996ecf6',1,1599561326),(100,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','8d028b96-38db-4fcf-8f29-a80aeb0491ec','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','8d028b96-38db-4fcf-8f29-a80aeb0491ec',1,1599561495),(101,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','ecfcf1fb-24ff-4824-b4f1-c24425a66c1e','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','ecfcf1fb-24ff-4824-b4f1-c24425a66c1e',1,1599561496),(102,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','479dddba-30c4-4542-acd0-55a5afdeac04','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','479dddba-30c4-4542-acd0-55a5afdeac04',1,1599561497),(103,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','83d93262-1547-465c-a0c5-61cf35fa52d0','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','83d93262-1547-465c-a0c5-61cf35fa52d0',1,1599561498),(104,'img','截屏2020-09-08 下午4.51.56.png','截屏2020-09-08 下午4.51.56','png','a7fd0998-c307-400e-8f1e-3fe690996ed8','image/png',31699,'','','','','','','','FqT0mhFnZ6FZMpmvK-6iPwAQk5KF','qiniu','cigoadmin-img','a7fd0998-c307-400e-8f1e-3fe690996ed8',1,1599561499),(105,'img','截屏2020-09-08 下午4.51.59.png','截屏2020-09-08 下午4.51.59','png','91af68e0-eba5-4a4b-9a62-aefeb30d762b','image/png',44470,'','','','','','','','FpEa9R6K3YAg-fhe-pQ4bLB5iZ1j','qiniu','cigoadmin-img','91af68e0-eba5-4a4b-9a62-aefeb30d762b',1,1599561500),(106,'img','截屏2020-09-08 下午6.23.13.png','截屏2020-09-08 下午6.23.13','png','a216a713-6840-402f-b0b8-4b46730a4c38','image/png',208200,'','','','','','','','FuLN9vxgWdTolKFYXozG8DiFDxsa','qiniu','cigoadmin-img','a216a713-6840-402f-b0b8-4b46730a4c38',1,1599561501),(107,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','8553b7b3-16d5-46e3-a0ef-439f07a58665','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','8553b7b3-16d5-46e3-a0ef-439f07a58665',1,1599561551),(108,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','f42f16ad-5781-4a63-9006-48bbcb09a574','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','f42f16ad-5781-4a63-9006-48bbcb09a574',1,1599561552),(109,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','4c7cd25d-9853-4057-96b1-b3cfa27a80e6','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','4c7cd25d-9853-4057-96b1-b3cfa27a80e6',1,1599561553),(110,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','f79a5c47-c311-40f5-bc97-88996a577909','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','f79a5c47-c311-40f5-bc97-88996a577909',1,1599561554),(111,'img','截屏2020-09-08 下午4.51.56.png','截屏2020-09-08 下午4.51.56','png','da6499da-30c3-4d25-bad7-49d268af6482','image/png',31699,'','','','','','','','FqT0mhFnZ6FZMpmvK-6iPwAQk5KF','qiniu','cigoadmin-img','da6499da-30c3-4d25-bad7-49d268af6482',1,1599561555),(112,'img','截屏2020-09-08 下午4.51.59.png','截屏2020-09-08 下午4.51.59','png','876238f4-c4fb-4154-9186-f1a1c092bf2b','image/png',44470,'','','','','','','','FpEa9R6K3YAg-fhe-pQ4bLB5iZ1j','qiniu','cigoadmin-img','876238f4-c4fb-4154-9186-f1a1c092bf2b',1,1599561556),(113,'img','截屏2020-09-08 下午6.23.13.png','截屏2020-09-08 下午6.23.13','png','cb3cc2c1-f02e-472e-8dfc-d428e337351b','image/png',208200,'','','','','','','','FuLN9vxgWdTolKFYXozG8DiFDxsa','qiniu','cigoadmin-img','cb3cc2c1-f02e-472e-8dfc-d428e337351b',1,1599561557),(114,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','6b3104b6-80ee-4237-aacb-d50ca38fe90c','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','6b3104b6-80ee-4237-aacb-d50ca38fe90c',1,1599562043),(115,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','860b42a3-70e1-4713-896c-06223287d507','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','860b42a3-70e1-4713-896c-06223287d507',1,1599562044),(116,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','f69fbaed-8d4c-4d2c-ba9a-d3638859a898','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','f69fbaed-8d4c-4d2c-ba9a-d3638859a898',1,1599562045),(117,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','a77899cd-a33f-478b-9be1-a698a6e1bd21','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','a77899cd-a33f-478b-9be1-a698a6e1bd21',1,1599562046),(118,'img','截屏2020-09-08 下午4.51.56.png','截屏2020-09-08 下午4.51.56','png','a0647388-4dc1-4858-b667-a0fa6217f9c4','image/png',31699,'','','','','','','','FqT0mhFnZ6FZMpmvK-6iPwAQk5KF','qiniu','cigoadmin-img','a0647388-4dc1-4858-b667-a0fa6217f9c4',1,1599562047),(119,'img','截屏2020-09-08 下午4.51.59.png','截屏2020-09-08 下午4.51.59','png','0977e330-4df9-4553-b082-96e3feb4d8fe','image/png',44470,'','','','','','','','FpEa9R6K3YAg-fhe-pQ4bLB5iZ1j','qiniu','cigoadmin-img','0977e330-4df9-4553-b082-96e3feb4d8fe',1,1599562048),(120,'img','截屏2020-09-08 下午6.23.13.png','截屏2020-09-08 下午6.23.13','png','7122d4a7-9f69-4a01-ac24-fe02f0d155bf','image/png',208200,'','','','','','','','FuLN9vxgWdTolKFYXozG8DiFDxsa','qiniu','cigoadmin-img','7122d4a7-9f69-4a01-ac24-fe02f0d155bf',1,1599562049),(121,'img','截屏2020-09-08 下午6.49.03.png','截屏2020-09-08 下午6.49.03','png','32ff3564-ad89-4eca-aa75-aa7950d1d70a','image/png',607842,'','','','','','','','FgybCES-NOsywPxTclIwrPc2RlWJ','qiniu','cigoadmin-img','32ff3564-ad89-4eca-aa75-aa7950d1d70a',1,1599562161),(122,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','42c8cfa2-7820-4c60-91e6-f0a9b43fcf00','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','42c8cfa2-7820-4c60-91e6-f0a9b43fcf00',1,1599562274),(123,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','3284e7d3-f1a7-4ba5-8e56-3329ac8e57fc','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','3284e7d3-f1a7-4ba5-8e56-3329ac8e57fc',1,1599562275),(124,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','e5a1e800-2946-446c-9dbc-0ea7cda91bd9','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','e5a1e800-2946-446c-9dbc-0ea7cda91bd9',1,1599562276),(125,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','4fe09765-da04-442f-ba79-e07c1e910a14','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','4fe09765-da04-442f-ba79-e07c1e910a14',1,1599562277),(126,'img','截屏2020-09-08 下午4.51.56.png','截屏2020-09-08 下午4.51.56','png','72ea1522-4b50-4d49-8a2c-71e35ba9fb33','image/png',31699,'','','','','','','','FqT0mhFnZ6FZMpmvK-6iPwAQk5KF','qiniu','cigoadmin-img','72ea1522-4b50-4d49-8a2c-71e35ba9fb33',1,1599562278),(127,'img','截屏2020-09-08 下午4.51.59.png','截屏2020-09-08 下午4.51.59','png','723812a2-307d-4c64-81d3-658bf9b210a0','image/png',44470,'','','','','','','','FpEa9R6K3YAg-fhe-pQ4bLB5iZ1j','qiniu','cigoadmin-img','723812a2-307d-4c64-81d3-658bf9b210a0',1,1599562279),(128,'img','截屏2020-09-08 下午6.23.13.png','截屏2020-09-08 下午6.23.13','png','0000fc12-c86e-4be5-b7f9-9ed8e37ad748','image/png',208200,'','','','','','','','FuLN9vxgWdTolKFYXozG8DiFDxsa','qiniu','cigoadmin-img','0000fc12-c86e-4be5-b7f9-9ed8e37ad748',1,1599562280),(129,'img','截屏2020-09-08 下午6.49.03.png','截屏2020-09-08 下午6.49.03','png','621a5e57-f244-429d-aec4-c7482427a6aa','image/png',607842,'','','','','','','','FgybCES-NOsywPxTclIwrPc2RlWJ','qiniu','cigoadmin-img','621a5e57-f244-429d-aec4-c7482427a6aa',1,1599562281),(130,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','3dd92361-318e-460d-b6b8-6211c1947caf','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','3dd92361-318e-460d-b6b8-6211c1947caf',1,1599562521),(131,'img','截屏2020-09-08 下午12.42.22.png','截屏2020-09-08 下午12.42.22','png','45feb693-ecc0-4d54-90aa-7a8fcd2dba08','image/png',37886,'','','','','','','','Fi6cH8J2VlUtTCcIkebbhCto2PIv','qiniu','cigoadmin-img','45feb693-ecc0-4d54-90aa-7a8fcd2dba08',1,1599562522),(132,'img','截屏2020-09-08 下午4.51.50.png','截屏2020-09-08 下午4.51.50','png','14ba7c08-0df8-4b40-9229-d1995c32a771','image/png',56929,'','','','','','','','FkT7sRoFT1KOgERpstJNSZw2sIOt','qiniu','cigoadmin-img','14ba7c08-0df8-4b40-9229-d1995c32a771',1,1599562522),(133,'img','截屏2020-09-08 下午4.51.54.png','截屏2020-09-08 下午4.51.54','png','57408406-335c-442a-ab08-460859f74efd','image/png',77099,'','','','','','','','FkrTY2fEd4wI1AMZ8rJ2xopcywuF','qiniu','cigoadmin-img','57408406-335c-442a-ab08-460859f74efd',1,1599562524),(134,'img','截屏2020-09-08 下午4.51.56.png','截屏2020-09-08 下午4.51.56','png','227a2981-1e4b-4671-b508-aaf26435cf7a','image/png',31699,'','','','','','','','FqT0mhFnZ6FZMpmvK-6iPwAQk5KF','qiniu','cigoadmin-img','227a2981-1e4b-4671-b508-aaf26435cf7a',1,1599562525),(135,'img','截屏2020-09-08 下午4.51.59.png','截屏2020-09-08 下午4.51.59','png','494a439a-4f42-46a1-9762-5f3db4b79015','image/png',44470,'','','','','','','','FpEa9R6K3YAg-fhe-pQ4bLB5iZ1j','qiniu','cigoadmin-img','494a439a-4f42-46a1-9762-5f3db4b79015',1,1599562526),(136,'img','截屏2020-09-08 下午6.23.13.png','截屏2020-09-08 下午6.23.13','png','d7ac94ba-cbf4-4c22-845f-ba21b646df60','image/png',208200,'','','','','','','','FuLN9vxgWdTolKFYXozG8DiFDxsa','qiniu','cigoadmin-img','d7ac94ba-cbf4-4c22-845f-ba21b646df60',1,1599562527),(137,'img','截屏2020-09-08 下午6.49.03.png','截屏2020-09-08 下午6.49.03','png','e5f53c48-7e39-4ef0-9d22-23d785bda5a7','image/png',607842,'','','','','','','','FgybCES-NOsywPxTclIwrPc2RlWJ','qiniu','cigoadmin-img','e5f53c48-7e39-4ef0-9d22-23d785bda5a7',1,1599562528),(138,'img','截屏2020-09-09 上午10.38.31.png','截屏2020-09-09 上午10.38.31','png','490b2511-4aac-4883-9e5c-5a2765919e10','image/png',317372,'','','','','','','','FvxExYYPTsZl0P__YnG3aei4-qKQ','qiniu','cigoadmin-img','490b2511-4aac-4883-9e5c-5a2765919e10',1,1599824669),(139,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','13f39966-4d1a-49a1-a632-19f92595ee70','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','13f39966-4d1a-49a1-a632-19f92595ee70',1,1599824671),(140,'img','截屏2020-09-08 下午6.49.03.png','截屏2020-09-08 下午6.49.03','png','c4356615-b485-4788-aeb9-92d3eed90558','image/png',607842,'','','','','','','','FgybCES-NOsywPxTclIwrPc2RlWJ','qiniu','cigoadmin-img','c4356615-b485-4788-aeb9-92d3eed90558',1,1599824671),(141,'img','截屏2020-09-09 上午10.40.41.png','截屏2020-09-09 上午10.40.41','png','79248995-65bc-4681-8c40-da6aa0d54d87','image/png',70874,'','','','','','','','FuJBO2W0-8z-Hoh6gFqAEc1LXDBM','qiniu','cigoadmin-img','79248995-65bc-4681-8c40-da6aa0d54d87',1,1599824671),(142,'img','截屏2020-09-09 上午10.39.24.png','截屏2020-09-09 上午10.39.24','png','4172f3a8-08cd-4f3b-a63c-c763d8631d26','image/png',63946,'','','','','','','','FhMAqsuYG9xPdZccs_L5N6gr-A5_','qiniu','cigoadmin-img','4172f3a8-08cd-4f3b-a63c-c763d8631d26',1,1599824674),(143,'img','截屏2020-09-09 下午3.55.01.png','截屏2020-09-09 下午3.55.01','png','09356e93-f3fc-462e-9ed3-911e58783802','image/png',269533,'','','','','','','','FjVmThbcOrsXJf8erz04SLxnRKAz','qiniu','cigoadmin-img','09356e93-f3fc-462e-9ed3-911e58783802',1,1599824674),(144,'img','截屏2020-09-09 上午10.38.14.png','截屏2020-09-09 上午10.38.14','png','c1ae2dd3-d4bb-4985-bd0c-85c31f6a79e3','image/png',305735,'','','','','','','','Fpz33PH46YUgthprnYefV061pcsa','qiniu','cigoadmin-img','c1ae2dd3-d4bb-4985-bd0c-85c31f6a79e3',1,1599824674),(145,'img','截屏2020-09-09 下午4.03.44.png','截屏2020-09-09 下午4.03.44','png','31da44da-d0d8-44bb-b99b-da72b1892da9','image/png',825075,'','','','','','','','FpiG7VIrVWU9unzrey9B-Ki4sPBs','qiniu','cigoadmin-img','31da44da-d0d8-44bb-b99b-da72b1892da9',1,1599824677),(146,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','dda1e165-1d80-418b-aaa3-e9539024a820','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','dda1e165-1d80-418b-aaa3-e9539024a820',1,1600280720),(147,'img','property.png','property','png','56c5fc03-ad4c-44ba-bd4c-dd3d393bafb6','image/png',1261,'','','','','','','','FqaUtJV484QwOUJFTRrp1gjOG4Iw','qiniu','cigoadmin-img','56c5fc03-ad4c-44ba-bd4c-dd3d393bafb6',1,1600323639),(153,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','a7f1f691-5640-4c87-956a-ff0a78e36f35','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','a7f1f691-5640-4c87-956a-ff0a78e36f35',1,1600808251),(154,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','bd8c5117-eb59-4a9b-a1a3-f59f541f4733','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','bd8c5117-eb59-4a9b-a1a3-f59f541f4733',1,1600808270),(155,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','c4068561-7939-4e83-8804-f72ce7aaee4c','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','c4068561-7939-4e83-8804-f72ce7aaee4c',1,1600808308),(156,'img','截屏2020-09-23 上午5.01.17.png','截屏2020-09-23 上午5.01.17','png','8eb9825f-3c6f-493d-949c-3970b6b181ba','image/png',48305,'','','','','','','','FlQGgBm7zoxuJdQcXNhG8zP0xafV','qiniu','cigoadmin-img','8eb9825f-3c6f-493d-949c-3970b6b181ba',1,1600808500),(157,'img','截屏2020-09-09 上午10.39.24.png','截屏2020-09-09 上午10.39.24','png','12f03fda-238b-48ae-b656-fe15acdd175c','image/png',63946,'','','','','','','','FhMAqsuYG9xPdZccs_L5N6gr-A5_','qiniu','cigoadmin-img','12f03fda-238b-48ae-b656-fe15acdd175c',1,1600829755),(158,'img','截屏2020-09-09 下午4.03.44.png','截屏2020-09-09 下午4.03.44','png','d9832faa-cded-4b1d-a691-96f4ae49407b','image/png',825075,'','','','','','','','FpiG7VIrVWU9unzrey9B-Ki4sPBs','qiniu','cigoadmin-img','d9832faa-cded-4b1d-a691-96f4ae49407b',1,1600829815),(159,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','f3634a22-01f2-431b-98f2-ac95046c80ce','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','f3634a22-01f2-431b-98f2-ac95046c80ce',1,1600852713),(160,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','7e0c06a3-54cf-4861-abee-ede7e226f913','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','7e0c06a3-54cf-4861-abee-ede7e226f913',1,1600853023),(161,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','40d3eada-dbc0-4977-b1ae-06d8311a530d','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','40d3eada-dbc0-4977-b1ae-06d8311a530d',1,1600853283),(162,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','f0487c1a-52c4-451c-bc2d-88ac4370e4ea','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','f0487c1a-52c4-451c-bc2d-88ac4370e4ea',1,1600853569),(163,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','e877282f-54e1-4b00-9902-0de0d26ce384','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','e877282f-54e1-4b00-9902-0de0d26ce384',1,1600853650),(164,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','dcd8d0bf-0d01-46e4-9862-78b25bf5b5cc','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','dcd8d0bf-0d01-46e4-9862-78b25bf5b5cc',1,1600854064),(165,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','188f3ab5-949b-4f3f-8f0b-88ec4356be25','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','188f3ab5-949b-4f3f-8f0b-88ec4356be25',1,1600854343),(166,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','4eb0ba8b-ba3c-4446-943a-a443e142c285','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','4eb0ba8b-ba3c-4446-943a-a443e142c285',1,1600854390),(167,'img','截屏2020-09-09 上午10.38.14.png','截屏2020-09-09 上午10.38.14','png','758cc202-9934-4655-a9c4-c52178969e5d','image/png',305735,'','','','','','','','Fpz33PH46YUgthprnYefV061pcsa','qiniu','cigoadmin-img','758cc202-9934-4655-a9c4-c52178969e5d',1,1600854506),(168,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','72493b06-7f70-47bd-9e6d-cbb124335f59','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','72493b06-7f70-47bd-9e6d-cbb124335f59',1,1600854951),(169,'img','截屏2020-09-08 下午4.51.59.png','截屏2020-09-08 下午4.51.59','png','31c502ff-a865-479b-9320-602ba101ee05','image/png',44470,'','','','','','','','FpEa9R6K3YAg-fhe-pQ4bLB5iZ1j','qiniu','cigoadmin-img','31c502ff-a865-479b-9320-602ba101ee05',1,1600855008),(170,'img','elevator.png','elevator','png','8266f172-f5d7-4710-864b-3b4eb74e5620','image/png',4410,'','','','','','','','Fl2eD0ogIkgNzJZf-dDAkBUeFczd','qiniu','cigoadmin-img','8266f172-f5d7-4710-864b-3b4eb74e5620',1,1600861208),(171,'img','截屏2020-09-08 下午12.42.20.png','截屏2020-09-08 下午12.42.20','png','4b462b53-f604-4897-b41b-1f8f8c6e0f1e','image/png',96531,'','','','','','','','FtBKmN_ViZnjD_Z8e8WFrJiWlRP2','qiniu','cigoadmin-img','4b462b53-f604-4897-b41b-1f8f8c6e0f1e',1,1600867987),(172,'img','截屏2020-09-23 下午5.05.29.png','截屏2020-09-23 下午5.05.29','png','0dbc0e74-0c2b-45c6-b05f-6a3fcd160311','image/png',545739,'','','','','','','','FnHy30gznbYTIcUXtIM5byk2RSMV','qiniu','cigoadmin-img','0dbc0e74-0c2b-45c6-b05f-6a3fcd160311',1,1600867999),(173,'img','截屏2020-09-23 上午5.01.17.png','截屏2020-09-23 上午5.01.17','png','ec7ccda3-0d83-41a2-ab87-83d4ea42f122','image/png',48305,'','','','','','','','FlQGgBm7zoxuJdQcXNhG8zP0xafV','qiniu','cigoadmin-img','ec7ccda3-0d83-41a2-ab87-83d4ea42f122',1,1600868030),(174,'img','截屏2020-09-18 下午3.36.46.png','截屏2020-09-18 下午3.36.46','png','0bc2ece8-6788-416b-917d-e7344cb22c5b','image/png',26768,'','','','','','','','Fkf4t2yMViw22C3SS0n18-crL_Kp','qiniu','cigoadmin-img','0bc2ece8-6788-416b-917d-e7344cb22c5b',1,1600878084),(175,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','60deda8d-06ce-47ad-a788-f494c0697117','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','60deda8d-06ce-47ad-a788-f494c0697117',1,1600933388),(176,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','0eebe239-ca4c-41e8-8a91-4d807adf69ae','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','0eebe239-ca4c-41e8-8a91-4d807adf69ae',1,1600933560),(177,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','fc495df9-de32-408e-a2df-a7abcf95f430','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','fc495df9-de32-408e-a2df-a7abcf95f430',1,1600933920),(178,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','7316b506-0aed-4080-8c8c-4cc428d5dcaf','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','7316b506-0aed-4080-8c8c-4cc428d5dcaf',1,1600938473),(179,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','367bb78f-77a2-44ae-aa0b-4a41b79af0d2','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','367bb78f-77a2-44ae-aa0b-4a41b79af0d2',1,1600943735),(180,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','e9c638a6-7725-462b-8de2-1250e0bda7da','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','e9c638a6-7725-462b-8de2-1250e0bda7da',1,1600944304),(181,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','9e96beaa-e731-4f1f-803c-6559d794c4d7','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','9e96beaa-e731-4f1f-803c-6559d794c4d7',1,1600944407),(182,'img','logo-1024-1.png','logo-1024-1','png','2f196c88-45e8-40ab-8f01-56db072217f2','image/png',21875,'','','','','','','','Fv0bfftYQ6h6yHa-68P72EeGJoPE','qiniu','cigoadmin-img','2f196c88-45e8-40ab-8f01-56db072217f2',1,1600944507),(183,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','b3f882c6-1069-44f4-98a1-ccfc2325fc46','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','b3f882c6-1069-44f4-98a1-ccfc2325fc46',1,1600944565),(184,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','1150017d-1a71-401f-b87c-9d551dd66aa0','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','1150017d-1a71-401f-b87c-9d551dd66aa0',1,1601172453),(185,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','316e767d-3355-45dc-99b7-05220ebf5f3b','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','316e767d-3355-45dc-99b7-05220ebf5f3b',1,1601172516),(186,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','2bcd5321-7147-4315-9a6c-b20483b844b6','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','2bcd5321-7147-4315-9a6c-b20483b844b6',1,1601173014),(187,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','b56828f4-4dd4-4f18-b27e-4af9e70f01de','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','b56828f4-4dd4-4f18-b27e-4af9e70f01de',1,1601173050),(188,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','730d7a86-566b-422f-9159-ace192c94a82','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','730d7a86-566b-422f-9159-ace192c94a82',1,1601173118),(189,'img','迪迦奥特曼.jpg','迪迦奥特曼','jpg','6b48c423-09cb-43bd-9b08-721080d6aee8','image/jpeg',42883,'','','','','','','','FrFETfFpxFfjAuVUzW7l78XqFmT_','qiniu','cigoadmin-img','6b48c423-09cb-43bd-9b08-721080d6aee8',1,1601173147),(190,'img','logo-icon.png','logo-icon','png','a06ca224-555f-4844-abb7-a65133e46def','image/png',8211,'','','','','','','','Fg4PTT_Oo2bJDOcdRIB9AyyfEP58','qiniu','cigoadmin-img','a06ca224-555f-4844-abb7-a65133e46def',1,1601179111),(191,'img','星途vx.jpg','星途vx','jpg','18c040b0-69bc-4952-a881-9bf32a66d309','image/jpeg',199890,'','','','','','','','Fq6IQwOXntx0BC0chE6Bw5AAIDc7','qiniu','cigoadmin-img','18c040b0-69bc-4952-a881-9bf32a66d309',1,1601179252),(192,'img','2020_0421_9a5e6e2ej00q948y0001tc000hs00dym.jpg','2020_0421_9a5e6e2ej00q948y0001tc000hs00dym','jpg','72d3a6a4-b3d0-47f0-b566-5f50d76adb4e','image/jpeg',67515,'','','','','','','','Fq8KJCKjx84-jDxHxFAspX0iuJn2','qiniu','cigoadmin-img','72d3a6a4-b3d0-47f0-b566-5f50d76adb4e',1,1601220972),(193,'img','2020_0421_9a5e6e2ej00q948y0001tc000hs00dym.jpg','2020_0421_9a5e6e2ej00q948y0001tc000hs00dym','jpg','57cd3b29-c5bf-4780-a4d5-5b79e9655740','image/jpeg',67515,'','','','','','','','Fq8KJCKjx84-jDxHxFAspX0iuJn2','qiniu','cigoadmin-img','57cd3b29-c5bf-4780-a4d5-5b79e9655740',1,1601221032),(194,'img','2020_0421_9a5e6e2ej00q948y0001tc000hs00dym.jpg','2020_0421_9a5e6e2ej00q948y0001tc000hs00dym','jpg','5d375720-7d3f-45de-8864-166bb76e9bca','image/jpeg',67515,'','','','','','','','Fq8KJCKjx84-jDxHxFAspX0iuJn2','qiniu','cigoadmin-img','5d375720-7d3f-45de-8864-166bb76e9bca',1,1601221186),(195,'img','2020_0421_9a5e6e2ej00q948y0001tc000hs00dym.jpg','2020_0421_9a5e6e2ej00q948y0001tc000hs00dym','jpg','011d83e0-b428-46c8-aaa2-e37ecae27217','image/jpeg',67515,'','','','','','','','Fq8KJCKjx84-jDxHxFAspX0iuJn2','qiniu','cigoadmin-img','011d83e0-b428-46c8-aaa2-e37ecae27217',1,1601348489),(196,'img','2020_0421_9a5e6e2ej00q948y0001tc000hs00dym.jpg','2020_0421_9a5e6e2ej00q948y0001tc000hs00dym','jpg','4dea0fb8-3193-40fb-9afc-2603b0756339','image/jpeg',67515,'','','','','','','','Fq8KJCKjx84-jDxHxFAspX0iuJn2','qiniu','cigoadmin-img','4dea0fb8-3193-40fb-9afc-2603b0756339',1,1601348690);
/*!40000 ALTER TABLE `cg_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_friendly_links`
--

DROP TABLE IF EXISTS `cg_friendly_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_friendly_links` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:显示;0:不显示',
  `rating` int NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `list_order` float NOT NULL DEFAULT '10000' COMMENT '排序',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接描述',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接地址',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '友情链接名称',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '友情链接图标',
  `target` varchar(10) NOT NULL DEFAULT '' COMMENT '友情链接打开方式',
  `rel` varchar(50) NOT NULL DEFAULT '' COMMENT '链接与网站的关系',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='友情链接表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_friendly_links`
--

LOCK TABLES `cg_friendly_links` WRITE;
/*!40000 ALTER TABLE `cg_friendly_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_friendly_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_notice`
--

DROP TABLE IF EXISTS `cg_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_notice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `sender` varchar(25) NOT NULL DEFAULT '' COMMENT '发布者',
  `publish_time` int NOT NULL DEFAULT '0' COMMENT '发布时间',
  `create_time` int unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='通知公告';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_notice`
--

LOCK TABLES `cg_notice` WRITE;
/*!40000 ALTER TABLE `cg_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_notice_read`
--

DROP TABLE IF EXISTS `cg_notice_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_notice_read` (
  `read_id` int NOT NULL AUTO_INCREMENT,
  `msg_id` int NOT NULL DEFAULT '0' COMMENT '公告id',
  `user_id` int NOT NULL DEFAULT '0' COMMENT '用户id',
  `read_time` int NOT NULL DEFAULT '0' COMMENT '阅读时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1用户查看，2用户删除',
  PRIMARY KEY (`read_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='公告阅读表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_notice_read`
--

LOCK TABLES `cg_notice_read` WRITE;
/*!40000 ALTER TABLE `cg_notice_read` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_notice_read` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_plugin`
--

DROP TABLE IF EXISTS `cg_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_plugin` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '插件类型;1:网站;8:微信',
  `has_admin` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台管理,0:没有;1:有',
  `status` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:开启;0:禁用',
  `create_time` int unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '插件标识名,英文字母(惟一)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `demo_url` varchar(50) NOT NULL DEFAULT '' COMMENT '演示地址，带协议',
  `hooks` varchar(255) NOT NULL DEFAULT '' COMMENT '实现的钩子;以“,”分隔',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件作者',
  `author_url` varchar(50) NOT NULL DEFAULT '' COMMENT '作者网站链接',
  `version` varchar(20) NOT NULL DEFAULT '' COMMENT '插件版本号',
  `description` varchar(255) NOT NULL COMMENT '插件描述',
  `config` text COMMENT '插件配置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='插件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_plugin`
--

LOCK TABLES `cg_plugin` WRITE;
/*!40000 ALTER TABLE `cg_plugin` DISABLE KEYS */;
INSERT INTO `cg_plugin` VALUES (1,1,0,1,0,'Qiniu','七牛云存储','','','Medical','','1.0.1','七牛专享优惠码:507670e8','{\"accessKey\":\"g_xmX8LrSr5uj3AevJwqpAtYFHrhNsZTc_lgq79I\",\"secretKey\":\"4XJtBqZui-IcaHtKNl3KRxyTz6WROIShQkz7Wg03\",\"protocol\":\"http\",\"domain\":\"cdn.lnjiliang.com\",\"bucket\":\"jiliang-talent\",\"zone\":\"z2\",\"style_separator\":\"-\"}'),(2,1,1,1,0,'DComment','文章评论','','','','','1.3','文章评论插件','{\"comment_type\":\"1\",\"comment_check\":\"2\",\"comment_interval\":\"5\"}');
/*!40000 ALTER TABLE `cg_plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_recycle_bin`
--

DROP TABLE IF EXISTS `cg_recycle_bin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_recycle_bin` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int DEFAULT '0' COMMENT '删除内容 id',
  `create_time` int unsigned DEFAULT '0' COMMENT '创建时间',
  `table_name` varchar(60) DEFAULT '' COMMENT '删除内容所在表名',
  `name` varchar(255) DEFAULT '' COMMENT '删除内容名称',
  `user_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT=' 回收站';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_recycle_bin`
--

LOCK TABLES `cg_recycle_bin` WRITE;
/*!40000 ALTER TABLE `cg_recycle_bin` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_recycle_bin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_third_party_user_bak`
--

DROP TABLE IF EXISTS `cg_third_party_user_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_third_party_user_bak` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '本站用户id',
  `last_login_time` int unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `expire_time` int unsigned NOT NULL DEFAULT '0' COMMENT 'access_token过期时间',
  `create_time` int unsigned NOT NULL DEFAULT '0' COMMENT '绑定时间',
  `login_times` int unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `status` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '状态;1:正常;0:禁用',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `third_party` varchar(20) NOT NULL DEFAULT '' COMMENT '第三方惟一码',
  `app_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方应用 id',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `access_token` varchar(512) NOT NULL DEFAULT '' COMMENT '第三方授权码',
  `openid` varchar(40) NOT NULL DEFAULT '' COMMENT '第三方用户id',
  `union_id` varchar(64) NOT NULL DEFAULT '' COMMENT '第三方用户多个产品中的惟一 id,(如:微信平台)',
  `more` text COMMENT '扩展信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='第三方用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_third_party_user_bak`
--

LOCK TABLES `cg_third_party_user_bak` WRITE;
/*!40000 ALTER TABLE `cg_third_party_user_bak` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_third_party_user_bak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_upload_progress`
--

DROP TABLE IF EXISTS `cg_upload_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_upload_progress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key_token` varchar(12) DEFAULT NULL,
  `num` varchar(6) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_upload_progress`
--

LOCK TABLES `cg_upload_progress` WRITE;
/*!40000 ALTER TABLE `cg_upload_progress` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_upload_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user`
--

DROP TABLE IF EXISTS `cg_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `module` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'admin' COMMENT '系统模块(区分后台)',
  `role_flag` int unsigned NOT NULL DEFAULT '1' COMMENT '用户类型\n001-1-普通用户\n010-2-管理员\n100-4-主管理员',
  `auth_group` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '[]',
  `token` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户token',
  `token_create_time` int NOT NULL DEFAULT '0' COMMENT 'token创建时间',
  `img` int NOT NULL DEFAULT '0' COMMENT '头像',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `realname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '姓名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint NOT NULL DEFAULT '0' COMMENT '性别：0-保密；1-男；2-女',
  `email` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `country` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `country_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `province` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '省份编号',
  `province_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `city` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '城市编号',
  `city_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `area` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `area_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `town` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `town_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `path_code` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '省市级联path',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '详细地址',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态(0-禁用，1启用，-1删除)',
  `is_online` tinyint NOT NULL DEFAULT '0' COMMENT '是否在线（0-否，1是）',
  `last_log_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '上次登陆IP',
  `last_log_time` int unsigned NOT NULL DEFAULT '0' COMMENT '上次登陆时间',
  `create_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '注册IP',
  `create_time` int unsigned NOT NULL DEFAULT '0' COMMENT '注册日期',
  `update_time` int unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `log_fail_num` tinyint NOT NULL DEFAULT '0' COMMENT '登录失败次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='商城后台管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user`
--

LOCK TABLES `cg_user` WRITE;
/*!40000 ALTER TABLE `cg_user` DISABLE KEYS */;
INSERT INTO `cg_user` VALUES (174,'admin',4,'[55,23,24,54,56,57]','d9b6a45ea94fd9b24abee2ee50b3c442',1601349404,183,'admin','17854220624','OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==','','主管理员',0,'cigoos@cigoos.com','','','','','','','','','','','','',1,0,'',1601349404,'',1598887937,1600944573,0),(175,'admin',2,'[55,24,23]','',0,0,'cigoos-1','','OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==','','',0,'cigoos@cigoos.com','','','','','','','','','','','','',0,0,'',0,'',1600757196,1600767735,0),(176,'client',1,'[]','',0,172,'zim','17854220611','OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==','','',1,'zim@cigoos.com','','','','','','','','','','','','',1,0,'',0,'',1600760388,1600868007,0),(177,'client',1,'[]','',0,173,'tom','17854220623','OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==','','',1,'tom@cigoos.com','','','','','','','','','','','','',1,0,'',0,'',1600762630,1600868040,0),(178,'admin',2,'[24,23,55]','',0,191,'lucy1','','OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==','','我是Lucy',0,'lucy@cigoos.com','','','','','','','','','','','','',1,0,'',0,'',1600763106,1601179826,0),(179,'client',1,'[]','',0,188,'Jerry','17854220624','OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==','','我是Jerry',1,'jerry@cigoos.com','','','','','','','','','','','','',0,0,'',0,'',1601172479,1601173127,0),(180,'client',1,'[]','',0,189,'bob','17854220611','OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==','','我是Bob',0,'bob@cigoos.com','','','','','','','','','','','','',0,0,'',0,'',1601173182,0,0);
/*!40000 ALTER TABLE `cg_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_action`
--

DROP TABLE IF EXISTS `cg_user_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_action` (
  `id` int NOT NULL AUTO_INCREMENT,
  `score` int NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  `reward_number` int NOT NULL DEFAULT '0' COMMENT '奖励次数',
  `cycle_type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '周期类型;0:不限;1:按天;2:按小时;3:永久',
  `cycle_time` int unsigned NOT NULL DEFAULT '0' COMMENT '周期时间值',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `app` varchar(50) NOT NULL DEFAULT '' COMMENT '操作所在应用名或插件名等',
  `url` text COMMENT '执行操作的url',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='用户操作表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_action`
--

LOCK TABLES `cg_user_action` WRITE;
/*!40000 ALTER TABLE `cg_user_action` DISABLE KEYS */;
INSERT INTO `cg_user_action` VALUES (1,1,1,1,2,1,'用户登录','login','user','');
/*!40000 ALTER TABLE `cg_user_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_action_log`
--

DROP TABLE IF EXISTS `cg_user_action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_action_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `count` int unsigned NOT NULL DEFAULT '0' COMMENT '访问次数',
  `last_visit_time` int unsigned NOT NULL DEFAULT '0' COMMENT '最后访问时间',
  `object` varchar(100) NOT NULL DEFAULT '' COMMENT '访问对象的id,格式:不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称;格式:应用名+控制器+操作名,也可自己定义格式只要不发生冲突且惟一;',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户ip',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_object_action` (`user_id`,`object`,`action`) USING BTREE,
  KEY `user_object_action_ip` (`user_id`,`object`,`action`,`ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='访问记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_action_log`
--

LOCK TABLES `cg_user_action_log` WRITE;
/*!40000 ALTER TABLE `cg_user_action_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_user_action_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_balance_log`
--

DROP TABLE IF EXISTS `cg_user_balance_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_balance_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `change` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改余额',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更改后余额',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='用户余额变更日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_balance_log`
--

LOCK TABLES `cg_user_balance_log` WRITE;
/*!40000 ALTER TABLE `cg_user_balance_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_user_balance_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_fans`
--

DROP TABLE IF EXISTS `cg_user_fans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_fans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL DEFAULT '0' COMMENT '用户id',
  `fans_id` int NOT NULL DEFAULT '0' COMMENT '粉丝id',
  `create_time` int NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='粉丝表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_fans`
--

LOCK TABLES `cg_user_fans` WRITE;
/*!40000 ALTER TABLE `cg_user_fans` DISABLE KEYS */;
INSERT INTO `cg_user_fans` VALUES (5,89,91,1565943931),(7,77,91,1565945284),(8,90,93,1566289109),(9,80,93,1566289299),(11,90,74,1566294219);
/*!40000 ALTER TABLE `cg_user_fans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_favorite`
--

DROP TABLE IF EXISTS `cg_user_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_favorite` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户 id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏内容的标题',
  `thumbnail` varchar(100) NOT NULL DEFAULT '' COMMENT '缩略图',
  `url` varchar(255) DEFAULT NULL COMMENT '收藏内容的原文地址，JSON格式',
  `description` text COMMENT '收藏内容的描述',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '收藏实体以前所在表,不带前缀',
  `object_id` int unsigned DEFAULT '0' COMMENT '收藏内容原来的主键id',
  `create_time` int unsigned DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='用户收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_favorite`
--

LOCK TABLES `cg_user_favorite` WRITE;
/*!40000 ALTER TABLE `cg_user_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_user_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_follow`
--

DROP TABLE IF EXISTS `cg_user_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_follow` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL DEFAULT '0' COMMENT '用户id',
  `follow_id` int NOT NULL DEFAULT '0' COMMENT '关注的用户id',
  `create_time` int NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='我的关注';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_follow`
--

LOCK TABLES `cg_user_follow` WRITE;
/*!40000 ALTER TABLE `cg_user_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_user_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_login_attempt`
--

DROP TABLE IF EXISTS `cg_user_login_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_login_attempt` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `login_attempts` int unsigned NOT NULL DEFAULT '0' COMMENT '尝试次数',
  `attempt_time` int unsigned NOT NULL DEFAULT '0' COMMENT '尝试登录时间',
  `locked_time` int unsigned NOT NULL DEFAULT '0' COMMENT '锁定时间',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '用户 ip',
  `account` varchar(100) NOT NULL DEFAULT '' COMMENT '用户账号,手机号,邮箱或用户名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='用户登录尝试表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_login_attempt`
--

LOCK TABLES `cg_user_login_attempt` WRITE;
/*!40000 ALTER TABLE `cg_user_login_attempt` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_user_login_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_login_record`
--

DROP TABLE IF EXISTS `cg_user_login_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_login_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL DEFAULT '0' COMMENT '用户编号',
  `user_agent` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `client_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客户端类型',
  `params` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `if_success` tinyint NOT NULL DEFAULT '0' COMMENT '是否成功',
  `note` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` int NOT NULL DEFAULT '0' COMMENT '登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户登录记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_login_record`
--

LOCK TABLES `cg_user_login_record` WRITE;
/*!40000 ALTER TABLE `cg_user_login_record` DISABLE KEYS */;
INSERT INTO `cg_user_login_record` VALUES (1,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','',1,'登录成功',1598893124),(2,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','',1,'登录成功',1598893218),(3,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','',1,'登录成功',1598893285),(4,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','',1,'登录成功',1598893929),(5,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','',1,'登录成功',1598894073),(6,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','',1,'登录成功',1598894108),(7,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','[]',1,'登录成功',1598894131),(8,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"123456\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598894157),(9,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598894335),(10,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598895912),(11,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598896002),(12,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598896058),(13,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598896167),(14,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598896267),(15,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598896353),(16,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598896784),(17,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598897026),(18,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598897128),(19,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598922717),(20,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1598929432),(21,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599015280),(22,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599015339),(23,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599015661),(24,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599016324),(25,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599016646),(26,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599016660),(27,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599017471),(28,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599017513),(29,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599018190),(30,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599018212),(31,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599018974),(32,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599019903),(33,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599043004),(34,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599043039),(35,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599043747),(36,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599051877),(37,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599052088),(38,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599055268),(39,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599057371),(40,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599057401),(41,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599060934),(42,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599076297),(43,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599113890),(44,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/84.0.4147.135 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599211298),(45,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599327838),(46,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599393541),(47,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599394246),(48,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599394556),(49,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599395424),(50,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599551517),(51,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599711341),(52,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599711515),(53,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599713348),(54,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599735123),(55,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599735128),(56,174,'mozilla/5.0 (macintosh; intel mac os x 10.15; rv:79.0) gecko/20100101 firefox/79.0','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599754197),(57,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.83 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599756246),(58,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599792131),(59,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599792138),(60,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599792157),(61,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599793863),(62,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814405),(63,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814412),(64,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814422),(65,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814441),(66,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814452),(67,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814459),(68,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814467),(69,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814499),(70,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814543),(71,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814779),(72,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814878),(73,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599814932),(74,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599815299),(75,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599815372),(76,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599815389),(77,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599816103),(78,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599817255),(79,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599817966),(80,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599817977),(81,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599817986),(82,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599818001),(83,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599818433),(84,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599818858),(85,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599823619),(86,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599823663),(87,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599823741),(88,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599823750),(89,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599823777),(90,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599823794),(91,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599823815),(92,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599823890),(93,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599823949),(94,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599823978),(95,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824020),(96,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824028),(97,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824086),(98,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824095),(99,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824123),(100,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824144),(101,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824153),(102,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824177),(103,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824255),(104,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824328),(105,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824346),(106,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824365),(107,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824373),(108,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824395),(109,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824406),(110,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824468),(111,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824484),(112,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824505),(113,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824516),(114,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599824581),(115,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599825453),(116,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599835058),(117,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599835492),(118,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599838332),(119,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599838340),(120,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599838347),(121,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599838356),(122,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1599838386),(123,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600000409),(124,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600018318),(125,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600018365),(126,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600019108),(127,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600019202),(128,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600019211),(129,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600019376),(130,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600019395),(131,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600161999),(132,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600162015),(133,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600162349),(134,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600162402),(135,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600163454),(136,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600163534),(137,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600163556),(138,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600163623),(139,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600163666),(140,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600164297),(141,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600164332),(142,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600164462),(143,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600164647),(144,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600187930),(145,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600188080),(146,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600188116),(147,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600188148),(148,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600188228),(149,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600188235),(150,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600188243),(151,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600188253),(152,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600188533),(153,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600188587),(154,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600237822),(155,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600241195),(156,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600312000),(157,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600398895),(158,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600631500),(159,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600631689),(160,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600771198),(161,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.102 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600771226),(162,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600933241),(163,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600940662),(164,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600940852),(165,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600940906),(166,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600964438),(167,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600966325),(168,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600969717),(169,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1600997957),(170,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601008419),(171,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601015308),(172,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601018831),(173,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601018882),(174,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601048265),(175,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601048425),(176,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601051704),(177,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601100798),(178,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601130609),(179,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601182854),(180,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601192655),(181,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601196792),(182,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601260635),(183,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601265991),(184,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601287939),(185,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601291085),(186,174,'mozilla/5.0 (macintosh; intel mac os x 10_15_5) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','mac','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601345586),(187,174,'mozilla/5.0 (windows nt 10.0; win64; x64) applewebkit/537.36 (khtml, like gecko) chrome/85.0.4183.121 safari/537.36','windows','{\"module\":\"admin\",\"password\":\"OGQ5NjllZWY2ZWNhZDNjMjlhM2E2MjkyODBlNjg2Y2YwYzNmNWQ1YTg2YWZmM2NhMTIwMjBjOTIzYWRjNmM5Mg==\",\"username\":\"admin\",\"version\":\"v1\"}',1,'登录成功',1601349404);
/*!40000 ALTER TABLE `cg_user_login_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_mg_auth_group`
--

DROP TABLE IF EXISTS `cg_user_mg_auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_mg_auth_group` (
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `module` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'admin' COMMENT '系统模块(区分后台)',
  `pid` int NOT NULL DEFAULT '0',
  `path` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0,' COMMENT '上下级路径Path',
  `title` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分组名称',
  `rules` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[]' COMMENT '关联规则编号集合（以英文逗号分隔）',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态（0-禁用；1-启用；-1：删除）',
  `summary` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户权限分组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_mg_auth_group`
--

LOCK TABLES `cg_user_mg_auth_group` WRITE;
/*!40000 ALTER TABLE `cg_user_mg_auth_group` DISABLE KEYS */;
INSERT INTO `cg_user_mg_auth_group` VALUES (23,'admin',0,'0,','测试角色一','[]',0,1,''),(24,'admin',23,'0,23,','测试角色二','[]',0,1,''),(54,'admin',55,'0,55,','测试五-一','[266,263]',50,1,'说明1'),(55,'admin',0,'0,','测试五','[249,250,251]',0,1,''),(56,'admin',0,'0,','角色六','[250,262,266]',0,1,''),(57,'admin',56,'0,56,','测试六-1','[250,281,251,287,289,291,292,293,286,283,285]',0,1,'测试六-1'),(58,'admin',24,'0,23,24,','测试二-二','[266]',0,-1,''),(59,'admin',54,'0,55,54,','五一一','[281,249]',101,0,'介绍');
/*!40000 ALTER TABLE `cg_user_mg_auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_mg_auth_rule`
--

DROP TABLE IF EXISTS `cg_user_mg_auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_mg_auth_rule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `module` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'admin' COMMENT '系统模块(区分后台)',
  `type` tinyint NOT NULL DEFAULT '0' COMMENT '节点类型（0-系统菜单；1-权限节点非菜单；2-按钮）',
  `pid` int NOT NULL DEFAULT '0' COMMENT '父级菜单编号',
  `path` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0,' COMMENT '上下级路径Path',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'cigoadmin-icon-menu' COMMENT 'ICON图标',
  `component_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '前端组件唯一标识名称',
  `can_not_close_opentab` tinyint NOT NULL DEFAULT '1' COMMENT '是否可以关闭已打开tab',
  `can_not_record_opentab` tinyint NOT NULL DEFAULT '0' COMMENT '不记录已打开tab列表',
  `can_not_cache` tinyint NOT NULL DEFAULT '1' COMMENT '是否参与页面缓存',
  `url` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单path',
  `target_type` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'content-page' COMMENT '跳转类型（content-page：右侧页面；layer-win：弹窗窗口；_blank：新打开页面）',
  `summary` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则说明',
  `group` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单分组',
  `group_sort` int NOT NULL DEFAULT '100' COMMENT '菜单分组Group排序',
  `sort` int NOT NULL DEFAULT '100' COMMENT '排序',
  `opt_rate` int NOT NULL DEFAULT '0' COMMENT '操作频率',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1正常，0禁用，-1：删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_component_name` (`component_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=327 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商城后台用户权限规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_mg_auth_rule`
--

LOCK TABLES `cg_user_mg_auth_rule` WRITE;
/*!40000 ALTER TABLE `cg_user_mg_auth_rule` DISABLE KEYS */;
INSERT INTO `cg_user_mg_auth_rule` VALUES (248,'admin',0,0,'0,','级联菜单','cigoadmin-icon-menu','TreeMenu',0,0,0,'/','content-page','','功能演示',100,1,0,1),(249,'admin',0,0,'0,','数据中心','cigoadmin-icon-dashboard','CigoDashboard',1,0,0,'/frame','content-page','','',200,200,0,1),(250,'admin',0,0,'0,','课程直播','cigoadmin-icon-tubiaozhizuomoban-','CigoEduLive',0,0,0,'/pages/live','content-page','','内容管理',150,200,0,1),(251,'admin',0,0,'0,','新闻列表','cigoadmin-icon-xinwen','News',0,0,0,'/pages/news','content-page','','内容管理',150,100,0,1),(253,'admin',0,0,'0,','权限管理','cigoadmin-icon-quanxianguanli','CigoAuth',0,0,0,'/','content-page','','系统管理',110,100,0,1),(254,'admin',0,248,'0,248,','二级菜单一','cigoadmin-icon-menu',NULL,0,0,0,'/pages/index','content-page','','',1,90,0,1),(255,'admin',0,248,'0,248,','二级菜单二','cigoadmin-icon-menu',NULL,0,0,0,'','content-page','','',10,100,0,1),(256,'admin',0,255,'0,248,255,','三级菜单一','cigoadmin-icon-menu',NULL,0,0,0,'/pages/index','content-page','','',0,100,0,1),(257,'admin',0,255,'0,248,255,','三级菜单二','cigoadmin-icon-menu',NULL,0,0,0,'','content-page','','',0,100,0,1),(258,'admin',0,257,'0,248,255,257,','四级菜单一','cigoadmin-icon-menu',NULL,0,0,0,'','content-page','','',0,100,0,1),(259,'admin',0,257,'0,248,255,257,','四级菜单二','cigoadmin-icon-menu',NULL,0,0,0,'/','content-page','','',0,100,0,1),(260,'admin',0,258,'0,248,255,257,258,','五级菜单一','cigoadmin-icon-menu',NULL,0,0,0,'/pages/index','content-page','','',0,100,0,1),(261,'admin',0,258,'0,248,255,257,258,','五级菜单二','cigoadmin-icon-menu',NULL,0,0,0,'/','content-page','','',0,100,0,1),(262,'admin',0,253,'0,253,','菜单、功能节点','cigoadmin-icon-quanxian','CigoAuthRule',0,0,0,'/frame/authRule','content-page','','',0,100,0,1),(263,'admin',0,253,'0,253,','角色管理','cigoadmin-icon-jiaoseguanli','CigoAuthRuleGroup',0,0,0,'/frame/authGroup','content-page','','',0,100,0,1),(266,'admin',0,0,'0,','管理员','cigoadmin-icon-guanliyuan','CigoManager',0,0,0,'/frame/manager','content-page','','',200,200,0,1),(275,'admin',0,255,'0,248,255,','三级菜单三','cigoadmin-icon-menu',NULL,0,0,0,'/','content-page','','分组',0,100,0,1),(276,'admin',0,255,'0,248,255,','三级菜单四','cigoadmin-icon-menu',NULL,0,0,0,'/','content-page','','分组',0,100,0,1),(277,'admin',0,278,'0,278,','普通上传','cigoadmin-icon-shangchuan','DemoUpload',0,0,0,'/pages/demo/upload','content-page','','表单操作',90,90,0,1),(278,'admin',0,0,'0,','AntDesign示例','cigoadmin-icon-ant-design','AntDesignDemos',0,0,0,'/','content-page','','功能演示',100,90,0,1),(279,'admin',0,278,'0,278,','断点续传','cigoadmin-icon-shangchuan','DemoContinue',0,0,0,'/pages/demo/continue','content-page','','表单操作',90,90,0,1),(280,'admin',0,0,'0,','配置项管理','cigoadmin-icon-xitongpeizhi','CigoSettingItems',0,0,0,'/frame/settingItems','content-page','','系统管理',110,10,0,1),(281,'admin',0,0,'0,','用户管理','cigoadmin-icon-yonghu','CigoUser',0,0,0,'/frame/user','content-page','','',200,200,0,1),(282,'admin',0,0,'0,','微信管理','cigoadmin-icon-weixin','CigoWechat',0,0,0,'/','content-page','','系统管理',110,100,0,1),(283,'admin',0,282,'0,282,','微信配置','cigoadmin-icon-peizhi',NULL,0,0,0,'','content-page','','',110,100,0,1),(284,'admin',0,282,'0,282,','公众号管理','cigoadmin-icon-weixingongzhonghao',NULL,0,0,0,'','content-page','','',110,100,0,1),(285,'admin',0,283,'0,282,283,','授权配置','cigoadmin-icon-weituoshouquan','CigoWeiXinAuth',0,0,0,'/frame/wxAuth','content-page','','',110,100,0,1),(286,'admin',0,283,'0,282,283,','支付配置','cigoadmin-icon-zhifu','CigoWeiXinPay',0,0,0,'/frame/wxPay','content-page','','',110,100,0,1),(287,'admin',0,284,'0,282,284,','社群粉丝管理','cigoadmin-icon-fensishu','CigoWeiXinFans',0,0,0,'/frame/wxFans','content-page','','',110,140,0,1),(289,'admin',0,284,'0,282,284,','其它配置','cigoadmin-icon-qita','CigoWeiXinOther',0,0,0,'/frame/wxOther','content-page','','',110,100,0,1),(290,'admin',0,284,'0,282,284,','图文资源管理','cigoadmin-icon-article','CigoWeiXinResource',0,0,0,'/frame/wxResource','content-page','','',110,130,0,1),(291,'admin',0,284,'0,282,284,','关注回复','cigoadmin-icon-yiguanzhuren','CigoWeiXinFollow',0,0,0,'/frame/wxFollow','content-page','','',110,120,0,1),(292,'admin',0,284,'0,282,284,','回复规则','cigoadmin-icon-pinglun3','CigoWeiXinReplyRule',0,0,0,'/frame/wxReplyRule','content-page','','',110,110,0,1),(293,'admin',0,284,'0,282,284,','菜单配置','cigoadmin-icon-caidan','CigoWeiXinMenu',0,0,0,'/frame/wxMenu','content-page','','',110,150,0,1),(311,'admin',0,0,'0,','动画示例','cigoadmin-icon-donghua','AnimationDemos',0,0,0,'/','content-page','','功能演示',100,100,0,1),(312,'admin',0,311,'0,311,','温度计','cigoadmin-icon-wdj','ThermometerDemos',0,0,0,'/','content-page','','',100,100,0,1),(313,'admin',0,312,'0,311,312,','横向高低温','','CigoThermometerOne',0,0,0,'/frame/animation/thermometer/one','content-page','','',100,100,0,1),(314,'admin',0,0,'0,','Echarts图表','cigoadmin-icon-tubiao10','EchartsDemos',0,0,0,'/','content-page','','功能演示',100,100,0,1),(315,'admin',0,314,'0,314,','折线图','cigoadmin-icon-fsux_zhexiantu','EcahrtsLine',0,0,0,'/','content-page','','',100,100,0,1),(316,'admin',0,315,'0,314,315,','基础折线','cigoadmin-icon-fsux_zhexiantu','CigoEchartsBasicLine',0,0,0,'/frame/echarts/line/basicLine','content-page','','',100,100,0,1),(317,'admin',0,314,'0,314,','柱状图','cigoadmin-icon-tubiao8','EchartsBar',0,0,0,'/','content-page','','',100,100,0,1),(318,'admin',0,314,'0,314,','饼形图','cigoadmin-icon-22','EchartsPie',0,0,0,'/','content-page','','',100,100,0,1),(319,'admin',0,314,'0,314,','散点图','cigoadmin-icon-fsux_tubiao_huiguiquxiantu','EchartsScatter',0,0,0,'/','content-page','','',100,100,0,1),(320,'admin',0,314,'0,314,','地理坐标图','cigoadmin-icon-fsux_tubiao_tongjiditu','EchartsGEOMap',0,0,0,'/','content-page','','',100,100,0,1),(321,'admin',0,314,'0,314,','K线图','cigoadmin-icon-Kxiantu','EchartsCandlestick',0,0,0,'/','content-page','','',100,100,0,1),(322,'admin',0,314,'0,314,','雷达图','cigoadmin-icon-fsux_tubiao_leidatu','EchartsRadar',0,0,0,'/','content-page','','',100,100,0,1),(323,'admin',0,314,'0,314,','盒须图','cigoadmin-icon-fsux_tubiao_kxiantu','EchartsBoxplot',0,0,0,'/','content-page','','',100,100,0,1),(324,'admin',0,0,'0,','上传文件','cigoadmin-icon-xianxingtubiao_huabanfuben','CigoUploadFiles',0,0,0,'/frame/files','content-page','','系统管理',110,100,0,1),(325,'admin',0,0,'0,','视频点播','cigoadmin-icon-vodshipindianbo','CigoEduVod',0,0,0,'/pages/vod','content-page','','内容管理',150,200,0,1),(326,'admin',0,0,'0,','系统配置','cigoadmin-icon-peizhiguanli','CigoSettings',0,0,0,'/frame/settings','content-page','','系统管理',110,100,0,1);
/*!40000 ALTER TABLE `cg_user_mg_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_score_log`
--

DROP TABLE IF EXISTS `cg_user_score_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_score_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户 id',
  `create_time` int NOT NULL DEFAULT '0' COMMENT '创建时间',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '用户操作名称',
  `score` int NOT NULL DEFAULT '0' COMMENT '更改积分，可以为负',
  `coin` int NOT NULL DEFAULT '0' COMMENT '更改金币，可以为负',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='用户操作积分等奖励日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_score_log`
--

LOCK TABLES `cg_user_score_log` WRITE;
/*!40000 ALTER TABLE `cg_user_score_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_user_score_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_thirdparty`
--

DROP TABLE IF EXISTS `cg_user_thirdparty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_thirdparty` (
  `id` int NOT NULL AUTO_INCREMENT,
  `open_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `union_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `party` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '第三方类型（weixin、alipay）',
  `bind_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '绑定码',
  `user_agent` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `client_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客户端类型',
  `create_time` int NOT NULL DEFAULT '0' COMMENT '登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_thirdparty`
--

LOCK TABLES `cg_user_thirdparty` WRITE;
/*!40000 ALTER TABLE `cg_user_thirdparty` DISABLE KEYS */;
/*!40000 ALTER TABLE `cg_user_thirdparty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_user_token`
--

DROP TABLE IF EXISTS `cg_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_user_token` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL DEFAULT '0' COMMENT '用户id',
  `expire_time` int unsigned NOT NULL DEFAULT '0' COMMENT ' 过期时间',
  `create_time` int unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `token` varchar(64) NOT NULL DEFAULT '' COMMENT 'token',
  `device_type` varchar(10) NOT NULL DEFAULT '' COMMENT '设备类型;mobile,android,iphone,ipad,web,pc,mac,wxapp',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='用户客户端登录 token 表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_user_token`
--

LOCK TABLES `cg_user_token` WRITE;
/*!40000 ALTER TABLE `cg_user_token` DISABLE KEYS */;
INSERT INTO `cg_user_token` VALUES (91,1,1612580677,1597028677,'dda3560bad1aa77dfd6764423faebd611b1ae84ae0c4bb6c7183551c6e8dd944','web'),(92,72,1581231456,1565679456,'a0d8ccc6da9c1cd74e0dd06d216f105506752f3f992a8827631fd089c6fff2cc','web'),(93,77,1581399913,1565847913,'492b82d976c11497b5a812d664c4b01fbde694c345df31c5fd26e305db6d50bd','web'),(94,89,1581401591,1565849591,'02c93d6c0d4b434163a23a6c52cec40d8219012edc04293d2e3c1b674576ab28','web'),(95,88,1581401848,1565849848,'f720f09c1889a98d635e8700c99228e40d3e1c87d8659fd7163e5a65fe3b9c92','web'),(96,86,1581475412,1565923412,'d33ae46b0271c5a389818d0557ec216c9163c2a8cb2b1379f1704a01e907fe2e','web'),(97,85,1581477403,1565925403,'b3e8640a03c681ee7745f8003865f7681e90f8dd330916a83c912a8d601bc235','web'),(98,90,1581494700,1565942700,'1d5377a9ac0343ba76582c2ae02dc624f320217a532c5ca31c428359d9c3e57c','web'),(99,91,1581753663,1566201663,'7e394cef65386e9cc0aa0d951fd64e9a21bcb7f9bc27321fe1b5f05b5db713d1','android'),(100,87,1581495838,1565943838,'6459aab189669fb9b3d4071e511517b9bd43ecf0bd8b58c2372fb435f18270ce','web'),(101,81,1581498082,1565946082,'95d5e1624011ade7372a4887d36a6535639ccc4b10b4118b0b799d8a335f05a0','web'),(102,84,1581729583,1566177583,'59c9ebc4ab7ac2d95f1f67da94da492a0b0b287f98db05d26a9be55ec6206bae','web'),(103,83,1581730815,1566178815,'5da343cf34850e747c9912acdae8ee26ffcaf42ea340910aa287f234294576f1','web'),(104,80,1581735819,1566183819,'f49195420ba823abb0d38c12fd190ec1cbc9128d0ba5694748df4e64ba499703','web'),(105,92,1613385541,1597833541,'c4f22d16e18e09161cd8d3d7766113f3a8e278b50645278ccdc232da5dff3890','android'),(106,82,1581820331,1566268331,'9b8f55ad2ba1193fdefa9b511c69c4b114750fc31a600c1015b27212c23b0b74','web'),(107,93,1590995173,1575443173,'4a3b45bef35bcb685a0dd9209f3dd8b692b3f7dd80273960579bd1ed74419c94','android'),(108,94,1581841365,1566289365,'9106fea68953182b45fa118dcdd84bfb27c0e4a3cc6c559e3b6b7acca85722b7','android'),(109,95,1581841935,1566289935,'94f75a60efc13b02431d32a274dc6e82aa6e012c7cb210560bc5ca433e75e4d2','web'),(110,96,1582005313,1566453313,'7c16d51fe56a47e8f408d73261d307df58229472c03d5faa4ef34c620082b3c9','android'),(111,97,1582532607,1566980607,'63b21faa21095b30bed4059b7fe7e2534ee8cb4f5346df2a18db4f934cb4ae56','android'),(112,79,1581845456,1566293456,'23ca5acf637247e0f27eed3f226cb641de85b4fca3e3a7d45fa390965a0d0df1','web'),(113,78,1581845505,1566293505,'f15628353dc9bcc49d3728e283847249317e47d6613bbb90cfac8759795970a5','web'),(114,74,1581846207,1566294207,'20a586f078108dca5235e2df320e57cb9f0871b1273903255c57cc332d1e5bfd','android'),(115,98,1610874738,1595322738,'8ce80a80623d3b6dcbc6c2121fe3c960fd301bf4ff40437d3d9f1f85cd576b8b','web'),(116,99,1591761427,1576209427,'a646cb335d5710a6fefd18517ba1e219fcebf55d1f838090102e613013040670','android'),(117,100,1582010362,1566458362,'4180917747c899f6a98d91e01b1b6b62e978ad03db11bf31eeb1a6b7f8026e6c','iphone'),(118,93,1582609383,1567057383,'576b685de1530703b963fa680e1dbc7d7d6b9da1d43bd126cbcf66b0662651aa','iphone'),(119,101,1590376785,1574824785,'43afef796aa78477a26b6f991790e0b321f1c7b08bba0907dd973177d1fbfa46','web'),(120,4388,1592018394,1576466394,'4ae591f40daf16eaca611cc4f07a12e32538e57f66033bb2872bdd8dee6c6145','web'),(121,4389,1610874751,1595322751,'0351225d12c865e92ee663984cd090b1d5fc0a6434f674a075f8e14c10c7bb4d','web'),(122,4390,1610875005,1595323005,'0ac23dc6870c03a3ca479ffa7715807bb91d540accb0bdb3cbb1eb85c679f9c3','web'),(123,4391,1612769938,1597217938,'df30c08f88888014b2ca4c4cc85b0a4e34eae8c57eb5b5539c2317a696dda320','android'),(124,4392,1612772965,1597220965,'0b51e69de38bb251ea7e3d608fae3c3968c15d89b164a78bbdb9c19ed1b08a08','android'),(125,4393,1613392089,1597840089,'db84ad6be337a9d52ffcf1868debed75e388f81abcc6ef90cec5755f28216e91','android'),(126,4394,1615734338,1600182338,'b47c980bd5e114f07dd6c4a62d1a22eb386d5cbecbc1caddb8754c63713b22a0','android');
/*!40000 ALTER TABLE `cg_user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cg_verification_code`
--

DROP TABLE IF EXISTS `cg_verification_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cg_verification_code` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '表id',
  `count` int unsigned NOT NULL DEFAULT '0' COMMENT '当天已经发送成功的次数',
  `send_time` int unsigned NOT NULL DEFAULT '0' COMMENT '最后发送成功时间',
  `expire_time` int unsigned NOT NULL DEFAULT '0' COMMENT '验证码过期时间',
  `code` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '最后发送成功的验证码',
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号或者邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT COMMENT='手机邮箱数字验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cg_verification_code`
--

LOCK TABLES `cg_verification_code` WRITE;
/*!40000 ALTER TABLE `cg_verification_code` DISABLE KEYS */;
INSERT INTO `cg_verification_code` VALUES (1,3,1566202304,1566204104,'403938','18428316593'),(2,2,1566201826,1566203626,'503936','13200000000'),(3,2,1566202287,1566204087,'317118','18428346593'),(4,1,1566202171,1566203971,'613073','18428316596'),(5,1,1575443163,1575444963,'482779','18782128689'),(6,1,1566289290,1566291090,'839849','18182320908'),(7,1,1566290069,1566291869,'677891','18382025187'),(8,1,1566290086,1566291886,'360594','18982162773'),(9,1,1566370953,1566372753,'862195','13618081453'),(10,2,1566458330,1566460130,'318316','17313123119'),(11,1,1576209416,1576211216,'868150','13623457697'),(12,1,1594112793,1594114593,'642084','15280996900'),(13,1,1597217934,1597219734,'528925','18948744087'),(14,1,1597220957,1597222757,'835161','13194988156'),(15,1,1597840085,1597841885,'199876','13072580445'),(16,1,1599393124,1599394924,'573072','13670546388'),(17,1,1600182320,1600184120,'794389','13928201960');
/*!40000 ALTER TABLE `cg_verification_code` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-29 11:17:53
