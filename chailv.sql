/*
Navicat MySQL Data Transfer

Source Server         : mysql56
Source Server Version : 50623
Source Host           : localhost:3308
Source Database       : chailv

Target Server Type    : MYSQL
Target Server Version : 50623
File Encoding         : 65001

Date: 2015-04-27 15:58:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for datadictionary
-- ----------------------------
DROP TABLE IF EXISTS `datadictionary`;
CREATE TABLE `datadictionary` (
  `DataDictionaryID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '数据字典ID',
  `DataDictionaryType` char(100) NOT NULL DEFAULT '' COMMENT '数据字典类型',
  `DataDictionaryValue` char(255) NOT NULL DEFAULT '' COMMENT '数据字典值',
  `DataDictionaryDesc` char(255) DEFAULT NULL COMMENT '数据字典描述',
  PRIMARY KEY (`DataDictionaryID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of datadictionary
-- ----------------------------
INSERT INTO `datadictionary` VALUES ('1', '管内站点', '西安', '西安站');
INSERT INTO `datadictionary` VALUES ('2', '管外站点', '榆林', '榆林站');
INSERT INTO `datadictionary` VALUES ('4', '管内站点', '蒲城东', '蒲城东站');
INSERT INTO `datadictionary` VALUES ('6', '管内站点', '潼关', '潼关站');
INSERT INTO `datadictionary` VALUES ('11', '管内站点', '蒲城', '蒲城县');

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

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
INSERT INTO `navigationtree` VALUES ('14', '基础数据管理', 'open', '', 'BaseDataManage', '1', '0');

-- ----------------------------
-- Table structure for travelfacejourney
-- ----------------------------
DROP TABLE IF EXISTS `travelfacejourney`;
CREATE TABLE `travelfacejourney` (
  `TravelFaceJourneyID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '出差行程ID',
  `TFID` int(11) NOT NULL COMMENT '出差写实ID',
  `TFJStartTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '出差行程开始时间',
  `TFJEndTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '出差行程结束时间',
  `TFJTrainNum` char(50) NOT NULL DEFAULT '' COMMENT '出差行程车次',
  `TFJFrom` char(255) NOT NULL DEFAULT '' COMMENT '出差行程出发地',
  `TFJTo` char(255) NOT NULL DEFAULT '' COMMENT '出差行程目的地',
  `TFJExt1` char(255) DEFAULT NULL COMMENT '出差行程扩展1',
  `TFJExt2` char(255) DEFAULT NULL COMMENT '出差行程扩展2',
  `TFJExt3` char(255) DEFAULT NULL COMMENT '出差行程扩展3',
  PRIMARY KEY (`TravelFaceJourneyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of travelfacejourney
-- ----------------------------

-- ----------------------------
-- Table structure for travelfact
-- ----------------------------
DROP TABLE IF EXISTS `travelfact`;
CREATE TABLE `travelfact` (
  `TravelFactID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '出差写实ID',
  `TravelRequestID` int(11) NOT NULL COMMENT '出差申请ID',
  `TFStartTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '出差实际开始时间',
  `TFEndTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '出差实际结束时间',
  `TFRange` char(50) NOT NULL DEFAULT '' COMMENT '出差实际范围',
  `TFDays` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '出差实际天数',
  `TFJieSu` char(5) NOT NULL COMMENT '出差实际是否借宿',
  `TFUnitEat` char(5) NOT NULL COMMENT '出差实际是否单位吃饭',
  `TFArrangeShiSu` char(5) NOT NULL COMMENT '出差实际是否安排食宿',
  `TFZhuSuCharge` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '出差实际住宿费用',
  `TFTransportCharge` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '出差实际交通费用',
  `TFTicketCharge` decimal(12,2) NOT NULL COMMENT '出差实际订票费',
  `TFEatCharge` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '出差实际伙食补助费用',
  `TFBusinessStatus` char(255) NOT NULL DEFAULT '' COMMENT '出差事件办理情况',
  `TFDiffDesc` char(255) NOT NULL DEFAULT '' COMMENT '出差写实差异说明',
  `TFExamineID` int(11) DEFAULT NULL COMMENT '出差写实审核人ID',
  `TFExamineDesc` char(255) DEFAULT NULL COMMENT '出差写实审核意见',
  `TFExamineTime` timestamp NULL DEFAULT NULL COMMENT '出差写实审核时间',
  `TFStatus` char(25) NOT NULL DEFAULT '' COMMENT '出差写实状态',
  `TFCreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '出差写实创建时间',
  `TFExt1` char(255) DEFAULT NULL COMMENT '出差写实扩展1',
  `TFExt2` char(255) DEFAULT NULL COMMENT '出差写实扩展2',
  `TFExt3` char(255) DEFAULT NULL COMMENT '出差写实扩展3',
  PRIMARY KEY (`TravelFactID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of travelfact
-- ----------------------------

-- ----------------------------
-- Table structure for travelrequest
-- ----------------------------
DROP TABLE IF EXISTS `travelrequest`;
CREATE TABLE `travelrequest` (
  `TravelRequestID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '出差申请ID',
  `UserInfoID` int(11) NOT NULL COMMENT '申请人ID',
  `TravelRange` char(50) NOT NULL DEFAULT '' COMMENT '出差范围',
  `TravelType` char(100) NOT NULL DEFAULT '' COMMENT '出差类型',
  `TravelFrom` char(255) NOT NULL DEFAULT '' COMMENT '出差出发地',
  `TravelTo` char(255) NOT NULL DEFAULT '' COMMENT '出差目的地',
  `TravelTimeStart` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '出差申请开始时间',
  `TravelTimeEnd` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '出差申请结束时间',
  `TravelDays` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '出差天数',
  `TravelJieSu` char(5) NOT NULL DEFAULT '' COMMENT '是否借宿',
  `TravelUnitEat` char(5) NOT NULL DEFAULT '' COMMENT '是否在单位吃饭',
  `TravelArrangeShiSu` char(5) NOT NULL DEFAULT '' COMMENT '是否安排食宿',
  `TravelTransportation` char(100) NOT NULL DEFAULT '' COMMENT '出差交通工具',
  `TravelAim` char(255) NOT NULL DEFAULT '' COMMENT '出差目的',
  `TravelZhuSuCharge` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '预计住宿费用',
  `TravelEatCharge` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '预计伙食费用',
  `TravelTransportCharge` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '预计交通费用',
  `TravelExamineID` int(11) DEFAULT NULL COMMENT '出差申请审核人ID',
  `TravelExamineDesc` char(255) DEFAULT NULL COMMENT '出差申请审核意见',
  `TravelExamineTime` timestamp NULL DEFAULT NULL COMMENT '出差申请审核时间',
  `TravelStatus` char(25) NOT NULL DEFAULT '' COMMENT '出差申请状态',
  `TravelCreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '出差申请创建时间',
  `TravelExt1` char(255) DEFAULT NULL COMMENT '出差申请扩展1',
  `TravelExt2` char(255) DEFAULT NULL COMMENT '出差申请扩展2',
  `TravelExt3` char(255) DEFAULT NULL COMMENT '出差申请扩展3',
  PRIMARY KEY (`TravelRequestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of travelrequest
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('1', '管理员', '系统管理', '系统管理', '615246796A71502B704B303D', '管理员', '正常', '2015-04-20 23:35:10', '0');
INSERT INTO `userinfo` VALUES ('2', '张三', '机关', '部门1', '615246796A71502B704B303D', '科员', '正常', '2015-04-22 23:57:47', '2');
INSERT INTO `userinfo` VALUES ('3', '李四', '机关', '部门1', '615246796A71502B704B303D', '科长', '正常', '2015-04-22 23:59:36', '1');
INSERT INTO `userinfo` VALUES ('4', '王五', '车间', '车间部门1', '615246796A71502B704B303D', '车间一般干部', '正常', '2015-04-23 09:11:12', '2');
INSERT INTO `userinfo` VALUES ('5', '赵六', '车间', '车间部门2', '615246796A71502B704B303D', '车间主任', '正常', '2015-04-23 09:12:29', '1');
INSERT INTO `userinfo` VALUES ('6', '五四六', '机关', '部门2', '615246796A71502B704B303D', '纪委书记', '正常', '2015-04-23 09:49:35', '2');
INSERT INTO `userinfo` VALUES ('7', '二三四', '车间', '车间部门2', '615246796A71502B704B303D', '车间副主任', '正常', '2015-04-23 20:10:19', '2');
