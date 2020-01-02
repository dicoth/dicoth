/*
 Navicat Premium Data Transfer

 Source Server         : 62
 Source Server Type    : MySQL
 Source Server Version : 50643
 Source Host           : 10.1.223.62:3306
 Source Schema         : test2

 Target Server Type    : MySQL
 Target Server Version : 50643
 File Encoding         : 65001

 Date: 31/12/2019 18:02:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dicoth_attachment
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_attachment`;
CREATE TABLE `dicoth_attachment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('post') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'post',
  `item_id` int(11) NOT NULL,
  `is_used` tinyint(2) DEFAULT 0,
  `uid` int(11) NOT NULL COMMENT 'user id',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'original name',
  `filename` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'real file address',
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL COMMENT 'file size',
  `downloads` int(11) DEFAULT 0,
  `created` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT 0,
  `audited` int(11) DEFAULT NULL COMMENT '0 pending',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 close 1 open',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Upload File' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dicoth_forum
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_forum`;
CREATE TABLE `dicoth_forum`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `threads` int(11) NOT NULL DEFAULT 0,
  `posts` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `last_thread_id` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT 0,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `type_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Forum' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dicoth_forum
-- ----------------------------
INSERT INTO `dicoth_forum` VALUES (101, 'Dlang', NULL, '', 0, 0, 0, 1, 0, 0, 1234567890, 1234567890, NULL);
INSERT INTO `dicoth_forum` VALUES (102, 'D Framework', NULL, '', 0, 0, 0, 1, 0, 0, 1234567890, 1234567890, NULL);
INSERT INTO `dicoth_forum` VALUES (103, 'Dlang sharing', 'D sharing', '/images/dlang-icon.png', 101, 11, 11, 1, 10052, 0, 1234567890, 1234567890, '0');
INSERT INTO `dicoth_forum` VALUES (104, 'Dlang for beginners', 'Dlang for beginners', '/images/help-icon.png', 101, 26, 26, 1, 10051, 0, 1234567890, 1234567890, '0');
INSERT INTO `dicoth_forum` VALUES (105, 'Hunt Framework', 'Web Hunt Framework sharing', '/images/hunt-icon.png', 102, 7, 7, 1, 10037, 0, 1234567890, 1234567890, '0');

-- ----------------------------
-- Table structure for dicoth_forum_post
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_forum_post`;
CREATE TABLE `dicoth_forum_post`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL COMMENT 'Thread ID',
  `uid` int(11) NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_html` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `attachments` int(11) DEFAULT 0,
  `comments` int(11) DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 close 1 open',
  `deleted` int(11) DEFAULT 0,
  `updated` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `audited` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FULLTEXT INDEX `fulltext_content`(`content`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Threads' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dicoth_forum_thread
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_forum_thread`;
CREATE TABLE `dicoth_forum_thread`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forum_id` int(11) DEFAULT NULL COMMENT 'ForumID',
  `title` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uid` int(11) NOT NULL,
  `keywords` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Keywords a,b,c',
  `posts` int(11) DEFAULT 1,
  `views` int(11) DEFAULT 1,
  `status` tinyint(2) NOT NULL COMMENT '0 close 1 open',
  `last_uid` int(11) DEFAULT NULL,
  `last_time` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `updated` int(11) DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FULLTEXT INDEX `fulltext_title`(`title`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dicoth_system_lang_package
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_system_lang_package`;
CREATE TABLE `dicoth_system_lang_package`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `local` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dicoth_system_language
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_system_language`;
CREATE TABLE `dicoth_system_language`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'Chinese English',
  `sign` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'zh-hk zh-cn en',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT 'status：1  2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dicoth_system_language
-- ----------------------------
INSERT INTO `dicoth_system_language` VALUES (1, 'English', 'en', 1);
INSERT INTO `dicoth_system_language` VALUES (2, '简体中文', 'zh-cn', 1);
INSERT INTO `dicoth_system_language` VALUES (3, '繁體中文', 'zh-hk', 1);

-- ----------------------------
-- Table structure for dicoth_system_menu
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_system_menu`;
CREATE TABLE `dicoth_system_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `icon_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_action` tinyint(1) DEFAULT 0,
  `mca` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `link_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort` int(11) DEFAULT 0,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dicoth_system_menu
-- ----------------------------
INSERT INTO `dicoth_system_menu` VALUES (3, 0, 'System', '', 'ti-panel', 0, '', '#', 2, 0, 0, 1);
INSERT INTO `dicoth_system_menu` VALUES (6, 3, '菜单管理', '', 'ti-menu', 1, 'system.menu.list', '/system/menus', 0, 1530156969, 1530156969, 1);
INSERT INTO `dicoth_system_menu` VALUES (7, 3, '权限管理', '', 'ti-settings', 1, 'system.permission.list', '/system/permissions', 0, 1530156969, 1530156969, 1);
INSERT INTO `dicoth_system_menu` VALUES (8, 3, '用户管理', '', 'ti-user', 1, 'system.user.list', '/system/users', 0, 1530156969, 1530156969, 1);
INSERT INTO `dicoth_system_menu` VALUES (9, 3, '角色管理', '', 'ti-bar-chart', 1, 'system.role.list', '/system/roles', 0, 1530190052, 1530190052, 1);
INSERT INTO `dicoth_system_menu` VALUES (12, 1, 'Menus', '', '', 1, 'portal.menu.list', '/portal/menu/list', 0, 1536491541, 1536650161, 1);
INSERT INTO `dicoth_system_menu` VALUES (26, 3, 'Permission Group', '', '', 1, 'system.permissiongroup.list', '/system/permission/groups', 0, 1548668312, 1548668312, 1);
INSERT INTO `dicoth_system_menu` VALUES (29, 0, '系统管理', '', 'ti-panel', 0, '', '', 0, 1545206026, 1545206026, 1);
INSERT INTO `dicoth_system_menu` VALUES (36, 3, '语言包管理', '__SYSTEM_MENU_36', '', 1, 'system.langpackage.list', '/language/package', 0, 1557369344, 1558347075, 1);
INSERT INTO `dicoth_system_menu` VALUES (37, 0, 'Forum', '__SYSTEM_MENU_37', '', 1, 'forum.forum.list', '/forum/list', 0, 1565595785, 1565595785, 1);
INSERT INTO `dicoth_system_menu` VALUES (38, 37, 'Forums', '__SYSTEM_MENU_38', '', 1, 'forum.forum.list', '/forum/list', 0, 1565595812, 1565690690, 1);
INSERT INTO `dicoth_system_menu` VALUES (39, 37, 'Threads', '__SYSTEM_MENU_39', '', 1, 'forum.postaudit.list', '/forum/postaudit/list', 0, 1565595980, 1565690746, 1);
INSERT INTO `dicoth_system_menu` VALUES (40, 0, 'Attachment', '__SYSTEM_MENU_40', '', 1, 'attachment.attachment.list', '/attachment/attachment/list', 10, 1565857864, 1565858029, 1);
INSERT INTO `dicoth_system_menu` VALUES (41, 40, 'Attachment', '__SYSTEM_MENU_41', '', 1, 'attachment.attachment.list', '/attachment/attachment/list', 0, 1565858222, 1565858222, 1);
INSERT INTO `dicoth_system_menu` VALUES (43, 0, 'User', '__SYSTEM_MENU_43', '', 1, 'user.user.list', '/user/user/list', 11, 1566462906, 1566469258, 1);
INSERT INTO `dicoth_system_menu` VALUES (44, 43, 'User', '__SYSTEM_MENU_44', '', 1, 'user.user.list', '/user/user/list', 0, 1566469555, 1566469555, 1);
INSERT INTO `dicoth_system_menu` VALUES (45, 3, '语言包管理', '__SYSTEM_MENU_45', '', 1, 'system.langpackage.list', '/language/package', 0, 1577670625, 1577670625, 1);

-- ----------------------------
-- Table structure for dicoth_system_permission
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_system_permission`;
CREATE TABLE `dicoth_system_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mca` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `group_id` int(11) NOT NULL DEFAULT 1,
  `is_action` tinyint(1) NOT NULL DEFAULT 0,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dicoth_system_permission
-- ----------------------------
INSERT INTO `dicoth_system_permission` VALUES (1, 'system.file.upload', 'File upload', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (2, 'system.log.del', 'Delete logs', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (3, 'system.log.list', 'View logs', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (4, 'system.menu.add', 'Add menu', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (5, 'system.menu.del', 'Delete menu', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (6, 'system.menu.edit', 'Edit menu', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (7, 'system.menu.list', 'View menu', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (8, 'system.permission.add', 'Add permission', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (9, 'system.permission.del', 'Delete permission', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (10, 'system.permission.edit', 'Edit permission', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (11, 'system.permission.list', 'View permission', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (12, 'system.role.add', 'Add role', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (13, 'system.role.del', 'Delete role', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (14, 'system.role.edit', 'Edit role', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (15, 'system.role.list', 'View role', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (16, 'system.user.add', 'Add user', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (17, 'system.user.del', 'Delete user', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (18, 'system.user.edit', 'Edit user', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (19, 'system.user.list', 'View user', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (20, 'system.user.profile', 'User Profile', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `dicoth_system_permission` VALUES (55, 'tag.tag.add', 'Add tag', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `dicoth_system_permission` VALUES (56, 'tag.tag.del', 'Delete tag', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `dicoth_system_permission` VALUES (57, 'tag.tag.edit', 'Edit tag', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `dicoth_system_permission` VALUES (58, 'tag.tag.list', 'View tag', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `dicoth_system_permission` VALUES (84, 'system.permissiongroup.list', 'View Permission Group', 1, 1, 1548668312, 1548668312, 1);
INSERT INTO `dicoth_system_permission` VALUES (85, 'system.permissiongroup.add', 'Add Permission Group', 2, 1, 1548668701, 1548670493, 1);
INSERT INTO `dicoth_system_permission` VALUES (86, 'system.langpackage.list', 'View language package', 2, 1, 1557221102, 1557221102, 1);
INSERT INTO `dicoth_system_permission` VALUES (87, 'system.langpackage.add', 'Add language', 2, 1, 1557369210, 1557369210, 1);
INSERT INTO `dicoth_system_permission` VALUES (88, 'system.langpackage.edit', 'Edit lagnuage', 2, 1, 1557369233, 1557369233, 1);
INSERT INTO `dicoth_system_permission` VALUES (89, 'system.langpackage.del', 'Delete language', 2, 1, 1557369252, 1557369252, 1);
INSERT INTO `dicoth_system_permission` VALUES (90, 'system.permissiongroup.edit', 'Edit permission group', 2, 1, 1565593811, 1565593811, 1);
INSERT INTO `dicoth_system_permission` VALUES (91, 'forum.forum.list', 'Manage Forum', 1, 1, 1565606073, 1565606073, 1);
INSERT INTO `dicoth_system_permission` VALUES (92, 'forum.postaudit.list', 'View Audit Posts', 1, 1, 1565610893, 1565610893, 1);
INSERT INTO `dicoth_system_permission` VALUES (93, 'forum.forum.add', 'Add Forum', 1, 1, 1565677680, 1565677680, 1);
INSERT INTO `dicoth_system_permission` VALUES (94, 'forum.forum.del', 'Delete Forum', 1, 1, 1565677869, 1565677869, 1);
INSERT INTO `dicoth_system_permission` VALUES (96, 'forum.forum.edit', 'Edit Forum', 1, 1, 1565687843, 1565687843, 1);
INSERT INTO `dicoth_system_permission` VALUES (99, 'forum.postaudit.audit', 'Edit Post', 1, 1, 1565753755, 1565753755, 1);
INSERT INTO `dicoth_system_permission` VALUES (100, 'forum.postaudit.del', 'Delete Post', 1, 1, 1565771425, 1565771425, 1);
INSERT INTO `dicoth_system_permission` VALUES (101, 'forum.forum.list1', 'Parent node', 1, 1, 1565772942, 1565772942, 1);
INSERT INTO `dicoth_system_permission` VALUES (102, 'forum.postaudit.doAudit', 'Audit Post', 1, 1, 1565853176, 1565853176, 1);
INSERT INTO `dicoth_system_permission` VALUES (103, 'attachment.attachment.list', 'attach', 1, 1, 1565858096, 1565858096, 1);
INSERT INTO `dicoth_system_permission` VALUES (105, 'attachment.attachment.doAudit', 'Audit Attachment', 1, 1, 1565935444, 1565935444, 1);
INSERT INTO `dicoth_system_permission` VALUES (106, 'attachment.attachment.del', 'Delete Attachment', 1, 1, 1566207324, 1566207324, 1);
INSERT INTO `dicoth_system_permission` VALUES (107, 'attachment.attachment.audit', 'View Audit Attachment', 1, 1, 1566209507, 1566209507, 1);
INSERT INTO `dicoth_system_permission` VALUES (108, 'user.user.list', 'Users', 1, 1, 1566463208, 1566463208, 1);
INSERT INTO `dicoth_system_permission` VALUES (109, 'user.user.detailed', 'detailed', 1, 1, 1566470230, 1566470230, 1);
INSERT INTO `dicoth_system_permission` VALUES (110, 'user.user.list', 'fourm user list', 1, 1, 1574079552, 1574079598, 1);
INSERT INTO `dicoth_system_permission` VALUES (111, 'user.user.detailed', 'forum user detail', 1, 1, 1574079586, 1574079586, 1);

-- ----------------------------
-- Table structure for dicoth_system_permission_group
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_system_permission_group`;
CREATE TABLE `dicoth_system_permission_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `sign` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `sort` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dicoth_system_role
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_system_role`;
CREATE TABLE `dicoth_system_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dicoth_system_role
-- ----------------------------
INSERT INTO `dicoth_system_role` VALUES (1, 'Administrator', 0, 0, 1);
INSERT INTO `dicoth_system_role` VALUES (2, 'Editor', 0, 0, 1);

-- ----------------------------
-- Table structure for dicoth_system_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_system_role_permission`;
CREATE TABLE `dicoth_system_role_permission`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) DEFAULT NULL,
  `permission_mca` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dicoth_system_setting
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_system_setting`;
CREATE TABLE `dicoth_system_setting`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `explain` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'system setting' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dicoth_system_user
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_system_user`;
CREATE TABLE `dicoth_system_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `salt` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `supered` tinyint(1) DEFAULT NULL,
  `language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_email`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dicoth_system_user
-- ----------------------------
INSERT INTO `dicoth_system_user` VALUES (1, 'admin@admin.com', '62D18522B74D75B2A84776C91BA5498377441D4C4AF0CEA22CA7DE9E09475D3A', 'test', 'Admin', '', 1577785886, 1577785886, 1, 0, '');

-- ----------------------------
-- Table structure for dicoth_system_user_role
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_system_user_role`;
CREATE TABLE `dicoth_system_user_role`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id`(`user_id`) USING BTREE,
  INDEX `fk_role_id`(`role_id`) USING BTREE,
  CONSTRAINT `dicoth_system_user_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `dicoth_system_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dicoth_system_user_role
-- ----------------------------
INSERT INTO `dicoth_system_user_role` VALUES (2, 2, 1);

-- ----------------------------
-- Table structure for dicoth_user
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_user`;
CREATE TABLE `dicoth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'username',
  `mobile` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `salt` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'salt',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `introduce` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'profile',
  `status` tinyint(1) UNSIGNED DEFAULT 0 COMMENT '0 pending 1 open 2 close',
  `ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'IP',
  `uas_unid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uas_openid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated` int(11) DEFAULT NULL COMMENT 'update time',
  `created` int(11) DEFAULT NULL COMMENT 'register time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dicoth_user_oauth
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_user_oauth`;
CREATE TABLE `dicoth_user_oauth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `oauth_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `flag` tinyint(1) UNSIGNED DEFAULT 0 COMMENT '1 Git',
  `updated` int(11) DEFAULT NULL COMMENT 'update time',
  `created` int(11) DEFAULT NULL COMMENT 'register time',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_uid`(`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for dicoth_user_verifycode
-- ----------------------------
DROP TABLE IF EXISTS `dicoth_user_verifycode`;
CREATE TABLE `dicoth_user_verifycode`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `code_type` tinyint(3) DEFAULT 1 COMMENT '1.mail，2.mobile',
  `account` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'email or mobile',
  `code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'code',
  `status` tinyint(3) NOT NULL DEFAULT 1 COMMENT '1.not used，0.used',
  `created` int(10) DEFAULT 0 COMMENT 'create time',
  `updated` int(10) NOT NULL DEFAULT 0 COMMENT 'update time',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dicoth_user_verifycode_account_IDX`(`account`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dicoth_user_verifycode
-- ----------------------------
INSERT INTO `dicoth_user_verifycode` VALUES (1, 1, 'guojigang_2019@qq.com', '180423', 1, 1577785513, 1577785513);

SET FOREIGN_KEY_CHECKS = 1;
