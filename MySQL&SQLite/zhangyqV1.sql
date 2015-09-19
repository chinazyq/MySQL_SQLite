/*
 Navicat MySQL Data Transfer

 Source Server         : CUMeeting_Local
 Source Server Version : 50163
 Source Host           : localhost
 Source Database       : zhangyqV1

 Target Server Version : 50163
 File Encoding         : utf-8

 Date: 09/19/2015 15:14:49 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `tb_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `tb_userinfo`;
CREATE TABLE `tb_userinfo` (
  `userid` int(10) NOT NULL,
  `username` varchar(10) NOT NULL,
  `password` varchar(10) NOT NULL,
  `realname` varchar(10) NOT NULL,
  `department` varchar(10) NOT NULL,
  `column` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tb_userinfo`
-- ----------------------------
BEGIN;
INSERT INTO `tb_userinfo` VALUES ('1', '1', '1', '1', '1', '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
