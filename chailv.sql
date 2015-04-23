/*
Navicat MySQL Data Transfer

Source Server         : mysql56
Source Server Version : 50623
Source Host           : localhost:3308
Source Database       : chailv

Target Server Type    : MYSQL
Target Server Version : 50623
File Encoding         : 65001

Date: 2015-04-23 10:49:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for loginfo
-- ----------------------------
DROP TABLE IF EXISTS `loginfo`;
CREATE TABLE `loginfo` (
  `LogID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `LogType` char(50) NOT NULL DEFAULT '' COMMENT '日志类型',
  `LogDesc` varchar(300) NOT NULL DEFAULT '' COMMENT '日志描述',
  `LogUserID` int(11) NOT NULL COMMENT '用户ID',
  `LogUserName` char(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `LogDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '日志创建时间',
  PRIMARY KEY (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loginfo
-- ----------------------------
INSERT INTO `loginfo` VALUES ('1', 's', 'sss', '1', '111', '2015-04-17 16:08:52');

-- ----------------------------
-- Table structure for navigationtree
-- ----------------------------
DROP TABLE IF EXISTS `navigationtree`;
CREATE TABLE `navigationtree` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自动编号',
  `text` char(20) NOT NULL COMMENT '导航名称',
  `state` char(10) NOT NULL DEFAULT '' COMMENT '导航状态',
  `iconCls` char(20) NOT NULL DEFAULT '' COMMENT '导航图标',
  `url` char(50) NOT NULL DEFAULT '' COMMENT '导航链接',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '节点',
  `RoleID` int(11) NOT NULL DEFAULT '1' COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of navigationtree
-- ----------------------------
INSERT INTO `navigationtree` VALUES ('1', '系统管理', 'closed', '', '', '0', '0');
INSERT INTO `navigationtree` VALUES ('2', '我的菜单', 'closed', '', '', '0', '1');
INSERT INTO `navigationtree` VALUES ('3', '申请出差', 'oepn', '', 'CLRequest', '2', '1');
INSERT INTO `navigationtree` VALUES ('4', '出差写实', 'open', '', 'CLReally', '2', '1');
INSERT INTO `navigationtree` VALUES ('6', '用户管理', 'open', '', 'UserManage', '1', '0');
INSERT INTO `navigationtree` VALUES ('7', '申请报销', 'open', '', '', '2', '1');
INSERT INTO `navigationtree` VALUES ('8', '出差审核', 'open', '', '', '2', '1');
INSERT INTO `navigationtree` VALUES ('9', '报销审核', 'open', '', '', '2', '1');
INSERT INTO `navigationtree` VALUES ('10', '我的菜单', 'closed', '', '', '0', '2');
INSERT INTO `navigationtree` VALUES ('11', '申请出差', 'open', '', 'CLRequest', '10', '2');
INSERT INTO `navigationtree` VALUES ('12', '出差写实', 'open', '', 'CLReally', '10', '2');
INSERT INTO `navigationtree` VALUES ('13', '申请报销', 'open', '', '', '10', '2');

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `UserID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `UserName` char(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `UserUint` char(100) NOT NULL DEFAULT '' COMMENT '用户所在单位',
  `UserDepartment` char(100) NOT NULL DEFAULT '' COMMENT '用户所在部门',
  `UserPwd` char(50) NOT NULL DEFAULT '' COMMENT '用户密码',
  `UserRole` char(100) NOT NULL DEFAULT '' COMMENT '用户角色',
  `UserStatus` char(10) NOT NULL DEFAULT '正常' COMMENT '用户状态(正常,已删除)',
  `UserCreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '用户创建时间',
  `UserRoleID` int(11) NOT NULL DEFAULT '1' COMMENT '用户角色ID',
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('1', '管理员', '系统管理', '系统管理', '615246796A71502B704B303D', '管理员', '正常', '2015-04-20 23:35:10', '0');
INSERT INTO `userinfo` VALUES ('2', '张三', '机关', '部门1', '615246796A71502B704B303D', '科员', '正常', '2015-04-22 23:57:47', '2');
INSERT INTO `userinfo` VALUES ('3', '李四', '机关', '部门1', '615246796A71502B704B303D', '科长', '正常', '2015-04-22 23:59:36', '1');
INSERT INTO `userinfo` VALUES ('4', '王五', '车间', '车间部门1', '615246796A71502B704B303D', '车间一般干部', '正常', '2015-04-23 09:11:12', '2');
INSERT INTO `userinfo` VALUES ('5', '赵六', '车间', '车间部门2', '615246796A71502B704B303D', '车间主任', '正常', '2015-04-23 09:12:29', '1');
INSERT INTO `userinfo` VALUES ('6', '五四六', '机关', '部门2', '615246796A71502B704B303D', '纪委书记', '正常', '2015-04-23 09:49:35', '2');
