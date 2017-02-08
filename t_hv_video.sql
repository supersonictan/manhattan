/*
Navicat MySQL Data Transfer

Source Server         : x250
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : moon

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-02-07 19:45:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_hv_video`
-- ----------------------------
DROP TABLE IF EXISTS `t_hv_video`;
CREATE TABLE `t_hv_video` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '系统自增id',
  `vname` varchar(255) NOT NULL DEFAULT '' COMMENT '视频名称',
  `thunder_url` varchar(255) DEFAULT '' COMMENT '迅雷下载链接',
  `pic_path` varchar(255) DEFAULT '' COMMENT '图片名称',
  `type` varchar(255) DEFAULT '' COMMENT '视频类型',
  `country` varchar(255) DEFAULT '' COMMENT '视频国家',
  `director` varchar(255) DEFAULT '' COMMENT '视频导演',
  `actor` varchar(255) DEFAULT '' COMMENT '视频演员',
  `intro` varchar(255) DEFAULT '' COMMENT '视频简介',
  `year` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '视频年代',
  `score` double DEFAULT '0' COMMENT '视频分数',
  `clk_num` bigint(20) DEFAULT '0' COMMENT '点击量',
  `update_time` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_hv_video
-- ----------------------------
INSERT INTO `t_hv_video` VALUES ('1', 'vname_test', 'thisisurl', 'thisis_pic_path', '动作', '中国', '张艺谋', '赵本山；波多野吉衣', 'thisisintro', '0000-00-00 00:00:00', '10', '100', '0000-00-00 00:00:00');
