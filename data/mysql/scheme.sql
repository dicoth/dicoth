/*
 Source Server         : 10.1.11.171(MYSQL)
 Source Server Type    : MySQL
 Source Server Version : 50710
 Source Host           : 10.1.11.171:3306
 Source Schema         : dforum

 Target Server Type    : MySQL
 Target Server Version : 50710
 File Encoding         : 65001

 Date: 03/08/2020 14:44:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hc_article_article_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_article_article_backup`;
CREATE TABLE `hc_article_article_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categories_id` int(11) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `video` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created` int(11) NULL DEFAULT NULL,
  `updated` int(11) NULL DEFAULT NULL,
  `status` tinyint(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_article_category`(`categories_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hc_article_category_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_article_category_backup`;
CREATE TABLE `hc_article_category_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NULL DEFAULT NULL COMMENT '关联的商品类别',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` smallint(6) NULL DEFAULT NULL,
  `created` int(11) NULL DEFAULT NULL,
  `updated` int(11) NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hc_attachment
-- ----------------------------
DROP TABLE IF EXISTS `hc_attachment`;
CREATE TABLE `hc_attachment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('post','avatar') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'post',
  `item_id` int(11) NOT NULL COMMENT 'hc_post  id',
  `is_used` tinyint(2) NULL DEFAULT 0,
  `uid` int(11) NOT NULL COMMENT '上传人',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原名',
  `filename` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件真实访问地址',
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `mime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小(字节)',
  `downloads` int(11) NULL DEFAULT 0,
  `created` int(11) NULL DEFAULT NULL,
  `audited` int(11) NULL DEFAULT NULL COMMENT '审核状态0未审核或审核时间',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0禁用1发布',
  `deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1220 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '上传文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_attachment
-- ----------------------------
INSERT INTO `hc_attachment` VALUES (1000, 'post', 1000004, 0, 2, '32b39d8647304af6b3eb6d78c740ea4a.gif', '5f3026a883398fe0d0963e1404fc91b9417dda54.gif', '.gif', 'image/gif', 7987, 1, 1559644155, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1001, 'post', 0, 0, 2, '5f3026a883398fe0d0963e1404fc91b9417dda54.gif', '5f3026a883398fe0d0963e1404fc91b9417dda54.gif', '.gif', 'image/gif', 7987, 1, 1559813001, 1566291218, 1, 1566298158);
INSERT INTO `hc_attachment` VALUES (1002, 'post', 1000071, 0, 16, 'E2A566A8A7F43EAB4071EECC836EFE8E.png', 'cacb17f0283ccb6159f515b408033681ba0e66f4.png', '.png', 'image/png', 7911, 1, 1572612508, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1003, 'post', 1000072, 0, 16, '1D6F85261BDD0D161B7AF2CC3A00E419.jpg', '9ef79d56c89d244f52cd451fab3f1e30d7472b78.jpg', '.jpg', 'image/jpeg', 345517, 0, 1572612639, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1004, 'post', 1000072, 0, 16, '2A615A589ABF40ACAF7F7E0FC0836896.jpg', '8873835f991fe48e98306efd834f25c399d53a25.jpg', '.jpg', 'image/jpeg', 278867, 0, 1572612640, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1005, 'post', 1000072, 0, 16, '3A6294894053B27A801A0E1BF2844705.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 0, 1572612640, 0, 0, 1577671012);
INSERT INTO `hc_attachment` VALUES (1006, 'post', 1000072, 0, 16, 'E2A566A8A7F43EAB4071EECC836EFE8E.png', 'cacb17f0283ccb6159f515b408033681ba0e66f4.png', '.png', 'image/png', 7911, 0, 1572612640, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1007, 'post', 1000079, 0, 16, 'Screenshot from 2019-10-31 13-46-03.png', '774f9488d4d1130c3d4c23abdf28282b910f348c.png', '.png', 'image/png', 777899, 8, 1573010599, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1008, 'post', 1000079, 0, 16, 'Screenshot from 2019-11-04 19-46-06.png', '70eeda5fea4e97a493d87b363b8c634a60a6699c.png', '.png', 'image/png', 725752, 4, 1573010747, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1009, 'post', 1000079, 0, 16, 'Screenshot from 2019-10-31 14-46-40.png', '1c5e75672e76f948d07e63f4402e9fc8ff42752f.png', '.png', 'image/png', 363067, 2, 1573010750, 0, 0, 1577687108);
INSERT INTO `hc_attachment` VALUES (1010, 'post', 1000079, 0, 16, 'qqheadimg.png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 49, 1573012128, 0, 0, 1577687106);
INSERT INTO `hc_attachment` VALUES (1011, 'post', 1000079, 0, 16, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 6, 1573012285, 0, 0, 1577687110);
INSERT INTO `hc_attachment` VALUES (1012, 'post', 1000084, 0, 16, 'Screenshot from 2019-10-31 13-46-07.png', 'b6ff8c787bf61a9a2044e6ae2183c03b22acba42.png', '.png', 'image/png', 777771, 3, 1573026441, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1013, 'post', 1000084, 0, 16, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 1, 1573026459, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1014, 'post', 1000084, 0, 16, 'qqheadimg.png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 176, 1573026462, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1015, 'post', 1000081, 0, 14, '3C3480B6F5C8E322F51D252B51B6EC5456A3ADDB.png', '3c3480b6f5c8e322f51d252b51b6ec5456a3addb.png', '.png', 'image/png', 124869, 18, 1573194718, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1016, 'post', 1000086, 0, 16, 'qrcode.png', 'ef4a1e10bd3b9818c966d1e94ddb12dca5ffd985.png', '.png', 'image/png', 22694, 177, 1573212838, 0, 0, 1577687099);
INSERT INTO `hc_attachment` VALUES (1017, 'post', 1000126, 1, 25, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 21, 1573786222, 0, 0, 1577671008);
INSERT INTO `hc_attachment` VALUES (1018, 'post', 1000127, 0, 25, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 1, 1573786655, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1019, 'post', 1000127, 0, 25, 'Screenshot from 2019-10-31 13-46-03.png', '774f9488d4d1130c3d4c23abdf28282b910f348c.png', '.png', 'image/png', 777899, 1, 1573786800, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1020, 'post', 1000128, 0, 25, 'Screenshot from 2019-10-31 14-46-40.png', '1c5e75672e76f948d07e63f4402e9fc8ff42752f.png', '.png', 'image/png', 363067, 0, 1573786864, 0, 0, 1577687112);
INSERT INTO `hc_attachment` VALUES (1021, 'post', 1000129, 0, 25, 'Screenshot from 2019-10-31 13-46-03.png', '774f9488d4d1130c3d4c23abdf28282b910f348c.png', '.png', 'image/png', 777899, 0, 1573786933, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1022, 'post', 1000129, 0, 25, 'qqheadimg.png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 0, 1573787175, 0, 0, 1577671019);
INSERT INTO `hc_attachment` VALUES (1023, 'post', 1000129, 0, 25, 'Screenshot from 2019-11-14 10-32-23.png', '70505f7b941a6681c4b4c1631534c8bbab13e55d.png', '.png', 'image/png', 412542, 0, 1573788173, 0, 0, 1577671027);
INSERT INTO `hc_attachment` VALUES (1024, 'post', 1000129, 0, 25, 'Screenshot from 2019-11-04 19-46-06.png', '70eeda5fea4e97a493d87b363b8c634a60a6699c.png', '.png', 'image/png', 725752, 0, 1573788474, 0, 0, 1577675647);
INSERT INTO `hc_attachment` VALUES (1025, 'post', 1000129, 0, 25, 'Screenshot from 2019-11-13 11-51-34.png', 'a442cbfab183dbbe5c432e3565f2ec21dc4e6510.png', '.png', 'image/png', 339093, 0, 1573788493, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1026, 'post', 1000130, 0, 25, 'Screenshot from 2019-10-31 13-46-07.png', 'b6ff8c787bf61a9a2044e6ae2183c03b22acba42.png', '.png', 'image/png', 777771, 0, 1573788672, 0, 0, 1577687103);
INSERT INTO `hc_attachment` VALUES (1027, 'post', 1000130, 1, 25, 'Screenshot from 2019-10-31 13-46-03.png', '774f9488d4d1130c3d4c23abdf28282b910f348c.png', '.png', 'image/png', 777899, 0, 1573788732, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1028, 'post', 1000130, 0, 25, 'Screenshot from 2019-11-04 19-46-06.png', '70eeda5fea4e97a493d87b363b8c634a60a6699c.png', '.png', 'image/png', 725752, 0, 1573788871, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1029, 'post', 1000130, 1, 25, 'Screenshot from 2019-11-04 19-46-06.png', '70eeda5fea4e97a493d87b363b8c634a60a6699c.png', '.png', 'image/png', 725752, 1, 1573788871, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1030, 'post', 1000131, 0, 25, 'Screenshot from 2019-10-31 14-46-40.png', '1c5e75672e76f948d07e63f4402e9fc8ff42752f.png', '.png', 'image/png', 363067, 0, 1573789069, 0, 0, 1577687116);
INSERT INTO `hc_attachment` VALUES (1031, 'post', 1000131, 1, 25, 'qqheadimg.png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 13, 1573789109, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1032, 'post', 1000132, 0, 25, 'Screenshot from 2019-10-31 13-46-07.png', 'b6ff8c787bf61a9a2044e6ae2183c03b22acba42.png', '.png', 'image/png', 777771, 0, 1573789310, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1033, 'post', 1000127, 0, 25, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 11, 1573816400, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1034, 'post', 1000127, 0, 25, 'qqheadimg.png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 6, 1573816431, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1035, 'post', 1000126, 0, 25, 'qqheadimg.png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 7, 1573816431, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1036, 'post', 1000116, 0, 25, 'Screenshot from 2019-10-31 13-46-03.png', '774f9488d4d1130c3d4c23abdf28282b910f348c.png', '.png', 'image/png', 777899, 0, 1573817240, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1037, 'post', 1000133, 0, 25, 'Screenshot from 2019-10-31 13-46-03.png', '774f9488d4d1130c3d4c23abdf28282b910f348c.png', '.png', 'image/png', 777899, 0, 1573817240, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1038, 'post', 1000133, 0, 25, 'Screenshot from 2019-10-31 13-46-07.png', 'b6ff8c787bf61a9a2044e6ae2183c03b22acba42.png', '.png', 'image/png', 777771, 0, 1573817579, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1039, 'post', 1000133, 0, 25, 'Screenshot from 2019-10-31 14-46-40.png', '1c5e75672e76f948d07e63f4402e9fc8ff42752f.png', '.png', 'image/png', 363067, 0, 1573817649, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1040, 'post', 1000116, 0, 25, 'Screenshot from 2019-11-13 11-51-34.png', 'a442cbfab183dbbe5c432e3565f2ec21dc4e6510.png', '.png', 'image/png', 339093, 0, 1573820978, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1041, 'post', 1000133, 0, 25, 'Screenshot from 2019-11-04 19-46-06.png', '70eeda5fea4e97a493d87b363b8c634a60a6699c.png', '.png', 'image/png', 725752, 0, 1573822578, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1042, 'post', 1000133, 0, 25, 'Screenshot from 2019-11-13 11-51-34.png', 'a442cbfab183dbbe5c432e3565f2ec21dc4e6510.png', '.png', 'image/png', 339093, 0, 1573981974, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1043, 'post', 1000133, 0, 25, 'Screenshot from 2019-11-13 11-51-34.png', 'a442cbfab183dbbe5c432e3565f2ec21dc4e6510.png', '.png', 'image/png', 339093, 0, 1573981974, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1044, 'post', 1000126, 0, 25, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 3, 1573984019, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1045, 'post', 1000126, 0, 25, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 7, 1573984058, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1046, 'post', 1000126, 0, 25, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 6, 1573984279, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1047, 'post', 1000126, 0, 25, 'qqheadimg.png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 5, 1573984300, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1048, 'post', 1000133, 1, 25, 'qqheadimg.png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 3, 1573984369, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1049, 'post', 1000133, 0, 25, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 0, 1573984376, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1050, 'post', 1000133, 1, 25, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 3, 1573984376, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1051, 'post', 1000136, 0, 30, '6a7a47da73d79fe9672790724aadb2f7e0ea8073 (1).png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 1, 1574134323, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1052, 'post', 1000137, 0, 30, 'qqheadimg.png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 91, 1574134420, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1053, 'post', 1000137, 0, 30, 'sc.png', 'ac0a8b2ccb0c080093ce63275a3338295bd542ea.png', '.png', 'image/png', 125111, 3, 1574134896, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1055, 'avatar', 0, 0, 30, 'A111.jpeg', 'e5c116bc8edafd344b1f1f45e94d2b0b563b8a04.jpeg', '.jpeg', 'image/jpeg', 62230, 1, 1574141908, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1056, 'post', 1000137, 0, 30, 'qrcode_for_gh_a0a7290ec90a_258.jpg', '4984445758a0fdc8737154998d2797ff64fbe0c6.jpg', '.jpg', 'image/jpeg', 26476, 0, 1574141948, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1057, 'post', 1000143, 0, 14, '3C3480B6F5C8E322F51D252B51B6EC5456A3ADDB.png', '3c3480b6f5c8e322f51d252b51b6ec5456a3addb.png', '.png', 'image/png', 124869, 1, 1574424085, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1058, 'post', 1000144, 0, 14, '哈哈哈.jpg', '259a92b81bd371520bf08c694415548c06d118a1.jpg', '.jpg', 'image/jpeg', 180651, 14, 1574424104, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1059, 'post', 1000145, 1, 30, 'A3333.png', '6a7a47da73d79fe9672790724aadb2f7e0ea8073.png', '.png', 'image/png', 11888, 3, 1575272652, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1060, 'post', 1000146, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 2, 1575276111, 0, 0, 1575348641);
INSERT INTO `hc_attachment` VALUES (1061, 'post', 1000146, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 1, 1575276111, 0, 0, 1575348963);
INSERT INTO `hc_attachment` VALUES (1062, 'post', 1000146, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575276111, 0, 0, 1575349186);
INSERT INTO `hc_attachment` VALUES (1063, 'post', 1000146, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 2, 1575276111, 0, 0, 1575349319);
INSERT INTO `hc_attachment` VALUES (1064, 'post', 1000147, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 7, 1575279192, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1065, 'post', 1000149, 1, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 7, 1575281682, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1066, 'post', 1000150, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 3, 1575355723, 0, 0, 1575370601);
INSERT INTO `hc_attachment` VALUES (1067, 'post', 1000150, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575369290, 0, 0, 1575371226);
INSERT INTO `hc_attachment` VALUES (1068, 'post', 1000152, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575423773, 0, 0, 1575427734);
INSERT INTO `hc_attachment` VALUES (1069, 'post', 1000152, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575423773, 0, 0, 1575427729);
INSERT INTO `hc_attachment` VALUES (1070, 'post', 1000153, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 1, 1575424661, 0, 0, 1575427557);
INSERT INTO `hc_attachment` VALUES (1071, 'post', 1000150, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575426301, 0, 0, 1575426310);
INSERT INTO `hc_attachment` VALUES (1072, 'post', 1000149, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575427535, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1073, 'post', 1000153, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 2, 1575428164, 0, 0, 1575430714);
INSERT INTO `hc_attachment` VALUES (1074, 'post', 1000152, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575428194, 0, 0, 1575428270);
INSERT INTO `hc_attachment` VALUES (1075, 'post', 1000154, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 1, 1575429059, 0, 0, 1575429608);
INSERT INTO `hc_attachment` VALUES (1076, 'post', 1000153, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575441851, 0, 0, 1575442705);
INSERT INTO `hc_attachment` VALUES (1077, 'post', 1000153, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575441855, 0, 0, 1575441889);
INSERT INTO `hc_attachment` VALUES (1078, 'post', 1000153, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575441855, 0, 0, 1575441881);
INSERT INTO `hc_attachment` VALUES (1079, 'post', 1000153, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575442720, 0, 0, 1575442744);
INSERT INTO `hc_attachment` VALUES (1080, 'post', 1000155, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575442820, 0, 0, 1575442830);
INSERT INTO `hc_attachment` VALUES (1081, 'post', 1000155, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575443075, 0, 0, 1575443116);
INSERT INTO `hc_attachment` VALUES (1082, 'post', 1000155, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575443079, 0, 0, 1575443123);
INSERT INTO `hc_attachment` VALUES (1083, 'post', 1000156, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575443184, 0, 0, 1575443193);
INSERT INTO `hc_attachment` VALUES (1084, 'post', 1000157, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575443228, 0, 0, 1575443239);
INSERT INTO `hc_attachment` VALUES (1085, 'post', 1000154, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575443568, 0, 0, 1575447998);
INSERT INTO `hc_attachment` VALUES (1086, 'avatar', 0, 0, 32, 'king.jpeg', '940ec186304c567ead055aae6f8d6417c905ae49.jpeg', '.jpeg', 'image/jpeg', 7016, 1452, 1575451504, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1087, 'post', 1000158, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575451635, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1088, 'post', 1000159, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575452425, 0, 0, 1575452433);
INSERT INTO `hc_attachment` VALUES (1089, 'post', 1000160, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575452456, 0, 0, 1575455554);
INSERT INTO `hc_attachment` VALUES (1090, 'post', 1000162, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 1, 1575524351, 0, 0, 1575524492);
INSERT INTO `hc_attachment` VALUES (1091, 'post', 1000162, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575524497, 0, 1, 0);
INSERT INTO `hc_attachment` VALUES (1092, 'post', 1000161, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575540082, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1093, 'post', 1000161, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575540086, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1094, 'post', 1000161, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1575540086, 0, 0, 1575540112);
INSERT INTO `hc_attachment` VALUES (1095, 'post', 1000169, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 1, 1575600434, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1096, 'post', 1000171, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1575871115, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1097, 'post', 1000182, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 2, 1576050151, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1098, 'post', 1000203, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576138467, 0, 0, 1576138475);
INSERT INTO `hc_attachment` VALUES (1099, 'post', 1000205, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576139180, 0, 0, 1576223611);
INSERT INTO `hc_attachment` VALUES (1100, 'post', 1000211, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576141491, 0, 0, 1576141503);
INSERT INTO `hc_attachment` VALUES (1101, 'post', 1000211, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576141507, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1102, 'post', 1000215, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576146165, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1103, 'post', 1000216, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 2, 1576149075, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1104, 'post', 1000207, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 4, 1576206008, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1105, 'post', 1000217, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 2, 1576226454, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1106, 'post', 1000217, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 1, 1576226480, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1107, 'post', 1000244, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576485024, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1108, 'post', 1000252, 0, 35, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 1, 1576486098, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1109, 'post', 1000288, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 2, 1576567723, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1110, 'post', 1000291, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576568589, 0, 0, 1576568597);
INSERT INTO `hc_attachment` VALUES (1111, 'post', 1000291, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576568646, 0, 0, 1576568652);
INSERT INTO `hc_attachment` VALUES (1112, 'post', 1000291, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576568660, 0, 0, 1576568683);
INSERT INTO `hc_attachment` VALUES (1113, 'post', 1000291, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576568664, 0, 0, 1576568678);
INSERT INTO `hc_attachment` VALUES (1114, 'post', 1000291, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576568664, 0, 0, 1576568676);
INSERT INTO `hc_attachment` VALUES (1115, 'post', 1000291, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576568687, 0, 0, 1576568732);
INSERT INTO `hc_attachment` VALUES (1116, 'post', 1000291, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576568690, 0, 0, 1576568708);
INSERT INTO `hc_attachment` VALUES (1117, 'post', 1000291, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576568690, 0, 0, 1576568726);
INSERT INTO `hc_attachment` VALUES (1118, 'post', 1000291, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576568715, 0, 0, 1576568729);
INSERT INTO `hc_attachment` VALUES (1119, 'post', 1000291, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576568736, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1120, 'post', 1000291, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576568745, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1121, 'post', 1000293, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576568821, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1122, 'post', 1000300, 0, 31, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576569428, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1123, 'avatar', 0, 0, 38, 'king.jpeg', '940ec186304c567ead055aae6f8d6417c905ae49.jpeg', '.jpeg', 'image/jpeg', 7016, 4, 1576666090, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1124, 'post', 1000323, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576667474, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1125, 'avatar', 0, 0, 38, 'wukong.jpeg', '6d1a63291a3bacf0777fb72d7fe7d0bc87fc9346.jpeg', '.jpeg', 'image/jpeg', 4999, 168, 1576667614, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1126, 'avatar', 0, 0, 39, 'index.jpeg', '48c7837f0b0fb6b20af6d4594806edbaa06b7af8.jpeg', '.jpeg', 'image/jpeg', 3038, 162, 1576668612, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1127, 'post', 1000334, 0, 35, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576672968, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1128, 'post', 1000335, 0, 35, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576720663, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1129, 'post', 1000337, 0, 35, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 1, 1576720739, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1130, 'post', 1000338, 0, 38, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576720950, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1131, 'post', 1000339, 0, 38, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576721152, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1132, 'post', 1000341, 0, 38, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576727141, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1133, 'post', 1000347, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 17, 1576737625, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1134, 'post', 1000347, 0, 39, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576738267, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1135, 'post', 1000347, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 1, 1576738274, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1136, 'post', 1000347, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576738274, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1137, 'post', 1000349, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 2, 1576738864, 0, 0, 1576739026);
INSERT INTO `hc_attachment` VALUES (1138, 'post', 1000349, 0, 39, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576739076, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1139, 'post', 1000349, 0, 39, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576739132, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1140, 'post', 1000349, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576739392, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1141, 'post', 1000349, 0, 39, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576739431, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1142, 'post', 1000350, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576739569, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1143, 'post', 1000350, 0, 39, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576739573, 0, 0, 1576739683);
INSERT INTO `hc_attachment` VALUES (1144, 'post', 1000350, 0, 39, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576739573, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1145, 'post', 1000348, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576741561, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1146, 'post', 1000351, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576741600, 0, 0, 1576741650);
INSERT INTO `hc_attachment` VALUES (1147, 'post', 1000351, 0, 39, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576741695, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1148, 'post', 1000351, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576741698, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1149, 'post', 1000351, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576741698, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1150, 'post', 1000352, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576742291, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1151, 'post', 1000352, 0, 39, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576742296, 0, 0, 1576743134);
INSERT INTO `hc_attachment` VALUES (1152, 'post', 1000352, 0, 39, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576742296, 0, 0, 1576742341);
INSERT INTO `hc_attachment` VALUES (1153, 'post', 1000353, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576743194, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1154, 'post', 1000354, 0, 38, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576743296, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1155, 'post', 1000353, 0, 39, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 2, 1576743410, 0, 1, 0);
INSERT INTO `hc_attachment` VALUES (1156, 'post', 1000356, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576743559, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1157, 'post', 1000357, 0, 39, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576743573, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1158, 'post', 1000359, 0, 40, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 1, 1576745486, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1159, 'post', 1000361, 0, 40, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576745835, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1160, 'post', 1000361, 0, 40, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576745854, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1161, 'post', 1000362, 0, 38, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1576745949, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1162, 'post', 1000363, 0, 38, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576746043, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1163, 'post', 1000365, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576747518, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1164, 'post', 1000366, 0, 35, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576747604, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1165, 'post', 1000374, 0, 40, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1576748470, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1166, 'post', 1000375, 0, 41, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 1, 1576748717, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1167, 'post', 1000376, 0, 41, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 1, 1576752137, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1168, 'post', 1000276, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 1, 1577329916, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1169, 'post', 1000200, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 1, 1577330342, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1170, 'avatar', 0, 0, 37, 'MM.jpeg', '8d2c80e9c3f6746b5dfe283cce46c77e6af7ac7c.jpeg', '.jpeg', 'image/jpeg', 7378, 63, 1577344321, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1171, 'post', 1000379, 0, 37, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577345645, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1172, 'avatar', 0, 0, 42, 'MM.jpeg', '8d2c80e9c3f6746b5dfe283cce46c77e6af7ac7c.jpeg', '.jpeg', 'image/jpeg', 7378, 21, 1577349256, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1173, 'post', 1000387, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577413608, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1174, 'post', 1000390, 0, 31, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 1, 1577426727, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1175, 'post', 1000393, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577439384, 0, 0, 1577439392);
INSERT INTO `hc_attachment` VALUES (1176, 'post', 1000396, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577440490, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1177, 'post', 1000401, 1, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 10, 1577594894, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1178, 'post', 1000401, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 7, 1577594923, 0, 1, 0);
INSERT INTO `hc_attachment` VALUES (1179, 'post', 1000406, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577594923, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1180, 'post', 1000401, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1577595327, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1181, 'post', 1000401, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 9, 1577595327, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1182, 'post', 1000402, 0, 45, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1577600535, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1183, 'post', 1000404, 1, 45, 'u=3915473762,2909404885&fm=26&gp=0.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 14, 1577600760, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1184, 'post', 1000409, 1, 32, 'u=3915473762,2909404885&fm=26&gp=0.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 13, 1577614010, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1185, 'post', 1000410, 0, 46, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577621087, 0, 0, 1577621106);
INSERT INTO `hc_attachment` VALUES (1186, 'avatar', 0, 0, 46, 'MM.jpeg', '8d2c80e9c3f6746b5dfe283cce46c77e6af7ac7c.jpeg', '.jpeg', 'image/jpeg', 7378, 71, 1577621266, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1187, 'post', 1000416, 1, 46, 'u=3915473762,2909404885&fm=26&gp=0.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 5, 1577622270, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1188, 'post', 1000416, 0, 46, 'u=3915473762,2909404885&fm=26&gp=0.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 6, 1577622291, 0, 0, 1577622342);
INSERT INTO `hc_attachment` VALUES (1189, 'post', 1000416, 0, 46, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577622367, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1190, 'post', 1000416, 0, 46, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 12, 1577622367, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1191, 'post', 1000417, 1, 46, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 7, 1577622445, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1192, 'post', 1000417, 0, 46, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 3, 1577622497, 0, 0, 1577622523);
INSERT INTO `hc_attachment` VALUES (1193, 'post', 1000417, 0, 46, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 11, 1577622549, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1194, 'post', 1000417, 0, 46, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 2, 1577622569, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1195, 'post', 1000421, 0, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 2, 1577623034, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1196, 'post', 1000423, 0, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 0, 1577675933, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1197, 'post', 1000424, 0, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 0, 1577675960, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1198, 'post', 1000424, 1, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 12, 1577675960, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1199, 'post', 1000430, 1, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 5, 1577676090, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1200, 'post', 1000431, 0, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 2, 1577676433, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1201, 'post', 1000432, 1, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 5, 1577676449, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1202, 'post', 1000433, 1, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 5, 1577676481, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1203, 'post', 1000200, 0, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 4, 1577676512, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1204, 'post', 1000435, 1, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 3, 1577692173, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1205, 'post', 1000204, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577692251, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1206, 'post', 1000197, 0, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 9, 1577692274, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1207, 'post', 1000197, 0, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 7, 1577692297, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1208, 'post', 1000197, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577692306, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1209, 'post', 1000197, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577692306, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1210, 'post', 1000197, 0, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 6, 1577692329, 0, 1, 0);
INSERT INTO `hc_attachment` VALUES (1211, 'post', 1000204, 0, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 4, 1577692350, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1212, 'post', 1000205, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577692389, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1213, 'post', 1000205, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1577692392, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1214, 'post', 1000205, 0, 32, '357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658.gif', 'b748ab314379e15a814fd1cdd070896557c0975e.gif', '.gif', 'image/gif', 135066, 0, 1577692392, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1215, 'post', 1000206, 0, 32, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 1, 1577692405, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1216, 'post', 1000436, 0, 47, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 1, 1577699709, 0, 0, 1577699749);
INSERT INTO `hc_attachment` VALUES (1217, 'post', 1000436, 0, 47, 'sss.png', 'd6698365564b8446cc0c75c6b5c85a1076bd9c6f.png', '.png', 'image/png', 16841, 7, 1577699755, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1218, 'avatar', 0, 0, 47, 'MM.jpeg', '8d2c80e9c3f6746b5dfe283cce46c77e6af7ac7c.jpeg', '.jpeg', 'image/jpeg', 7378, 6, 1577699808, 0, 0, 0);
INSERT INTO `hc_attachment` VALUES (1219, 'post', 1000438, 0, 32, '1.gif', '45d5ffd4e5b93a5288896151df8aac7ff4d183e8.gif', '.gif', 'image/gif', 11000, 0, 1577700089, 0, 0, 0);

-- ----------------------------
-- Table structure for hc_forum
-- ----------------------------
DROP TABLE IF EXISTS `hc_forum`;
CREATE TABLE `hc_forum`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `threads` int(11) NOT NULL DEFAULT 0,
  `posts` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `last_thread_id` int(11) NULL DEFAULT NULL,
  `deleted` int(11) NULL DEFAULT 0,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `type_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 161 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '论坛版块' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_forum
-- ----------------------------
INSERT INTO `hc_forum` VALUES (101, 'D语言1', '', '', 0, 0, 0, 1, 0, 0, 1566550852, 1566550852, '1');
INSERT INTO `hc_forum` VALUES (102, 'D语言框架', NULL, '', 0, 0, 0, 1, 0, 0, 1234567890, 1234567890, '1');
INSERT INTO `hc_forum` VALUES (103, 'D语言讨论1', 'D 语言讨论与经验分享。', '/images/dlang-icon.png', 101, 80, 80, 1, 10180, 0, 1566285740, 1566285740, '1');
INSERT INTO `hc_forum` VALUES (104, 'D语言新手问题', '有问必答，D 语言不会的问题请发在这里。', '/images/help-icon.png', 101, 24, 24, 1, 10178, 0, 1234567890, 1234567890, '2');
INSERT INTO `hc_forum` VALUES (105, 'Hunt Framework888', 'Web 框架 Hunt Framework 相关框架使用问题和经验分享。', '/images/hunt-icon.png', 102, 9, 9, 1, 10164, 0, 1577347171, 1577347171, '1');
INSERT INTO `hc_forum` VALUES (106, 'test', 'test', '', 102, 0, 0, 0, 0, 0, 1565692390, 1565692390, '2');
INSERT INTO `hc_forum` VALUES (111, 'D设计', '设计设计', '1', 0, 0, 0, 0, 0, 0, 1577347175, 1577347175, '1');
INSERT INTO `hc_forum` VALUES (112, 'D研究', '研究研究', '2', 0, 0, 0, 0, 0, 0, 1565861850, 1565861850, '0');
INSERT INTO `hc_forum` VALUES (119, '设计点东西', '设计设计', '1', 111, 0, 0, 0, 0, 0, 1565863704, 1565863704, '1');
INSERT INTO `hc_forum` VALUES (120, '研究点东西', '研究研究', '1', 112, 0, 0, 0, 0, 0, 1565863735, 1565863735, '1');
INSERT INTO `hc_forum` VALUES (132, 'fdtrrdf', 'sfgfrtygyh', '22', 120, 0, 0, 0, 0, 0, 1566194755, 1566194755, '2');
INSERT INTO `hc_forum` VALUES (140, 'u', 'u', 'u', 105, 0, 0, 0, 0, 0, 1566214197, 1566214197, '1');
INSERT INTO `hc_forum` VALUES (141, '测试1', 'cc', 'cc', 0, 0, 0, 0, 0, 0, 1566285799, 1566285799, '1');
INSERT INTO `hc_forum` VALUES (146, '小测试q', 'ii', 'ii', 141, 0, 0, 0, 0, 0, 1566551091, 1566551091, '1');
INSERT INTO `hc_forum` VALUES (147, 'rr', 'rr', 'rr', 0, 0, 0, 0, 0, 0, 1566465177, 1566465177, '1');
INSERT INTO `hc_forum` VALUES (159, '开发v', 'svp', 'svp', 0, 0, 0, 0, 0, 0, 1566554569, 1566554569, '1');
INSERT INTO `hc_forum` VALUES (160, '111', '2222', '33333', 111, 0, 0, 0, 0, 0, 1577598042, 1577598042, '2');

-- ----------------------------
-- Table structure for hc_forum_post
-- ----------------------------
DROP TABLE IF EXISTS `hc_forum_post`;
CREATE TABLE `hc_forum_post`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL COMMENT '主题ID',
  `uid` int(11) NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_html` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `likes` int(11) NULL DEFAULT 0,
  `attachments` int(11) NULL DEFAULT 0,
  `comments` int(11) NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0禁用1已发布',
  `deleted` int(11) NULL DEFAULT 0,
  `updated` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `audited` int(11) NULL DEFAULT 0 COMMENT '审核状态0未审核或审核时间',
  PRIMARY KEY (`id`) USING BTREE,
  FULLTEXT INDEX `fulltext_content`(`content`)
) ENGINE = InnoDB AUTO_INCREMENT = 1000440 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_forum_post
-- ----------------------------

-- ----------------------------
-- Table structure for hc_forum_thread
-- ----------------------------
DROP TABLE IF EXISTS `hc_forum_thread`;
CREATE TABLE `hc_forum_thread`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forum_id` int(11) NULL DEFAULT NULL COMMENT '版块ID',
  `title` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uid` int(11) NOT NULL,
  `keywords` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键词a,b,c',
  `posts` int(11) NULL DEFAULT 1,
  `views` int(11) NULL DEFAULT 1,
  `status` tinyint(2) NOT NULL COMMENT '0关1开',
  `last_uid` int(11) NULL DEFAULT NULL,
  `last_time` int(11) NULL DEFAULT NULL,
  `deleted` int(11) NULL DEFAULT NULL,
  `updated` int(11) NULL DEFAULT NULL,
  `created` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  FULLTEXT INDEX `fulltext_title`(`title`)
) ENGINE = InnoDB AUTO_INCREMENT = 10181 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_forum_thread
-- ----------------------------

-- ----------------------------
-- Table structure for hc_system_file_info_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_file_info_backup`;
CREATE TABLE `hc_system_file_info_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `filename` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0',
  `rename` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  `sha1` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0',
  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '0',
  `size` bigint(20) NULL DEFAULT 0,
  `created` int(11) NULL DEFAULT 0,
  `updated` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_file_info_backup
-- ----------------------------

-- ----------------------------
-- Table structure for hc_system_lang_package
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_lang_package`;
CREATE TABLE `hc_system_lang_package`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `local` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_lang_package
-- ----------------------------
INSERT INTO `hc_system_lang_package` VALUES (1, 'zh-cn', 'TEST', '测试', 1557392339, 1557392339, 0);
INSERT INTO `hc_system_lang_package` VALUES (2, 'en', 'TEST', 'test123', 1557392352, 1557392816, 0);
INSERT INTO `hc_system_lang_package` VALUES (5, 'zh-cn', 'DEL', '删除', 1557399191, 1557399191, 0);
INSERT INTO `hc_system_lang_package` VALUES (7, 'zh-cn', '__SYSTEM_MENU_SYSTEM_LANGPACKAGE_LIST', '语言包系统定义TEST', 1557482466, 1557482466, 0);
INSERT INTO `hc_system_lang_package` VALUES (8, 'en', '__SYSTEM_MENU_SYSTEM_LANGPACKAGE_ADD', '语言包系统定义TEST', 1557714176, 1557714176, 0);
INSERT INTO `hc_system_lang_package` VALUES (9, 'en', '__SYSTEM_MENU_SYSTEM_LANGPACKAGE_ADD', '语言包系统定义TEST', 1558078734, 1558078734, 0);
INSERT INTO `hc_system_lang_package` VALUES (10, 'en', '__SYSTEM_MENU_38', '语言包系统定义TEST', 1558337985, 1558337985, 0);
INSERT INTO `hc_system_lang_package` VALUES (11, 'zh-cn', '__SYSTEM_MENU_38', 'Forums', 1558344546, 1565690690, 0);
INSERT INTO `hc_system_lang_package` VALUES (13, 'zh-hk', '__SYSTEM_MENU_38', '語言包管理', 1558346385, 1558346385, 0);
INSERT INTO `hc_system_lang_package` VALUES (15, 'zh-cn', '__SYSTEM_MENU_36', '语言包管理', 1558347075, 1558347075, 0);
INSERT INTO `hc_system_lang_package` VALUES (16, 'zh-cn', '__SYSTEM_MENU_37', 'Forum', 1565595785, 1565595785, 0);
INSERT INTO `hc_system_lang_package` VALUES (17, 'zh-cn', '__SYSTEM_MENU_39', 'Threads', 1565595980, 1565690746, 0);
INSERT INTO `hc_system_lang_package` VALUES (18, 'zh-cn', '__SYSTEM_MENU_40', 'Attachment', 1565857864, 1565857864, 0);
INSERT INTO `hc_system_lang_package` VALUES (19, 'zh-cn', '__SYSTEM_MENU_41', 'Attachment', 1565858222, 1565858222, 0);
INSERT INTO `hc_system_lang_package` VALUES (20, 'zh-cn', '__SYSTEM_MENU_42', 'User', 1566462773, 1566462773, 0);
INSERT INTO `hc_system_lang_package` VALUES (21, 'zh-cn', '__SYSTEM_MENU_43', 'User', 1566462906, 1566462906, 0);
INSERT INTO `hc_system_lang_package` VALUES (22, 'zh-cn', '__SYSTEM_MENU_44', 'User', 1566469555, 1566469555, 0);
INSERT INTO `hc_system_lang_package` VALUES (23, 'zh-cn', '__SYSTEM_MENU_45', '语言包管理', 1566470042, 1577670625, 0);

-- ----------------------------
-- Table structure for hc_system_language
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_language`;
CREATE TABLE `hc_system_language`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '语言显示名称 如：繁体中文 简体中文 English',
  `sign` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '语言标识 如：zh-hk zh-cn en',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '状态：1 可用 2 不可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_language
-- ----------------------------
INSERT INTO `hc_system_language` VALUES (1, 'English', 'en', 1);
INSERT INTO `hc_system_language` VALUES (2, '简体中文', 'zh-cn', 1);
INSERT INTO `hc_system_language` VALUES (3, '繁體中文', 'zh-hk', 1);

-- ----------------------------
-- Table structure for hc_system_log_info_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_log_info_backup`;
CREATE TABLE `hc_system_log_info_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `action` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0',
  `params` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `type` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '0',
  `time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 521 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_log_info_backup
-- ----------------------------
INSERT INTO `hc_system_log_info_backup` VALUES (1, 98, 'system.permission.list', 'null', 'GET', 1530096592);
INSERT INTO `hc_system_log_info_backup` VALUES (2, 98, 'system.permission.edit', '{\"id\":\"components.article.add\"}', 'GET', 1530096625);
INSERT INTO `hc_system_log_info_backup` VALUES (3, 98, 'system.permission.list', 'null', 'GET', 1530096652);
INSERT INTO `hc_system_log_info_backup` VALUES (4, 98, 'system.permission.edit', '{\"id\":\"components.article.list\"}', 'GET', 1530096692);
INSERT INTO `hc_system_log_info_backup` VALUES (5, 98, 'system.permission.list', 'null', 'GET', 1530100977);
INSERT INTO `hc_system_log_info_backup` VALUES (6, 98, 'system.permission.list', 'null', 'GET', 1530100984);
INSERT INTO `hc_system_log_info_backup` VALUES (7, 98, 'system.permission.list', 'null', 'GET', 1530101881);
INSERT INTO `hc_system_log_info_backup` VALUES (9, 98, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530101903);
INSERT INTO `hc_system_log_info_backup` VALUES (10, 98, 'system.permission.list', 'null', 'GET', 1530101301);
INSERT INTO `hc_system_log_info_backup` VALUES (11, 98, 'system.permission.list', 'null', 'GET', 1530101922);
INSERT INTO `hc_system_log_info_backup` VALUES (12, 98, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530101306);
INSERT INTO `hc_system_log_info_backup` VALUES (13, 98, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add+article\"}', 'POST', 1530101321);
INSERT INTO `hc_system_log_info_backup` VALUES (14, 98, 'system.permission.list', 'null', 'GET', 1530101322);
INSERT INTO `hc_system_log_info_backup` VALUES (15, 98, 'system.permission.list', 'null', 'GET', 1530101981);
INSERT INTO `hc_system_log_info_backup` VALUES (16, 98, 'system.permission.list', 'null', 'GET', 1530150245);
INSERT INTO `hc_system_log_info_backup` VALUES (17, 98, 'system.permission.list', 'null', 'GET', 1530150250);
INSERT INTO `hc_system_log_info_backup` VALUES (18, 98, 'system.permission.list', 'null', 'GET', 1530150256);
INSERT INTO `hc_system_log_info_backup` VALUES (19, 98, 'system.permission.list', 'null', 'GET', 1530150321);
INSERT INTO `hc_system_log_info_backup` VALUES (20, 98, 'system.permission.list', 'null', 'GET', 1530152506);
INSERT INTO `hc_system_log_info_backup` VALUES (21, 98, 'system.permission.list', 'null', 'GET', 1530152521);
INSERT INTO `hc_system_log_info_backup` VALUES (22, 98, 'system.permission.list', 'null', 'GET', 1530152543);
INSERT INTO `hc_system_log_info_backup` VALUES (23, 98, 'system.permission.list', 'null', 'GET', 1530152552);
INSERT INTO `hc_system_log_info_backup` VALUES (24, 98, 'system.permission.list', 'null', 'GET', 1530152554);
INSERT INTO `hc_system_log_info_backup` VALUES (25, 98, 'system.permission.list', 'null', 'GET', 1530152560);
INSERT INTO `hc_system_log_info_backup` VALUES (26, 98, 'system.permission.list', 'null', 'GET', 1530152571);
INSERT INTO `hc_system_log_info_backup` VALUES (27, 98, 'system.permission.list', 'null', 'GET', 1530152577);
INSERT INTO `hc_system_log_info_backup` VALUES (28, 98, 'system.permission.list', 'null', 'GET', 1530157137);
INSERT INTO `hc_system_log_info_backup` VALUES (29, 98, 'system.permission.list', 'null', 'GET', 1530157154);
INSERT INTO `hc_system_log_info_backup` VALUES (30, 98, 'system.permission.list', 'null', 'GET', 1530160336);
INSERT INTO `hc_system_log_info_backup` VALUES (31, 98, 'system.permission.list', 'null', 'GET', 1530165778);
INSERT INTO `hc_system_log_info_backup` VALUES (32, 98, 'system.permission.list', 'null', 'GET', 1530165815);
INSERT INTO `hc_system_log_info_backup` VALUES (33, 98, 'system.permission.list', 'null', 'GET', 1530168638);
INSERT INTO `hc_system_log_info_backup` VALUES (34, 98, 'system.permission.add', 'null', 'GET', 1530168682);
INSERT INTO `hc_system_log_info_backup` VALUES (35, 98, 'system.permission.add', 'null', 'GET', 1530168692);
INSERT INTO `hc_system_log_info_backup` VALUES (36, 98, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.log.list\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1530168711);
INSERT INTO `hc_system_log_info_backup` VALUES (37, 98, 'system.permission.list', 'null', 'GET', 1530168711);
INSERT INTO `hc_system_log_info_backup` VALUES (38, 98, 'system.permission.list', 'null', 'GET', 1530168772);
INSERT INTO `hc_system_log_info_backup` VALUES (39, 98, 'system.permission.add', 'null', 'GET', 1530168774);
INSERT INTO `hc_system_log_info_backup` VALUES (40, 98, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.log.del\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1530168791);
INSERT INTO `hc_system_log_info_backup` VALUES (41, 98, 'system.permission.list', 'null', 'GET', 1530168791);
INSERT INTO `hc_system_log_info_backup` VALUES (42, 98, 'system.permission.list', 'null', 'GET', 1530168963);
INSERT INTO `hc_system_log_info_backup` VALUES (43, 98, 'system.permission.list', 'null', 'GET', 1530170352);
INSERT INTO `hc_system_log_info_backup` VALUES (44, 98, 'system.permission.list', 'null', 'GET', 1530170369);
INSERT INTO `hc_system_log_info_backup` VALUES (45, 98, 'system.permission.list', 'null', 'GET', 1530174223);
INSERT INTO `hc_system_log_info_backup` VALUES (46, 98, 'system.permission.list', 'null', 'GET', 1530178984);
INSERT INTO `hc_system_log_info_backup` VALUES (47, 98, 'system.permission.list', 'null', 'GET', 1530179251);
INSERT INTO `hc_system_log_info_backup` VALUES (48, 98, 'system.permission.list', 'null', 'GET', 1530179324);
INSERT INTO `hc_system_log_info_backup` VALUES (49, 99, 'system.permission.list', 'null', 'GET', 1530185469);
INSERT INTO `hc_system_log_info_backup` VALUES (50, 98, 'system.permission.list', 'null', 'GET', 1530186038);
INSERT INTO `hc_system_log_info_backup` VALUES (51, 99, 'system.permission.list', 'null', 'GET', 1530186789);
INSERT INTO `hc_system_log_info_backup` VALUES (52, 99, 'system.permission.add', 'null', 'GET', 1530186801);
INSERT INTO `hc_system_log_info_backup` VALUES (53, 99, 'system.permission.add', 'null', 'GET', 1530186811);
INSERT INTO `hc_system_log_info_backup` VALUES (54, 99, 'system.permission.list', 'null', 'GET', 1530186832);
INSERT INTO `hc_system_log_info_backup` VALUES (55, 0, 'system.permission.list', 'null', 'GET', 1530238712);
INSERT INTO `hc_system_log_info_backup` VALUES (56, 0, 'system.permission.list', 'null', 'GET', 1530238726);
INSERT INTO `hc_system_log_info_backup` VALUES (57, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530238728);
INSERT INTO `hc_system_log_info_backup` VALUES (58, 0, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530238741);
INSERT INTO `hc_system_log_info_backup` VALUES (59, 0, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530239559);
INSERT INTO `hc_system_log_info_backup` VALUES (60, 0, 'system.permission.list', 'null', 'GET', 1530239566);
INSERT INTO `hc_system_log_info_backup` VALUES (61, 0, 'system.permission.edit', '{\"id\":\"article.article.del\"}', 'GET', 1530239570);
INSERT INTO `hc_system_log_info_backup` VALUES (62, 0, 'system.permission.list', 'null', 'GET', 1530239630);
INSERT INTO `hc_system_log_info_backup` VALUES (63, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530239635);
INSERT INTO `hc_system_log_info_backup` VALUES (64, 0, 'system.permission.list', 'null', 'GET', 1530239283);
INSERT INTO `hc_system_log_info_backup` VALUES (65, 0, 'system.permission.list', 'null', 'GET', 1530239296);
INSERT INTO `hc_system_log_info_backup` VALUES (66, 0, 'system.permission.edit', '{\"id\":\"system.role.add\"}', 'GET', 1530239304);
INSERT INTO `hc_system_log_info_backup` VALUES (67, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530239328);
INSERT INTO `hc_system_log_info_backup` VALUES (68, 0, 'system.permission.edit', '{\"id\":\"system.role.del\"}', 'GET', 1530239337);
INSERT INTO `hc_system_log_info_backup` VALUES (69, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"system.role.del\",\"statusRadio\":\"1\",\"title\":\"????1\"}', 'POST', 1530239345);
INSERT INTO `hc_system_log_info_backup` VALUES (70, 0, 'system.permission.list', 'null', 'GET', 1530239347);
INSERT INTO `hc_system_log_info_backup` VALUES (71, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530239352);
INSERT INTO `hc_system_log_info_backup` VALUES (72, 0, 'system.permission.edit', '{\"id\":\"system.role.del\"}', 'GET', 1530239355);
INSERT INTO `hc_system_log_info_backup` VALUES (73, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"system.role.del\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1530239362);
INSERT INTO `hc_system_log_info_backup` VALUES (74, 0, 'system.permission.list', 'null', 'GET', 1530239364);
INSERT INTO `hc_system_log_info_backup` VALUES (75, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530239368);
INSERT INTO `hc_system_log_info_backup` VALUES (76, 0, 'system.permission.edit', '{\"id\":\"system.role.del\"}', 'GET', 1530239374);
INSERT INTO `hc_system_log_info_backup` VALUES (77, 0, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.role.del\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1530239383);
INSERT INTO `hc_system_log_info_backup` VALUES (78, 0, 'system.permission.list', 'null', 'GET', 1530239384);
INSERT INTO `hc_system_log_info_backup` VALUES (79, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530239392);
INSERT INTO `hc_system_log_info_backup` VALUES (80, 0, 'system.permission.edit', '{\"id\":\"system.role.del\"}', 'GET', 1530239399);
INSERT INTO `hc_system_log_info_backup` VALUES (81, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"system.role.del\",\"statusRadio\":\"0\",\"title\":\"????\"}', 'POST', 1530239408);
INSERT INTO `hc_system_log_info_backup` VALUES (82, 0, 'system.permission.list', 'null', 'GET', 1530239409);
INSERT INTO `hc_system_log_info_backup` VALUES (83, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530239414);
INSERT INTO `hc_system_log_info_backup` VALUES (84, 0, 'system.permission.edit', '{\"id\":\"system.role.del\"}', 'GET', 1530239423);
INSERT INTO `hc_system_log_info_backup` VALUES (85, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"system.role.del\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1530239427);
INSERT INTO `hc_system_log_info_backup` VALUES (86, 0, 'system.permission.list', 'null', 'GET', 1530239429);
INSERT INTO `hc_system_log_info_backup` VALUES (87, 0, 'system.permission.list', 'null', 'GET', 1530239443);
INSERT INTO `hc_system_log_info_backup` VALUES (88, 0, 'system.permission.add', 'null', 'GET', 1530239447);
INSERT INTO `hc_system_log_info_backup` VALUES (89, 0, 'system.permission.list', 'null', 'GET', 1530239486);
INSERT INTO `hc_system_log_info_backup` VALUES (90, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530239494);
INSERT INTO `hc_system_log_info_backup` VALUES (91, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add+article\"}', 'POST', 1530239501);
INSERT INTO `hc_system_log_info_backup` VALUES (92, 0, 'system.permission.list', 'null', 'GET', 1530239503);
INSERT INTO `hc_system_log_info_backup` VALUES (93, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530239515);
INSERT INTO `hc_system_log_info_backup` VALUES (94, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add+article\"}', 'POST', 1530239537);
INSERT INTO `hc_system_log_info_backup` VALUES (95, 0, 'system.permission.list', 'null', 'GET', 1530239539);
INSERT INTO `hc_system_log_info_backup` VALUES (96, 0, 'system.permission.edit', '{\"id\":\"article.article.del\"}', 'GET', 1530239544);
INSERT INTO `hc_system_log_info_backup` VALUES (97, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.del\",\"statusRadio\":\"1\",\"title\":\"??11??\"}', 'POST', 1530239548);
INSERT INTO `hc_system_log_info_backup` VALUES (98, 0, 'system.permission.list', 'null', 'GET', 1530239549);
INSERT INTO `hc_system_log_info_backup` VALUES (99, 0, 'system.permission.edit', '{\"id\":\"article.article.del\"}', 'GET', 1530239553);
INSERT INTO `hc_system_log_info_backup` VALUES (100, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.del\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1530239559);
INSERT INTO `hc_system_log_info_backup` VALUES (101, 0, 'system.permission.list', 'null', 'GET', 1530239561);
INSERT INTO `hc_system_log_info_backup` VALUES (102, 0, 'system.permission.list', 'null', 'GET', 1530239601);
INSERT INTO `hc_system_log_info_backup` VALUES (103, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530239604);
INSERT INTO `hc_system_log_info_backup` VALUES (104, 0, 'system.permission.list', 'null', 'GET', 1530239905);
INSERT INTO `hc_system_log_info_backup` VALUES (105, 0, 'system.permission.list', 'null', 'GET', 1530239934);
INSERT INTO `hc_system_log_info_backup` VALUES (106, 0, 'system.permission.list', 'null', 'GET', 1530239957);
INSERT INTO `hc_system_log_info_backup` VALUES (107, 0, 'system.permission.list', 'null', 'GET', 1530240006);
INSERT INTO `hc_system_log_info_backup` VALUES (108, 0, 'system.permission.list', 'null', 'GET', 1530240029);
INSERT INTO `hc_system_log_info_backup` VALUES (109, 0, 'system.permission.list', 'null', 'GET', 1530251740);
INSERT INTO `hc_system_log_info_backup` VALUES (110, 0, 'system.permission.list', 'null', 'GET', 1530251884);
INSERT INTO `hc_system_log_info_backup` VALUES (111, 0, 'system.permission.list', 'null', 'GET', 1530251887);
INSERT INTO `hc_system_log_info_backup` VALUES (112, 0, 'system.permission.list', 'null', 'GET', 1530251981);
INSERT INTO `hc_system_log_info_backup` VALUES (113, 0, 'system.permission.list', 'null', 'GET', 1530252043);
INSERT INTO `hc_system_log_info_backup` VALUES (114, 0, 'system.permission.list', 'null', 'GET', 1530252098);
INSERT INTO `hc_system_log_info_backup` VALUES (115, 0, 'system.permission.list', 'null', 'GET', 1530252577);
INSERT INTO `hc_system_log_info_backup` VALUES (116, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530252584);
INSERT INTO `hc_system_log_info_backup` VALUES (117, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add++++article\"}', 'POST', 1530252591);
INSERT INTO `hc_system_log_info_backup` VALUES (118, 0, 'system.permission.list', 'null', 'GET', 1530252594);
INSERT INTO `hc_system_log_info_backup` VALUES (119, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530252600);
INSERT INTO `hc_system_log_info_backup` VALUES (120, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add+article\"}', 'POST', 1530252606);
INSERT INTO `hc_system_log_info_backup` VALUES (121, 0, 'system.permission.list', 'null', 'GET', 1530252609);
INSERT INTO `hc_system_log_info_backup` VALUES (122, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530252680);
INSERT INTO `hc_system_log_info_backup` VALUES (123, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add+++++article\"}', 'POST', 1530252686);
INSERT INTO `hc_system_log_info_backup` VALUES (124, 0, 'system.permission.list', 'null', 'GET', 1530252687);
INSERT INTO `hc_system_log_info_backup` VALUES (125, 0, 'system.permission.list', 'null', 'GET', 1530252692);
INSERT INTO `hc_system_log_info_backup` VALUES (126, 0, 'system.permission.list', 'null', 'GET', 1530252872);
INSERT INTO `hc_system_log_info_backup` VALUES (127, 0, 'system.permission.list', 'null', 'GET', 1530252907);
INSERT INTO `hc_system_log_info_backup` VALUES (128, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530252909);
INSERT INTO `hc_system_log_info_backup` VALUES (129, 0, 'system.permission.list', 'null', 'GET', 1530254037);
INSERT INTO `hc_system_log_info_backup` VALUES (130, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530254041);
INSERT INTO `hc_system_log_info_backup` VALUES (131, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add article\"}', 'POST', 1530254044);
INSERT INTO `hc_system_log_info_backup` VALUES (132, 0, 'system.permission.list', 'null', 'GET', 1530254044);
INSERT INTO `hc_system_log_info_backup` VALUES (133, 0, 'system.permission.list', 'null', 'GET', 1530254092);
INSERT INTO `hc_system_log_info_backup` VALUES (134, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530254097);
INSERT INTO `hc_system_log_info_backup` VALUES (135, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add++article\"}', 'POST', 1530254100);
INSERT INTO `hc_system_log_info_backup` VALUES (136, 0, 'system.permission.list', 'null', 'GET', 1530254102);
INSERT INTO `hc_system_log_info_backup` VALUES (137, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530254109);
INSERT INTO `hc_system_log_info_backup` VALUES (138, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add++article\"}', 'POST', 1530254117);
INSERT INTO `hc_system_log_info_backup` VALUES (139, 0, 'system.permission.list', 'null', 'GET', 1530254119);
INSERT INTO `hc_system_log_info_backup` VALUES (140, 0, 'system.permission.list', 'null', 'GET', 1530254381);
INSERT INTO `hc_system_log_info_backup` VALUES (141, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530254385);
INSERT INTO `hc_system_log_info_backup` VALUES (142, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add+article\"}', 'POST', 1530254389);
INSERT INTO `hc_system_log_info_backup` VALUES (143, 0, 'system.permission.list', 'null', 'GET', 1530254390);
INSERT INTO `hc_system_log_info_backup` VALUES (144, 0, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530254394);
INSERT INTO `hc_system_log_info_backup` VALUES (145, 0, 'system.permission.list', 'null', 'GET', 1530255330);
INSERT INTO `hc_system_log_info_backup` VALUES (146, 0, 'system.permission.edit', '{\"id\":\"article.article.del\"}', 'GET', 1530255333);
INSERT INTO `hc_system_log_info_backup` VALUES (147, 0, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.del\",\"statusRadio\":\"1\",\"title\":\"?? ??\"}', 'POST', 1530255338);
INSERT INTO `hc_system_log_info_backup` VALUES (148, 0, 'system.permission.list', 'null', 'GET', 1530255338);
INSERT INTO `hc_system_log_info_backup` VALUES (149, 98, 'system.permission.list', 'null', 'GET', 1530254765);
INSERT INTO `hc_system_log_info_backup` VALUES (150, 98, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530254769);
INSERT INTO `hc_system_log_info_backup` VALUES (151, 98, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add++article\"}', 'POST', 1530254776);
INSERT INTO `hc_system_log_info_backup` VALUES (152, 98, 'system.permission.list', 'null', 'GET', 1530254778);
INSERT INTO `hc_system_log_info_backup` VALUES (153, 98, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530255134);
INSERT INTO `hc_system_log_info_backup` VALUES (154, 98, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530255136);
INSERT INTO `hc_system_log_info_backup` VALUES (155, 98, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"article.article.add\",\"statusRadio\":\"1\",\"title\":\"add article\"}', 'POST', 1530255141);
INSERT INTO `hc_system_log_info_backup` VALUES (156, 98, 'system.permission.list', 'null', 'GET', 1530255142);
INSERT INTO `hc_system_log_info_backup` VALUES (157, 98, 'system.permission.list', 'null', 'GET', 1530255786);
INSERT INTO `hc_system_log_info_backup` VALUES (158, 98, 'system.permission.list', 'null', 'GET', 1530255977);
INSERT INTO `hc_system_log_info_backup` VALUES (159, 98, 'system.permission.list', 'null', 'GET', 1530256005);
INSERT INTO `hc_system_log_info_backup` VALUES (160, 0, 'system.permission.list', 'null', 'GET', 1530257341);
INSERT INTO `hc_system_log_info_backup` VALUES (161, 0, 'system.permission.list', 'null', 'GET', 1530257347);
INSERT INTO `hc_system_log_info_backup` VALUES (162, 0, 'system.permission.list', 'null', 'GET', 1530257453);
INSERT INTO `hc_system_log_info_backup` VALUES (163, 0, 'system.permission.add', 'null', 'GET', 1530257482);
INSERT INTO `hc_system_log_info_backup` VALUES (164, 0, 'system.permission.list', 'null', 'GET', 1530257536);
INSERT INTO `hc_system_log_info_backup` VALUES (165, 0, 'system.permission.list', 'null', 'GET', 1530261158);
INSERT INTO `hc_system_log_info_backup` VALUES (166, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530261161);
INSERT INTO `hc_system_log_info_backup` VALUES (167, 0, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530261167);
INSERT INTO `hc_system_log_info_backup` VALUES (168, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530261171);
INSERT INTO `hc_system_log_info_backup` VALUES (169, 0, 'system.permission.list', 'null', 'GET', 1530261191);
INSERT INTO `hc_system_log_info_backup` VALUES (170, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530261195);
INSERT INTO `hc_system_log_info_backup` VALUES (171, 98, 'system.permission.list', 'null', 'GET', 1530262336);
INSERT INTO `hc_system_log_info_backup` VALUES (172, 0, 'system.permission.list', 'null', 'GET', 1530265981);
INSERT INTO `hc_system_log_info_backup` VALUES (173, 0, 'system.permission.list', 'null', 'GET', 1530266066);
INSERT INTO `hc_system_log_info_backup` VALUES (174, 0, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530266070);
INSERT INTO `hc_system_log_info_backup` VALUES (175, 0, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530266072);
INSERT INTO `hc_system_log_info_backup` VALUES (176, 0, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267571);
INSERT INTO `hc_system_log_info_backup` VALUES (177, 98, 'system.permission.list', 'null', 'GET', 1530267715);
INSERT INTO `hc_system_log_info_backup` VALUES (178, 98, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530267718);
INSERT INTO `hc_system_log_info_backup` VALUES (179, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267721);
INSERT INTO `hc_system_log_info_backup` VALUES (180, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267765);
INSERT INTO `hc_system_log_info_backup` VALUES (181, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267765);
INSERT INTO `hc_system_log_info_backup` VALUES (182, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267766);
INSERT INTO `hc_system_log_info_backup` VALUES (183, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267769);
INSERT INTO `hc_system_log_info_backup` VALUES (184, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267770);
INSERT INTO `hc_system_log_info_backup` VALUES (185, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267770);
INSERT INTO `hc_system_log_info_backup` VALUES (186, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267771);
INSERT INTO `hc_system_log_info_backup` VALUES (187, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267772);
INSERT INTO `hc_system_log_info_backup` VALUES (188, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267772);
INSERT INTO `hc_system_log_info_backup` VALUES (189, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267807);
INSERT INTO `hc_system_log_info_backup` VALUES (190, 98, 'system.permission.list', '{\"page\":\"0\"}', 'GET', 1530267813);
INSERT INTO `hc_system_log_info_backup` VALUES (191, 98, 'system.permission.list', 'null', 'GET', 1530513147);
INSERT INTO `hc_system_log_info_backup` VALUES (192, 98, 'system.permission.list', 'null', 'GET', 1530528022);
INSERT INTO `hc_system_log_info_backup` VALUES (193, 98, 'system.permission.list', 'null', 'GET', 1530528099);
INSERT INTO `hc_system_log_info_backup` VALUES (194, 98, 'system.permission.list', 'null', 'GET', 1530536029);
INSERT INTO `hc_system_log_info_backup` VALUES (195, 98, 'system.permission.list', 'null', 'GET', 1530536181);
INSERT INTO `hc_system_log_info_backup` VALUES (196, 98, 'system.permission.list', 'null', 'GET', 1530844465);
INSERT INTO `hc_system_log_info_backup` VALUES (197, 98, 'system.permission.list', 'null', 'GET', 1530844511);
INSERT INTO `hc_system_log_info_backup` VALUES (198, 98, 'system.permission.list', 'null', 'GET', 1530844517);
INSERT INTO `hc_system_log_info_backup` VALUES (199, 98, 'system.permission.list', 'null', 'GET', 1530845658);
INSERT INTO `hc_system_log_info_backup` VALUES (200, 98, 'system.permission.list', 'null', 'GET', 1530845881);
INSERT INTO `hc_system_log_info_backup` VALUES (201, 98, 'system.permission.list', 'null', 'GET', 1530845882);
INSERT INTO `hc_system_log_info_backup` VALUES (202, 98, 'system.permission.list', 'null', 'GET', 1530845889);
INSERT INTO `hc_system_log_info_backup` VALUES (203, 98, 'system.permission.list', 'null', 'GET', 1530845897);
INSERT INTO `hc_system_log_info_backup` VALUES (204, 98, 'system.permission.list', 'null', 'GET', 1530845900);
INSERT INTO `hc_system_log_info_backup` VALUES (205, 98, 'system.permission.list', 'null', 'GET', 1530846000);
INSERT INTO `hc_system_log_info_backup` VALUES (206, 98, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1530846005);
INSERT INTO `hc_system_log_info_backup` VALUES (207, 98, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530846009);
INSERT INTO `hc_system_log_info_backup` VALUES (208, 98, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1530846012);
INSERT INTO `hc_system_log_info_backup` VALUES (209, 98, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530846016);
INSERT INTO `hc_system_log_info_backup` VALUES (210, 98, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1530846021);
INSERT INTO `hc_system_log_info_backup` VALUES (211, 98, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530846027);
INSERT INTO `hc_system_log_info_backup` VALUES (212, 98, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530846056);
INSERT INTO `hc_system_log_info_backup` VALUES (213, 98, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530846064);
INSERT INTO `hc_system_log_info_backup` VALUES (214, 98, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1530846067);
INSERT INTO `hc_system_log_info_backup` VALUES (215, 98, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1530846070);
INSERT INTO `hc_system_log_info_backup` VALUES (216, 98, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1530846074);
INSERT INTO `hc_system_log_info_backup` VALUES (217, 98, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1530847413);
INSERT INTO `hc_system_log_info_backup` VALUES (218, 98, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1530847418);
INSERT INTO `hc_system_log_info_backup` VALUES (219, 98, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1530847442);
INSERT INTO `hc_system_log_info_backup` VALUES (220, 98, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1530847463);
INSERT INTO `hc_system_log_info_backup` VALUES (221, 98, 'system.permission.list', 'null', 'GET', 1530851318);
INSERT INTO `hc_system_log_info_backup` VALUES (222, 98, 'system.permission.add', 'null', 'GET', 1530851324);
INSERT INTO `hc_system_log_info_backup` VALUES (223, 98, 'system.permission.list', 'null', 'GET', 1530858721);
INSERT INTO `hc_system_log_info_backup` VALUES (224, 98, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1530858732);
INSERT INTO `hc_system_log_info_backup` VALUES (225, 101, 'system.permission.list', 'null', 'GET', 1536491209);
INSERT INTO `hc_system_log_info_backup` VALUES (226, 101, 'system.permission.add', 'null', 'GET', 1536491253);
INSERT INTO `hc_system_log_info_backup` VALUES (227, 101, 'system.permission.list', 'null', 'GET', 1536563042);
INSERT INTO `hc_system_log_info_backup` VALUES (228, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536563051);
INSERT INTO `hc_system_log_info_backup` VALUES (229, 101, 'system.permission.list', 'null', 'GET', 1536649268);
INSERT INTO `hc_system_log_info_backup` VALUES (230, 101, 'system.permission.list', 'null', 'GET', 1536649904);
INSERT INTO `hc_system_log_info_backup` VALUES (231, 101, 'system.permission.list', 'null', 'GET', 1536649939);
INSERT INTO `hc_system_log_info_backup` VALUES (232, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536649946);
INSERT INTO `hc_system_log_info_backup` VALUES (233, 101, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1536649950);
INSERT INTO `hc_system_log_info_backup` VALUES (234, 101, 'system.permission.list', 'null', 'GET', 1536649997);
INSERT INTO `hc_system_log_info_backup` VALUES (235, 101, 'system.permission.add', 'null', 'GET', 1536650009);
INSERT INTO `hc_system_log_info_backup` VALUES (236, 101, 'system.permission.add', 'null', 'GET', 1536650016);
INSERT INTO `hc_system_log_info_backup` VALUES (237, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.frontmenu.list\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536650042);
INSERT INTO `hc_system_log_info_backup` VALUES (238, 101, 'system.permission.list', 'null', 'GET', 1536650042);
INSERT INTO `hc_system_log_info_backup` VALUES (239, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536650046);
INSERT INTO `hc_system_log_info_backup` VALUES (240, 101, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1536650050);
INSERT INTO `hc_system_log_info_backup` VALUES (241, 101, 'system.permission.add', 'null', 'GET', 1536650054);
INSERT INTO `hc_system_log_info_backup` VALUES (242, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.frontmenu.add\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536650075);
INSERT INTO `hc_system_log_info_backup` VALUES (243, 101, 'system.permission.list', 'null', 'GET', 1536650075);
INSERT INTO `hc_system_log_info_backup` VALUES (244, 101, 'system.permission.list', 'null', 'GET', 1536650279);
INSERT INTO `hc_system_log_info_backup` VALUES (245, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536650286);
INSERT INTO `hc_system_log_info_backup` VALUES (246, 101, 'system.permission.add', 'null', 'GET', 1536650292);
INSERT INTO `hc_system_log_info_backup` VALUES (247, 101, 'system.permission.add', 'null', 'GET', 1536650298);
INSERT INTO `hc_system_log_info_backup` VALUES (248, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.banner.list\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536650315);
INSERT INTO `hc_system_log_info_backup` VALUES (249, 101, 'system.permission.list', 'null', 'GET', 1536650315);
INSERT INTO `hc_system_log_info_backup` VALUES (250, 101, 'system.permission.add', 'null', 'GET', 1536650317);
INSERT INTO `hc_system_log_info_backup` VALUES (251, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.banner.add\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536650329);
INSERT INTO `hc_system_log_info_backup` VALUES (252, 101, 'system.permission.list', 'null', 'GET', 1536650329);
INSERT INTO `hc_system_log_info_backup` VALUES (253, 101, 'system.permission.add', 'null', 'GET', 1536650333);
INSERT INTO `hc_system_log_info_backup` VALUES (254, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.banner.edit\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536650344);
INSERT INTO `hc_system_log_info_backup` VALUES (255, 101, 'system.permission.list', 'null', 'GET', 1536650344);
INSERT INTO `hc_system_log_info_backup` VALUES (256, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536650354);
INSERT INTO `hc_system_log_info_backup` VALUES (257, 101, 'system.permission.add', 'null', 'GET', 1536650363);
INSERT INTO `hc_system_log_info_backup` VALUES (258, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.tag.add\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536650375);
INSERT INTO `hc_system_log_info_backup` VALUES (259, 101, 'system.permission.list', 'null', 'GET', 1536650375);
INSERT INTO `hc_system_log_info_backup` VALUES (260, 101, 'system.permission.add', 'null', 'GET', 1536650380);
INSERT INTO `hc_system_log_info_backup` VALUES (261, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.tag.edit\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536650392);
INSERT INTO `hc_system_log_info_backup` VALUES (262, 101, 'system.permission.list', 'null', 'GET', 1536650392);
INSERT INTO `hc_system_log_info_backup` VALUES (263, 101, 'system.permission.list', 'null', 'GET', 1536650432);
INSERT INTO `hc_system_log_info_backup` VALUES (264, 101, 'system.permission.add', 'null', 'GET', 1536650435);
INSERT INTO `hc_system_log_info_backup` VALUES (265, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.frontmenu.edit\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536650449);
INSERT INTO `hc_system_log_info_backup` VALUES (266, 101, 'system.permission.list', 'null', 'GET', 1536650449);
INSERT INTO `hc_system_log_info_backup` VALUES (267, 101, 'system.permission.list', 'null', 'GET', 1536654642);
INSERT INTO `hc_system_log_info_backup` VALUES (268, 101, 'system.permission.edit', '{\"id\":\"system.frontmenu.add\"}', 'GET', 1536654648);
INSERT INTO `hc_system_log_info_backup` VALUES (269, 101, 'system.permission.edit', '{\"id\":\"system.menu.del\"}', 'GET', 1536654655);
INSERT INTO `hc_system_log_info_backup` VALUES (270, 101, 'system.permission.list', 'null', 'GET', 1536654775);
INSERT INTO `hc_system_log_info_backup` VALUES (271, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536654781);
INSERT INTO `hc_system_log_info_backup` VALUES (272, 101, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1536654785);
INSERT INTO `hc_system_log_info_backup` VALUES (273, 101, 'system.permission.list', 'null', 'GET', 1536655821);
INSERT INTO `hc_system_log_info_backup` VALUES (274, 101, 'system.permission.list', 'null', 'GET', 1536655843);
INSERT INTO `hc_system_log_info_backup` VALUES (275, 101, 'system.permission.list', 'null', 'GET', 1536655887);
INSERT INTO `hc_system_log_info_backup` VALUES (276, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536655903);
INSERT INTO `hc_system_log_info_backup` VALUES (277, 101, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1536655905);
INSERT INTO `hc_system_log_info_backup` VALUES (278, 101, 'system.permission.list', 'null', 'GET', 1536655916);
INSERT INTO `hc_system_log_info_backup` VALUES (279, 99, 'system.permission.list', 'null', 'GET', 1536657558);
INSERT INTO `hc_system_log_info_backup` VALUES (280, 99, 'system.permission.add', 'null', 'GET', 1536657560);
INSERT INTO `hc_system_log_info_backup` VALUES (281, 99, 'system.permission.list', 'null', 'GET', 1536657574);
INSERT INTO `hc_system_log_info_backup` VALUES (282, 99, 'system.permission.list', 'null', 'GET', 1536657576);
INSERT INTO `hc_system_log_info_backup` VALUES (283, 99, 'system.permission.add', 'null', 'GET', 1536657577);
INSERT INTO `hc_system_log_info_backup` VALUES (284, 99, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"shop.product.list\",\"statusRadio\":\"1\",\"title\":\"shop+product+list\"}', 'POST', 1536657609);
INSERT INTO `hc_system_log_info_backup` VALUES (285, 99, 'system.permission.list', 'null', 'GET', 1536657609);
INSERT INTO `hc_system_log_info_backup` VALUES (286, 99, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536657616);
INSERT INTO `hc_system_log_info_backup` VALUES (287, 99, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1536657618);
INSERT INTO `hc_system_log_info_backup` VALUES (288, 101, 'system.permission.list', 'null', 'GET', 1536659717);
INSERT INTO `hc_system_log_info_backup` VALUES (289, 101, 'system.permission.add', 'null', 'GET', 1536659726);
INSERT INTO `hc_system_log_info_backup` VALUES (290, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"portal.menu.del\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536659756);
INSERT INTO `hc_system_log_info_backup` VALUES (291, 101, 'system.permission.list', 'null', 'GET', 1536659756);
INSERT INTO `hc_system_log_info_backup` VALUES (292, 101, 'system.permission.add', 'null', 'GET', 1536659765);
INSERT INTO `hc_system_log_info_backup` VALUES (293, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"portal.banner.del\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536659784);
INSERT INTO `hc_system_log_info_backup` VALUES (294, 101, 'system.permission.list', 'null', 'GET', 1536659784);
INSERT INTO `hc_system_log_info_backup` VALUES (295, 101, 'system.permission.add', 'null', 'GET', 1536659787);
INSERT INTO `hc_system_log_info_backup` VALUES (296, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"tag.tag.del\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536659800);
INSERT INTO `hc_system_log_info_backup` VALUES (297, 101, 'system.permission.list', 'null', 'GET', 1536659800);
INSERT INTO `hc_system_log_info_backup` VALUES (298, 101, 'system.permission.list', 'null', 'GET', 1536660344);
INSERT INTO `hc_system_log_info_backup` VALUES (299, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536660347);
INSERT INTO `hc_system_log_info_backup` VALUES (300, 101, 'system.permission.list', 'null', 'GET', 1536660374);
INSERT INTO `hc_system_log_info_backup` VALUES (301, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536660378);
INSERT INTO `hc_system_log_info_backup` VALUES (302, 101, 'system.permission.edit', '{\"id\":\"tag.tag.del\"}', 'GET', 1536660392);
INSERT INTO `hc_system_log_info_backup` VALUES (303, 99, 'system.permission.list', 'null', 'GET', 1536735007);
INSERT INTO `hc_system_log_info_backup` VALUES (304, 99, 'system.permission.list', 'null', 'GET', 1536735233);
INSERT INTO `hc_system_log_info_backup` VALUES (305, 99, 'system.permission.list', 'null', 'GET', 1536735238);
INSERT INTO `hc_system_log_info_backup` VALUES (306, 99, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536735244);
INSERT INTO `hc_system_log_info_backup` VALUES (307, 99, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536735245);
INSERT INTO `hc_system_log_info_backup` VALUES (308, 99, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536735247);
INSERT INTO `hc_system_log_info_backup` VALUES (309, 99, 'system.permission.list', 'null', 'GET', 1536736556);
INSERT INTO `hc_system_log_info_backup` VALUES (310, 99, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536736558);
INSERT INTO `hc_system_log_info_backup` VALUES (311, 99, 'system.permission.add', 'null', 'GET', 1536736564);
INSERT INTO `hc_system_log_info_backup` VALUES (312, 99, 'system.permission.add', 'null', 'GET', 1536736567);
INSERT INTO `hc_system_log_info_backup` VALUES (313, 99, 'system.permission.list', 'null', 'GET', 1536737669);
INSERT INTO `hc_system_log_info_backup` VALUES (314, 99, 'system.permission.add', 'null', 'GET', 1536737671);
INSERT INTO `hc_system_log_info_backup` VALUES (315, 99, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"eee\",\"statusRadio\":\"1\",\"title\":\"eee\"}', 'POST', 1536737677);
INSERT INTO `hc_system_log_info_backup` VALUES (316, 99, 'system.permission.list', 'null', 'GET', 1536737677);
INSERT INTO `hc_system_log_info_backup` VALUES (317, 99, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536737680);
INSERT INTO `hc_system_log_info_backup` VALUES (318, 99, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1536737682);
INSERT INTO `hc_system_log_info_backup` VALUES (319, 99, 'system.permission.add', '{\"id\":\"3\",\"statusRadio\":\"1\",\"title\":\"4334\"}', 'POST', 1536737791);
INSERT INTO `hc_system_log_info_backup` VALUES (320, 99, 'system.permission.list', 'null', 'GET', 1536737991);
INSERT INTO `hc_system_log_info_backup` VALUES (321, 99, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536737994);
INSERT INTO `hc_system_log_info_backup` VALUES (322, 99, 'system.permission.list', 'null', 'GET', 1536738176);
INSERT INTO `hc_system_log_info_backup` VALUES (323, 99, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536738194);
INSERT INTO `hc_system_log_info_backup` VALUES (324, 99, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536738210);
INSERT INTO `hc_system_log_info_backup` VALUES (325, 99, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536738258);
INSERT INTO `hc_system_log_info_backup` VALUES (326, 99, 'system.permission.list', 'null', 'GET', 1536738656);
INSERT INTO `hc_system_log_info_backup` VALUES (327, 99, 'system.permission.list', 'null', 'GET', 1536739954);
INSERT INTO `hc_system_log_info_backup` VALUES (328, 99, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536739957);
INSERT INTO `hc_system_log_info_backup` VALUES (329, 99, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536739960);
INSERT INTO `hc_system_log_info_backup` VALUES (330, 99, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536739962);
INSERT INTO `hc_system_log_info_backup` VALUES (331, 99, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536739966);
INSERT INTO `hc_system_log_info_backup` VALUES (332, 99, 'system.permission.list', 'null', 'GET', 1536739969);
INSERT INTO `hc_system_log_info_backup` VALUES (333, 99, 'system.permission.list', 'null', 'GET', 1536743408);
INSERT INTO `hc_system_log_info_backup` VALUES (334, 99, 'system.permission.add', 'null', 'GET', 1536743410);
INSERT INTO `hc_system_log_info_backup` VALUES (335, 99, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"shop.product.add\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536743441);
INSERT INTO `hc_system_log_info_backup` VALUES (336, 99, 'system.permission.list', 'null', 'GET', 1536743441);
INSERT INTO `hc_system_log_info_backup` VALUES (337, 99, 'system.permission.list', 'null', 'GET', 1536743447);
INSERT INTO `hc_system_log_info_backup` VALUES (338, 99, 'system.permission.add', 'null', 'GET', 1536743448);
INSERT INTO `hc_system_log_info_backup` VALUES (339, 99, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"shop.produt.edit\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536743457);
INSERT INTO `hc_system_log_info_backup` VALUES (340, 99, 'system.permission.list', 'null', 'GET', 1536743457);
INSERT INTO `hc_system_log_info_backup` VALUES (341, 99, 'system.permission.list', 'null', 'GET', 1536753572);
INSERT INTO `hc_system_log_info_backup` VALUES (342, 99, 'system.permission.edit', '{\"id\":\"shop.produt.edit\"}', 'GET', 1536753577);
INSERT INTO `hc_system_log_info_backup` VALUES (343, 99, 'system.permission.edit', '{\"id\":\"portal.menu.list\"}', 'GET', 1536753582);
INSERT INTO `hc_system_log_info_backup` VALUES (344, 99, 'system.permission.edit', '{\"id\":\"portal.menu.edit\"}', 'GET', 1536753594);
INSERT INTO `hc_system_log_info_backup` VALUES (345, 99, 'system.permission.list', 'null', 'GET', 1536753604);
INSERT INTO `hc_system_log_info_backup` VALUES (346, 99, 'system.permission.list', 'null', 'GET', 1536753680);
INSERT INTO `hc_system_log_info_backup` VALUES (347, 99, 'system.permission.edit', '{\"id\":\"shop.produt.edit\"}', 'GET', 1536753688);
INSERT INTO `hc_system_log_info_backup` VALUES (348, 99, 'system.permission.list', 'null', 'GET', 1536805152);
INSERT INTO `hc_system_log_info_backup` VALUES (349, 99, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536805153);
INSERT INTO `hc_system_log_info_backup` VALUES (350, 99, 'system.permission.add', 'null', 'GET', 1536805160);
INSERT INTO `hc_system_log_info_backup` VALUES (351, 99, 'system.permission.add', '{\"actionRadio\":\"0\",\"id\":\"shop.product.del\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536805177);
INSERT INTO `hc_system_log_info_backup` VALUES (352, 99, 'system.permission.list', 'null', 'GET', 1536805177);
INSERT INTO `hc_system_log_info_backup` VALUES (353, 101, 'system.permission.list', 'null', 'GET', 1536805890);
INSERT INTO `hc_system_log_info_backup` VALUES (354, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536805895);
INSERT INTO `hc_system_log_info_backup` VALUES (355, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536805901);
INSERT INTO `hc_system_log_info_backup` VALUES (356, 101, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1536805904);
INSERT INTO `hc_system_log_info_backup` VALUES (357, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536805908);
INSERT INTO `hc_system_log_info_backup` VALUES (358, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536805914);
INSERT INTO `hc_system_log_info_backup` VALUES (359, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536805918);
INSERT INTO `hc_system_log_info_backup` VALUES (360, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536806001);
INSERT INTO `hc_system_log_info_backup` VALUES (361, 101, 'system.permission.list', 'null', 'GET', 1536806038);
INSERT INTO `hc_system_log_info_backup` VALUES (362, 101, 'system.permission.list', 'null', 'GET', 1536806054);
INSERT INTO `hc_system_log_info_backup` VALUES (363, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536806058);
INSERT INTO `hc_system_log_info_backup` VALUES (364, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536806065);
INSERT INTO `hc_system_log_info_backup` VALUES (365, 101, 'system.permission.add', 'null', 'GET', 1536806067);
INSERT INTO `hc_system_log_info_backup` VALUES (366, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"system.file.upload\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536806083);
INSERT INTO `hc_system_log_info_backup` VALUES (367, 101, 'system.permission.list', 'null', 'GET', 1536806083);
INSERT INTO `hc_system_log_info_backup` VALUES (368, 99, 'system.permission.list', 'null', 'GET', 1536806396);
INSERT INTO `hc_system_log_info_backup` VALUES (369, 99, 'system.permission.edit', '{\"id\":\"shop.product.del\"}', 'GET', 1536806404);
INSERT INTO `hc_system_log_info_backup` VALUES (370, 99, 'system.permission.list', 'null', 'GET', 1536806423);
INSERT INTO `hc_system_log_info_backup` VALUES (371, 101, 'system.permission.list', 'null', 'GET', 1536806871);
INSERT INTO `hc_system_log_info_backup` VALUES (372, 101, 'system.permission.add', 'null', 'GET', 1536806872);
INSERT INTO `hc_system_log_info_backup` VALUES (373, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"article.article.uploadimg\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536806889);
INSERT INTO `hc_system_log_info_backup` VALUES (374, 101, 'system.permission.list', 'null', 'GET', 1536806889);
INSERT INTO `hc_system_log_info_backup` VALUES (375, 99, 'system.permission.list', 'null', 'GET', 1536817679);
INSERT INTO `hc_system_log_info_backup` VALUES (376, 99, 'system.permission.list', 'null', 'GET', 1536817741);
INSERT INTO `hc_system_log_info_backup` VALUES (377, 99, 'system.permission.add', 'null', 'GET', 1536817743);
INSERT INTO `hc_system_log_info_backup` VALUES (378, 99, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"shop.productcategory.list\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536817758);
INSERT INTO `hc_system_log_info_backup` VALUES (379, 99, 'system.permission.list', 'null', 'GET', 1536817758);
INSERT INTO `hc_system_log_info_backup` VALUES (380, 99, 'system.permission.list', 'null', 'GET', 1536818424);
INSERT INTO `hc_system_log_info_backup` VALUES (381, 99, 'system.permission.add', 'null', 'GET', 1536818425);
INSERT INTO `hc_system_log_info_backup` VALUES (382, 99, 'system.permission.list', 'null', 'GET', 1536821746);
INSERT INTO `hc_system_log_info_backup` VALUES (383, 99, 'system.permission.add', 'null', 'GET', 1536821747);
INSERT INTO `hc_system_log_info_backup` VALUES (384, 99, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"shop.productcategory.add\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536821766);
INSERT INTO `hc_system_log_info_backup` VALUES (385, 99, 'system.permission.list', 'null', 'GET', 1536821766);
INSERT INTO `hc_system_log_info_backup` VALUES (386, 99, 'system.permission.add', 'null', 'GET', 1536821792);
INSERT INTO `hc_system_log_info_backup` VALUES (387, 99, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"shop.productcategory.edit\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536821808);
INSERT INTO `hc_system_log_info_backup` VALUES (388, 99, 'system.permission.list', 'null', 'GET', 1536821808);
INSERT INTO `hc_system_log_info_backup` VALUES (389, 99, 'system.permission.add', 'null', 'GET', 1536821813);
INSERT INTO `hc_system_log_info_backup` VALUES (390, 99, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"shop.productcategory.del\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536821822);
INSERT INTO `hc_system_log_info_backup` VALUES (391, 99, 'system.permission.list', 'null', 'GET', 1536821822);
INSERT INTO `hc_system_log_info_backup` VALUES (392, 99, 'system.permission.list', 'null', 'GET', 1536821896);
INSERT INTO `hc_system_log_info_backup` VALUES (393, 99, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536821899);
INSERT INTO `hc_system_log_info_backup` VALUES (394, 99, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1536821904);
INSERT INTO `hc_system_log_info_backup` VALUES (395, 99, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536821906);
INSERT INTO `hc_system_log_info_backup` VALUES (396, 99, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536821929);
INSERT INTO `hc_system_log_info_backup` VALUES (397, 99, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1536821930);
INSERT INTO `hc_system_log_info_backup` VALUES (398, 99, 'system.permission.del', '{\"id\":\"eee\"}', 'GET', 1536821935);
INSERT INTO `hc_system_log_info_backup` VALUES (399, 99, 'system.permission.del', '{\"id\":\"eee\"}', 'GET', 1536821947);
INSERT INTO `hc_system_log_info_backup` VALUES (400, 99, 'system.permission.list', '{\"page\":\"1\"}', 'GET', 1536821956);
INSERT INTO `hc_system_log_info_backup` VALUES (401, 99, 'system.permission.list', 'null', 'GET', 1536821974);
INSERT INTO `hc_system_log_info_backup` VALUES (402, 99, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536821978);
INSERT INTO `hc_system_log_info_backup` VALUES (403, 99, 'system.permission.edit', '{\"id\":\"shop.productcategory.add\"}', 'GET', 1536821983);
INSERT INTO `hc_system_log_info_backup` VALUES (404, 101, 'system.permission.list', 'null', 'GET', 1536828961);
INSERT INTO `hc_system_log_info_backup` VALUES (405, 101, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536828962);
INSERT INTO `hc_system_log_info_backup` VALUES (406, 101, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536828978);
INSERT INTO `hc_system_log_info_backup` VALUES (407, 101, 'system.permission.list', 'null', 'GET', 1536831113);
INSERT INTO `hc_system_log_info_backup` VALUES (408, 101, 'system.permission.edit', '{\"id\":\"article.article.add\"}', 'GET', 1536831116);
INSERT INTO `hc_system_log_info_backup` VALUES (409, 101, 'system.permission.list', 'null', 'GET', 1536831846);
INSERT INTO `hc_system_log_info_backup` VALUES (410, 101, 'system.permission.list', 'null', 'GET', 1536831866);
INSERT INTO `hc_system_log_info_backup` VALUES (411, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536831869);
INSERT INTO `hc_system_log_info_backup` VALUES (412, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536831875);
INSERT INTO `hc_system_log_info_backup` VALUES (413, 101, 'system.permission.list', 'null', 'GET', 1536831882);
INSERT INTO `hc_system_log_info_backup` VALUES (414, 101, 'system.permission.list', 'null', 'GET', 1536831954);
INSERT INTO `hc_system_log_info_backup` VALUES (415, 101, 'system.permission.list', 'null', 'GET', 1536832090);
INSERT INTO `hc_system_log_info_backup` VALUES (416, 101, 'system.permission.list', 'null', 'GET', 1536840526);
INSERT INTO `hc_system_log_info_backup` VALUES (417, 101, 'system.permission.edit', '{\"id\":\"1\"}', 'GET', 1536840528);
INSERT INTO `hc_system_log_info_backup` VALUES (418, 101, 'system.permission.edit', '{\"id\":\"1\"}', 'GET', 1536840598);
INSERT INTO `hc_system_log_info_backup` VALUES (419, 101, 'system.permission.edit', '{\"id\":\"1\"}', 'GET', 1536840598);
INSERT INTO `hc_system_log_info_backup` VALUES (420, 101, 'system.permission.list', 'null', 'GET', 1536840601);
INSERT INTO `hc_system_log_info_backup` VALUES (421, 101, 'system.permission.list', 'null', 'GET', 1536840602);
INSERT INTO `hc_system_log_info_backup` VALUES (422, 101, 'system.permission.edit', '{\"id\":\"1\"}', 'GET', 1536840605);
INSERT INTO `hc_system_log_info_backup` VALUES (423, 101, 'system.permission.list', 'null', 'GET', 1536840831);
INSERT INTO `hc_system_log_info_backup` VALUES (424, 101, 'system.permission.edit', '{\"id\":\"1\"}', 'GET', 1536840832);
INSERT INTO `hc_system_log_info_backup` VALUES (425, 101, 'system.permission.del', '{\"id\":\"10\"}', 'GET', 1536840843);
INSERT INTO `hc_system_log_info_backup` VALUES (426, 101, 'system.permission.del', '{\"id\":\"5\"}', 'GET', 1536840851);
INSERT INTO `hc_system_log_info_backup` VALUES (427, 101, 'system.permission.del', '{\"id\":\"5\"}', 'GET', 1536840910);
INSERT INTO `hc_system_log_info_backup` VALUES (428, 101, 'system.permission.del', '{\"id\":\"5\"}', 'GET', 1536840910);
INSERT INTO `hc_system_log_info_backup` VALUES (429, 101, 'system.permission.del', '{\"id\":\"5\"}', 'GET', 1536840911);
INSERT INTO `hc_system_log_info_backup` VALUES (430, 101, 'system.permission.list', 'null', 'GET', 1536840913);
INSERT INTO `hc_system_log_info_backup` VALUES (431, 101, 'system.permission.list', 'null', 'GET', 1536840914);
INSERT INTO `hc_system_log_info_backup` VALUES (432, 101, 'system.permission.list', 'null', 'GET', 1536840914);
INSERT INTO `hc_system_log_info_backup` VALUES (433, 101, 'system.permission.edit', '{\"id\":\"1\"}', 'GET', 1536840916);
INSERT INTO `hc_system_log_info_backup` VALUES (434, 101, 'system.permission.edit', '{\"id\":\"1\"}', 'GET', 1536841540);
INSERT INTO `hc_system_log_info_backup` VALUES (435, 101, 'system.permission.list', 'null', 'GET', 1536841546);
INSERT INTO `hc_system_log_info_backup` VALUES (436, 101, 'system.permission.edit', '{\"id\":\"2\"}', 'GET', 1536841548);
INSERT INTO `hc_system_log_info_backup` VALUES (437, 101, 'system.permission.edit', '{\"id\":\"1\"}', 'GET', 1536841582);
INSERT INTO `hc_system_log_info_backup` VALUES (438, 101, 'system.permission.list', 'null', 'GET', 1536841933);
INSERT INTO `hc_system_log_info_backup` VALUES (439, 101, 'system.permission.del', '{\"id\":\"5\"}', 'GET', 1536841938);
INSERT INTO `hc_system_log_info_backup` VALUES (440, 101, 'system.permission.list', 'null', 'GET', 1536841938);
INSERT INTO `hc_system_log_info_backup` VALUES (441, 101, 'system.permission.del', '{\"id\":\"10\"}', 'GET', 1536841942);
INSERT INTO `hc_system_log_info_backup` VALUES (442, 101, 'system.permission.list', 'null', 'GET', 1536841942);
INSERT INTO `hc_system_log_info_backup` VALUES (443, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536841945);
INSERT INTO `hc_system_log_info_backup` VALUES (444, 101, 'system.permission.list', '{\"page\":\"2\"}', 'GET', 1536841947);
INSERT INTO `hc_system_log_info_backup` VALUES (445, 99, 'system.permission.list', 'null', 'GET', 1536846246);
INSERT INTO `hc_system_log_info_backup` VALUES (446, 99, 'system.permission.edit', '{\"id\":\"1\"}', 'GET', 1536846250);
INSERT INTO `hc_system_log_info_backup` VALUES (447, 101, 'system.permission.list', 'null', 'GET', 1536919906);
INSERT INTO `hc_system_log_info_backup` VALUES (448, 101, 'system.permission.add', 'null', 'GET', 1536919913);
INSERT INTO `hc_system_log_info_backup` VALUES (449, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"mca\":\"promotion.promotion.list\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536919933);
INSERT INTO `hc_system_log_info_backup` VALUES (450, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"mca\":\"promotion.promotion.list\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536919944);
INSERT INTO `hc_system_log_info_backup` VALUES (451, 101, 'system.permission.list', 'null', 'GET', 1536920129);
INSERT INTO `hc_system_log_info_backup` VALUES (452, 101, 'system.permission.list', 'null', 'GET', 1536920134);
INSERT INTO `hc_system_log_info_backup` VALUES (453, 101, 'system.permission.add', 'null', 'GET', 1536920137);
INSERT INTO `hc_system_log_info_backup` VALUES (454, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"mca\":\"promotion.promotion.list\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536920148);
INSERT INTO `hc_system_log_info_backup` VALUES (455, 101, 'system.permission.list', 'null', 'GET', 1536920148);
INSERT INTO `hc_system_log_info_backup` VALUES (456, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536920151);
INSERT INTO `hc_system_log_info_backup` VALUES (457, 101, 'system.permission.edit', '{\"id\":\"50\"}', 'GET', 1536920160);
INSERT INTO `hc_system_log_info_backup` VALUES (458, 101, 'system.permission.list', 'null', 'GET', 1536920198);
INSERT INTO `hc_system_log_info_backup` VALUES (459, 101, 'system.permission.add', 'null', 'GET', 1536920199);
INSERT INTO `hc_system_log_info_backup` VALUES (460, 101, 'system.permission.add', 'null', 'GET', 1536920277);
INSERT INTO `hc_system_log_info_backup` VALUES (461, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536920281);
INSERT INTO `hc_system_log_info_backup` VALUES (462, 101, 'system.permission.del', '{\"id\":\"50\"}', 'GET', 1536920283);
INSERT INTO `hc_system_log_info_backup` VALUES (463, 101, 'system.permission.list', 'null', 'GET', 1536920283);
INSERT INTO `hc_system_log_info_backup` VALUES (464, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536920285);
INSERT INTO `hc_system_log_info_backup` VALUES (465, 101, 'system.permission.edit', '{\"id\":\"49\"}', 'GET', 1536920287);
INSERT INTO `hc_system_log_info_backup` VALUES (466, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"49\",\"mca\":\"promotion.promotion.list\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536920290);
INSERT INTO `hc_system_log_info_backup` VALUES (467, 101, 'system.permission.list', 'null', 'GET', 1536920290);
INSERT INTO `hc_system_log_info_backup` VALUES (468, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536920292);
INSERT INTO `hc_system_log_info_backup` VALUES (469, 101, 'system.permission.add', 'null', 'GET', 1536920298);
INSERT INTO `hc_system_log_info_backup` VALUES (470, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"mca\":\"promotion.promotion.add\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536920309);
INSERT INTO `hc_system_log_info_backup` VALUES (471, 101, 'system.permission.list', 'null', 'GET', 1536920309);
INSERT INTO `hc_system_log_info_backup` VALUES (472, 101, 'system.permission.add', 'null', 'GET', 1536920312);
INSERT INTO `hc_system_log_info_backup` VALUES (473, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"mca\":\"promotion.promotion.edit\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536920328);
INSERT INTO `hc_system_log_info_backup` VALUES (474, 101, 'system.permission.list', 'null', 'GET', 1536920328);
INSERT INTO `hc_system_log_info_backup` VALUES (475, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536920330);
INSERT INTO `hc_system_log_info_backup` VALUES (476, 101, 'system.permission.list', 'null', 'GET', 1536922455);
INSERT INTO `hc_system_log_info_backup` VALUES (477, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536922459);
INSERT INTO `hc_system_log_info_backup` VALUES (478, 99, 'system.permission.list', 'null', 'GET', 1536922600);
INSERT INTO `hc_system_log_info_backup` VALUES (479, 99, 'system.permission.add', 'null', 'GET', 1536922603);
INSERT INTO `hc_system_log_info_backup` VALUES (480, 99, 'system.permission.add', '{\"actionRadio\":\"1\",\"mca\":\"shop.type.add\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536922643);
INSERT INTO `hc_system_log_info_backup` VALUES (481, 99, 'system.permission.add', '{\"actionRadio\":\"1\",\"mca\":\"shop.type.add\",\"statusRadio\":\"1\",\"title\":\"??????\"}', 'POST', 1536923227);
INSERT INTO `hc_system_log_info_backup` VALUES (482, 99, 'system.permission.add', 'null', 'GET', 1536923229);
INSERT INTO `hc_system_log_info_backup` VALUES (483, 101, 'system.permission.list', 'null', 'GET', 1536923787);
INSERT INTO `hc_system_log_info_backup` VALUES (484, 101, 'system.permission.list', '{\"page\":\"4\"}', 'GET', 1536923791);
INSERT INTO `hc_system_log_info_backup` VALUES (485, 101, 'system.permission.edit', '{\"id\":\"74\"}', 'GET', 1536923801);
INSERT INTO `hc_system_log_info_backup` VALUES (486, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"74\",\"mca\":\"portal.promotion.edit\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536923808);
INSERT INTO `hc_system_log_info_backup` VALUES (487, 101, 'system.permission.list', 'null', 'GET', 1536923809);
INSERT INTO `hc_system_log_info_backup` VALUES (488, 101, 'system.permission.list', '{\"page\":\"4\"}', 'GET', 1536923811);
INSERT INTO `hc_system_log_info_backup` VALUES (489, 101, 'system.permission.edit', '{\"id\":\"75\"}', 'GET', 1536923813);
INSERT INTO `hc_system_log_info_backup` VALUES (490, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"75\",\"mca\":\"portal.promotion.del\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536923818);
INSERT INTO `hc_system_log_info_backup` VALUES (491, 101, 'system.permission.list', 'null', 'GET', 1536923819);
INSERT INTO `hc_system_log_info_backup` VALUES (492, 101, 'system.permission.list', '{\"page\":\"4\"}', 'GET', 1536923821);
INSERT INTO `hc_system_log_info_backup` VALUES (493, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536923825);
INSERT INTO `hc_system_log_info_backup` VALUES (494, 101, 'system.permission.list', '{\"page\":\"4\"}', 'GET', 1536923831);
INSERT INTO `hc_system_log_info_backup` VALUES (495, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536923835);
INSERT INTO `hc_system_log_info_backup` VALUES (496, 101, 'system.permission.list', '{\"page\":\"4\"}', 'GET', 1536923841);
INSERT INTO `hc_system_log_info_backup` VALUES (497, 101, 'system.permission.del', '{\"id\":\"74\"}', 'GET', 1536923845);
INSERT INTO `hc_system_log_info_backup` VALUES (498, 101, 'system.permission.list', 'null', 'GET', 1536923845);
INSERT INTO `hc_system_log_info_backup` VALUES (499, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536923847);
INSERT INTO `hc_system_log_info_backup` VALUES (500, 101, 'system.permission.edit', '{\"id\":\"49\"}', 'GET', 1536923850);
INSERT INTO `hc_system_log_info_backup` VALUES (501, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"49\",\"mca\":\"portal.promotion.list\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536923855);
INSERT INTO `hc_system_log_info_backup` VALUES (502, 101, 'system.permission.list', 'null', 'GET', 1536923856);
INSERT INTO `hc_system_log_info_backup` VALUES (503, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536923857);
INSERT INTO `hc_system_log_info_backup` VALUES (504, 101, 'system.permission.edit', '{\"id\":\"51\"}', 'GET', 1536923860);
INSERT INTO `hc_system_log_info_backup` VALUES (505, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"51\",\"mca\":\"portal.promotion.add\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536923865);
INSERT INTO `hc_system_log_info_backup` VALUES (506, 101, 'system.permission.list', 'null', 'GET', 1536923865);
INSERT INTO `hc_system_log_info_backup` VALUES (507, 101, 'system.permission.list', '{\"page\":\"3\"}', 'GET', 1536923866);
INSERT INTO `hc_system_log_info_backup` VALUES (508, 101, 'system.permission.edit', '{\"id\":\"52\"}', 'GET', 1536923869);
INSERT INTO `hc_system_log_info_backup` VALUES (509, 101, 'system.permission.add', '{\"actionRadio\":\"1\",\"id\":\"52\",\"mca\":\"portal.promotion.edit\",\"statusRadio\":\"1\",\"title\":\"????\"}', 'POST', 1536923874);
INSERT INTO `hc_system_log_info_backup` VALUES (510, 101, 'system.permission.list', 'null', 'GET', 1536923874);
INSERT INTO `hc_system_log_info_backup` VALUES (511, 101, 'system.permission.list', 'null', 'GET', 1536923878);
INSERT INTO `hc_system_log_info_backup` VALUES (512, 101, 'system.permission.list', 'null', 'GET', 1536923884);
INSERT INTO `hc_system_log_info_backup` VALUES (513, 101, 'system.permission.list', 'null', 'GET', 1536923949);
INSERT INTO `hc_system_log_info_backup` VALUES (514, 101, 'system.permission.list', 'null', 'GET', 1536924195);
INSERT INTO `hc_system_log_info_backup` VALUES (515, 101, 'system.permission.list', 'null', 'GET', 1536924747);
INSERT INTO `hc_system_log_info_backup` VALUES (516, 101, 'system.permission.list', 'null', 'GET', 1539077795);
INSERT INTO `hc_system_log_info_backup` VALUES (517, 99, 'system.permission.list', 'null', 'GET', 1545200440);
INSERT INTO `hc_system_log_info_backup` VALUES (518, 1, 'system.permission.list', 'null', 'GET', 1549077788);
INSERT INTO `hc_system_log_info_backup` VALUES (519, 1, 'system.permission.list', 'null', 'GET', 1550225952);
INSERT INTO `hc_system_log_info_backup` VALUES (520, 1, 'system.permission.edit', '{\"id\":\"1\"}', 'GET', 1550225952);

-- ----------------------------
-- Table structure for hc_system_menu
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_menu`;
CREATE TABLE `hc_system_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `icon_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_action` tinyint(1) NULL DEFAULT 0,
  `mca` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `link_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT 0,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_menu
-- ----------------------------
INSERT INTO `hc_system_menu` VALUES (3, 0, 'System', '', 'ti-panel', 0, '', '#', 2, 0, 0, 1);
INSERT INTO `hc_system_menu` VALUES (6, 3, '菜单管理', '', 'ti-menu', 1, 'system.menu.list', '/system/menus', 0, 1530156969, 1530156969, 1);
INSERT INTO `hc_system_menu` VALUES (7, 3, '权限管理', '', 'ti-settings', 1, 'system.permission.list', '/system/permissions', 0, 1530156969, 1530156969, 1);
INSERT INTO `hc_system_menu` VALUES (8, 3, '用户管理', '', 'ti-user', 1, 'system.user.list', '/system/users', 0, 1530156969, 1530156969, 1);
INSERT INTO `hc_system_menu` VALUES (9, 3, '角色管理', '', 'ti-bar-chart', 1, 'system.role.list', '/system/roles', 0, 1530190052, 1530190052, 1);
INSERT INTO `hc_system_menu` VALUES (12, 1, 'Menus', '', '', 1, 'portal.menu.list', '/portal/menu/list', 0, 1536491541, 1536650161, 1);
INSERT INTO `hc_system_menu` VALUES (26, 3, 'Permission Group', '', '', 1, 'system.permissiongroup.list', '/system/permission/groups', 0, 1548668312, 1548668312, 1);
INSERT INTO `hc_system_menu` VALUES (29, 0, '系统管理', '', 'ti-panel', 0, '', '', 0, 1545206026, 1545206026, 1);
INSERT INTO `hc_system_menu` VALUES (36, 3, '语言包管理', '__SYSTEM_MENU_36', '', 1, 'system.langpackage.list', '/language/package', 0, 1557369344, 1558347075, 1);
INSERT INTO `hc_system_menu` VALUES (37, 0, 'Forum', '__SYSTEM_MENU_37', '', 1, 'forum.forum.list', '/forum/list', 0, 1565595785, 1565595785, 1);
INSERT INTO `hc_system_menu` VALUES (38, 37, 'Forums', '__SYSTEM_MENU_38', '', 1, 'forum.forum.list', '/forum/list', 0, 1565595812, 1565690690, 1);
INSERT INTO `hc_system_menu` VALUES (39, 37, 'Threads', '__SYSTEM_MENU_39', '', 1, 'forum.postaudit.list', '/forum/postaudit/list', 0, 1565595980, 1565690746, 1);
INSERT INTO `hc_system_menu` VALUES (40, 0, 'Attachment', '__SYSTEM_MENU_40', '', 1, 'attachment.attachment.list', '/attachment/attachment/list', 10, 1565857864, 1565858029, 1);
INSERT INTO `hc_system_menu` VALUES (41, 40, 'Attachment', '__SYSTEM_MENU_41', '', 1, 'attachment.attachment.list', '/attachment/attachment/list', 0, 1565858222, 1565858222, 1);
INSERT INTO `hc_system_menu` VALUES (43, 0, 'User', '__SYSTEM_MENU_43', '', 1, 'user.user.list', '/user/user/list', 11, 1566462906, 1566469258, 1);
INSERT INTO `hc_system_menu` VALUES (44, 43, 'User', '__SYSTEM_MENU_44', '', 1, 'user.user.list', '/user/user/list', 0, 1566469555, 1566469555, 1);
INSERT INTO `hc_system_menu` VALUES (45, 3, '语言包管理', '__SYSTEM_MENU_45', '', 1, 'system.langpackage.list', '/language/package', 0, 1577670625, 1577670625, 1);

-- ----------------------------
-- Table structure for hc_system_menu_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_menu_backup`;
CREATE TABLE `hc_system_menu_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icon_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_action` tinyint(1) NULL DEFAULT 0,
  `mca` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `link_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT 0,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_menu_backup
-- ----------------------------
INSERT INTO `hc_system_menu_backup` VALUES (1, 0, 'Portal', '', 0, '', '', 5, 1530015141, 1536635587, 1);
INSERT INTO `hc_system_menu_backup` VALUES (2, 0, 'Article', 'ti-widget', 0, '', '', 1, 1530015141, 1530068152, 1);
INSERT INTO `hc_system_menu_backup` VALUES (3, 0, 'System', 'ti-panel', 0, NULL, '#', 2, 0, 0, 1);
INSERT INTO `hc_system_menu_backup` VALUES (4, 2, 'Articles', '', 1, 'article.article.list', '/article/articles', 1, 0, 1530157016, 1);
INSERT INTO `hc_system_menu_backup` VALUES (5, 2, 'Categories', '', 1, 'article.category.list', '/article/categories', 0, 1530156969, 1530156969, 1);
INSERT INTO `hc_system_menu_backup` VALUES (6, 3, 'Menus', NULL, 1, 'system.menu.list', '/system/menus', 0, 1530156969, 1530156969, 1);
INSERT INTO `hc_system_menu_backup` VALUES (7, 3, 'Permissions', NULL, 1, 'system.permission.list', '/system/permissions', 0, 1530156969, 1530156969, 1);
INSERT INTO `hc_system_menu_backup` VALUES (8, 3, 'Users', NULL, 1, 'system.user.list', '/system/users', 0, 1530156969, 1530156969, 1);
INSERT INTO `hc_system_menu_backup` VALUES (9, 3, 'Role', '', 1, 'system.role.list', '/system/roles', 0, 1530190052, 1530190052, 1);
INSERT INTO `hc_system_menu_backup` VALUES (10, 0, 'Tag', '', 1, 'tag.tag.list', '/tag/tag/list', 6, 1536491406, 1536655546, 1);
INSERT INTO `hc_system_menu_backup` VALUES (11, 1, 'Banners', '', 1, 'portal.banner.list', '/portal/banners', 6, 1536491500, 1536650173, 1);
INSERT INTO `hc_system_menu_backup` VALUES (12, 1, 'Menus', '', 1, 'portal.menu.list', '/portal/menu/list', 0, 1536491541, 1536650161, 1);
INSERT INTO `hc_system_menu_backup` VALUES (13, 10, 'Tags', '', 1, 'tag.tag.list', '/tag/tag/list', 1, 1536656572, 1536656572, 1);
INSERT INTO `hc_system_menu_backup` VALUES (14, 0, 'Shop', '', 0, NULL, '#', 0, 1536657181, 1536657357, 1);
INSERT INTO `hc_system_menu_backup` VALUES (15, 14, 'Product', '', 1, 'shop.product.list', '/shop/products', 0, 1536657288, 1536657677, 1);
INSERT INTO `hc_system_menu_backup` VALUES (16, 14, 'ProductCategory', '', 1, 'shop.productcategory.list', '/shop/productcategorys', 2, 1536817673, 1536817708, 1);
INSERT INTO `hc_system_menu_backup` VALUES (18, 1, 'Promotions', '', 1, 'portal.promotion.list', '/portal/promotions', 1, 1536922252, 1536924790, 1);
INSERT INTO `hc_system_menu_backup` VALUES (19, 14, 'Type', '', 1, 'shop.type.list', '/shop/types', 0, 1536922355, 1536922355, 1);
INSERT INTO `hc_system_menu_backup` VALUES (21, 14, 'Properties', '', 1, 'shop.property.list', '/shop/properties', 0, 1536922417, 1536922417, 1);
INSERT INTO `hc_system_menu_backup` VALUES (22, 14, 'PropertyOptions', '', 1, 'shop.propertyoption.list', '/shop/propertyoptions', 0, 1536922477, 1536922477, 1);
INSERT INTO `hc_system_menu_backup` VALUES (23, 14, 'Typeproperties', '', 1, 'shop.typerelationproperty.list', '/shop/typeproperties', 0, 1536922561, 1536922561, 1);
INSERT INTO `hc_system_menu_backup` VALUES (24, 14, 'Typefilter', '', 1, 'shop.typefilter.list', '/shop/typefilters', 0, 1536922592, 1536922592, 1);
INSERT INTO `hc_system_menu_backup` VALUES (25, 0, 'Comment', '', 1, 'comment.comment.list', '/comment/comments', 14, 1540544497, 1540544497, 1);
INSERT INTO `hc_system_menu_backup` VALUES (26, 3, 'Permission Group', '', 1, 'system.permissiongroup.list', '/system/permission/groups', 0, 1548668312, 1548668312, 1);

-- ----------------------------
-- Table structure for hc_system_permission
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_permission`;
CREATE TABLE `hc_system_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mca` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `group_id` int(11) NOT NULL DEFAULT 1,
  `is_action` tinyint(1) NOT NULL DEFAULT 0,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_permission
-- ----------------------------
INSERT INTO `hc_system_permission` VALUES (1, 'system.file.upload', '文件上传', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (2, 'system.log.del', '删除日志', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (3, 'system.log.list', '查看历史', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (4, 'system.menu.add', '添加菜单', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (5, 'system.menu.del', '删除菜单', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (6, 'system.menu.edit', '编辑菜单', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (7, 'system.menu.list', '菜单列表', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (8, 'system.permission.add', '添加权限', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (9, 'system.permission.del', '删除权限', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (10, 'system.permission.edit', '编辑权限', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (11, 'system.permission.list', '权限列表', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (12, 'system.role.add', '添加角色', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (13, 'system.role.del', '删除角色', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (14, 'system.role.edit', '编辑角色', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (15, 'system.role.list', '角色列表', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (16, 'system.user.add', '添加用户', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (17, 'system.user.del', '删除用户', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (18, 'system.user.edit', '编辑用户', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (19, 'system.user.list', '用户列表', 1, 0, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (20, 'system.user.profile', '个人信息', 1, 1, 1545206466, 1545206466, 1);
INSERT INTO `hc_system_permission` VALUES (31, 'portal.banner.list', 'Banner管理', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (32, 'portal.banner.add', 'Banner添加', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (33, 'portal.banner.edit', 'Banner编辑', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (34, 'portal.banner.del', 'Banner删除', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (35, 'article.article.add', 'add article', 1, 0, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (36, 'article.article.del', '删除 文章', 1, 0, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (37, 'article.article.edit', '编辑文章', 1, 0, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (38, 'article.article.list', '文章列表', 1, 0, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (39, 'article.category.add', '添加分类', 1, 0, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (40, 'article.category.del', '删除分类', 1, 0, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (41, 'article.category.edit', '编辑分类', 1, 0, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (42, 'article.category.list', '分类列表', 1, 0, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (55, 'tag.tag.add', '标签添加', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (56, 'tag.tag.del', '删除标签', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (57, 'tag.tag.edit', '标签编辑', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (58, 'tag.tag.list', '标签列表', 1, 1, 1546435893, 1546435893, 1);
INSERT INTO `hc_system_permission` VALUES (84, 'system.permissiongroup.list', '权限组列表', 1, 1, 1548668312, 1548668312, 1);
INSERT INTO `hc_system_permission` VALUES (85, 'system.permissiongroup.add', '添加用户组', 2, 1, 1548668701, 1548670493, 1);
INSERT INTO `hc_system_permission` VALUES (86, 'system.langpackage.list', '语言包列表页', 2, 1, 1557221102, 1557221102, 1);
INSERT INTO `hc_system_permission` VALUES (87, 'system.langpackage.add', '语言包添加', 2, 1, 1557369210, 1557369210, 1);
INSERT INTO `hc_system_permission` VALUES (88, 'system.langpackage.edit', '语言包编辑', 2, 1, 1557369233, 1557369233, 1);
INSERT INTO `hc_system_permission` VALUES (89, 'system.langpackage.del', '语言包删除', 2, 1, 1557369252, 1557369252, 1);
INSERT INTO `hc_system_permission` VALUES (90, 'system.permissiongroup.edit', '权限组编辑', 2, 1, 1565593811, 1565593811, 1);
INSERT INTO `hc_system_permission` VALUES (91, 'forum.forum.list', '版面管理', 1, 1, 1565606073, 1565606073, 1);
INSERT INTO `hc_system_permission` VALUES (92, 'forum.postaudit.list', '审核管理', 1, 1, 1565610893, 1565610893, 1);
INSERT INTO `hc_system_permission` VALUES (93, 'forum.forum.add', '添加', 1, 1, 1565677680, 1565677680, 1);
INSERT INTO `hc_system_permission` VALUES (94, 'forum.forum.del', '删除', 1, 1, 1565677869, 1565677869, 1);
INSERT INTO `hc_system_permission` VALUES (95, 'forum.forum.del', '删除', 1, 1, 1565682378, 1565682378, 1);
INSERT INTO `hc_system_permission` VALUES (96, 'forum.forum.edit', '修改', 1, 1, 1565687843, 1565687843, 1);
INSERT INTO `hc_system_permission` VALUES (97, 'portal.menu.list', '菜单', 1, 1, 1565748426, 1565748426, 1);
INSERT INTO `hc_system_permission` VALUES (98, 'form.postaudit.audit', 'edit', 0, 1, 1565753705, 1565753705, 1);
INSERT INTO `hc_system_permission` VALUES (99, 'forum.postaudit.audit', 'edit', 1, 1, 1565753755, 1565753755, 1);
INSERT INTO `hc_system_permission` VALUES (100, 'forum.postaudit.del', 'del', 1, 1, 1565771425, 1565771425, 1);
INSERT INTO `hc_system_permission` VALUES (101, 'forum.forum.list1', 'Parent node', 1, 1, 1565772942, 1565772942, 1);
INSERT INTO `hc_system_permission` VALUES (102, 'forum.postaudit.doAudit', '执行审核', 1, 1, 1565853176, 1565853176, 1);
INSERT INTO `hc_system_permission` VALUES (103, 'attachment.attachment.list', 'attach', 1, 1, 1565858096, 1565858096, 1);
INSERT INTO `hc_system_permission` VALUES (104, 'forum.forum.list2', '三级', 1, 1, 1565864758, 1565864758, 1);
INSERT INTO `hc_system_permission` VALUES (105, 'attachment.attachment.doAudit', '审核管理', 1, 1, 1565935444, 1565935444, 1);
INSERT INTO `hc_system_permission` VALUES (106, 'attachment.attachment.del', '附件删除', 1, 1, 1566207324, 1566207324, 1);
INSERT INTO `hc_system_permission` VALUES (107, 'attachment.attachment.audit', '附件审核', 1, 1, 1566209507, 1566209507, 1);
INSERT INTO `hc_system_permission` VALUES (108, 'user.user.list', 'Users', 1, 1, 1566463208, 1566463208, 1);
INSERT INTO `hc_system_permission` VALUES (109, 'user.user.detailed', 'detailed', 1, 1, 1566470230, 1566470230, 1);
INSERT INTO `hc_system_permission` VALUES (110, 'user.user.list', 'fourm user list', 1, 1, 1574079552, 1574079598, 1);
INSERT INTO `hc_system_permission` VALUES (111, 'user.user.detailed', 'forum user detail', 1, 1, 1574079586, 1574079586, 1);

-- ----------------------------
-- Table structure for hc_system_permission_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_permission_backup`;
CREATE TABLE `hc_system_permission_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mca` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `is_action` tinyint(1) NOT NULL DEFAULT 0,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_permission_backup
-- ----------------------------
INSERT INTO `hc_system_permission_backup` VALUES (1, 'article.article.add', 'add article', 1, 0, 0, 1530255142, 1);
INSERT INTO `hc_system_permission_backup` VALUES (2, 'article.article.del', '删除 文章', 1, 0, 0, 1530255338, 1);
INSERT INTO `hc_system_permission_backup` VALUES (3, 'article.article.edit', '编辑文章', 1, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (4, 'article.article.list', '文章列表', 1, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (5, 'article.category.add', '添加分类', 1, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (6, 'article.category.del', '删除分类', 1, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (7, 'article.category.edit', '编辑分类', 1, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (8, 'article.category.list', '分类列表', 1, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (9, 'portal.banner.add', '横幅添加', 1, 1, 1536650329, 1536650329, 1);
INSERT INTO `hc_system_permission_backup` VALUES (10, 'portal.banner.del', '删除横幅', 1, 1, 1536659784, 1536659784, 1);
INSERT INTO `hc_system_permission_backup` VALUES (11, 'portal.banner.edit', '横幅编辑', 1, 1, 1536650344, 1536650344, 1);
INSERT INTO `hc_system_permission_backup` VALUES (12, 'portal.banner.list', '横幅列表', 1, 1, 1536650315, 1536650315, 1);
INSERT INTO `hc_system_permission_backup` VALUES (13, 'portal.menu.add', '前端菜单添加', 1, 1, 1536650075, 1536650075, 1);
INSERT INTO `hc_system_permission_backup` VALUES (14, 'portal.menu.del', '删除前端菜单', 1, 1, 1536659756, 1536659756, 1);
INSERT INTO `hc_system_permission_backup` VALUES (15, 'portal.menu.edit', '前端菜单编辑', 1, 1, 1536650449, 1536650449, 1);
INSERT INTO `hc_system_permission_backup` VALUES (16, 'portal.menu.list', '前端菜单列表', 1, 1, 1536650042, 1536650042, 1);
INSERT INTO `hc_system_permission_backup` VALUES (17, 'shop.product.add', '添加商城商品', 1, 1, 1536743441, 1536743441, 1);
INSERT INTO `hc_system_permission_backup` VALUES (18, 'shop.product.del', '删除商城商品', 1, 1, 1536805177, 1536805177, 1);
INSERT INTO `hc_system_permission_backup` VALUES (19, 'shop.product.edit', '修改商城商品', 1, 1, 1536743457, 1536743457, 1);
INSERT INTO `hc_system_permission_backup` VALUES (20, 'shop.product.list', '产品列表', 1, 0, 1536657609, 1536657609, 1);
INSERT INTO `hc_system_permission_backup` VALUES (21, 'shop.productcategory.add', '添加商品分类', 1, 1, 1536821766, 1536821766, 1);
INSERT INTO `hc_system_permission_backup` VALUES (22, 'shop.productcategory.del', '删除商品分类', 1, 1, 1536821822, 1536821822, 1);
INSERT INTO `hc_system_permission_backup` VALUES (23, 'shop.productcategory.edit', '修改商品分类', 1, 1, 1536821808, 1536821808, 1);
INSERT INTO `hc_system_permission_backup` VALUES (24, 'shop.productcategory.list', '商城商品分类', 1, 1, 1536817758, 1536817758, 1);
INSERT INTO `hc_system_permission_backup` VALUES (25, 'system.file.upload', '文件上传', 2, 1, 1536806083, 1536806083, 1);
INSERT INTO `hc_system_permission_backup` VALUES (26, 'system.log.del', '删除日志', 2, 1, 1530168791, 1530168791, 1);
INSERT INTO `hc_system_permission_backup` VALUES (27, 'system.log.list', '查看历史', 2, 1, 1530168711, 1530168711, 1);
INSERT INTO `hc_system_permission_backup` VALUES (28, 'system.menu.add', '添加菜单', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (29, 'system.menu.del', '删除菜单', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (30, 'system.menu.edit', '编辑菜单', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (31, 'system.menu.list', '菜单列表', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (32, 'system.permission.add', '添加权限', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (33, 'system.permission.del', '删除权限', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (34, 'system.permission.edit', '编辑权限', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (35, 'system.permission.list', '权限列表', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (36, 'system.role.add', '添加角色', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (37, 'system.role.del', '删除角色', 2, 0, 0, 1530239428, 1);
INSERT INTO `hc_system_permission_backup` VALUES (38, 'system.role.edit', '编辑角色', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (39, 'system.role.list', '角色列表', 2, 0, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (40, 'system.user.add', '添加用户', 2, 1, 1530081865, 1530081865, 1);
INSERT INTO `hc_system_permission_backup` VALUES (41, 'system.user.del', '删除用户', 2, 0, 1530081889, 1530081889, 1);
INSERT INTO `hc_system_permission_backup` VALUES (42, 'system.user.edit', '编辑用户', 2, 1, 1530069250, 1530069250, 1);
INSERT INTO `hc_system_permission_backup` VALUES (43, 'system.user.list', '用户列表', 2, 0, 1530065709, 1530065836, 1);
INSERT INTO `hc_system_permission_backup` VALUES (44, 'system.user.profile', '个人信息', 2, 1, 1530186832, 1530186832, 1);
INSERT INTO `hc_system_permission_backup` VALUES (45, 'tag.tag.add', '标签添加', 1, 1, 1536650375, 1536650375, 1);
INSERT INTO `hc_system_permission_backup` VALUES (46, 'tag.tag.del', '删除标签', 1, 1, 1536659800, 1536659800, 1);
INSERT INTO `hc_system_permission_backup` VALUES (47, 'tag.tag.edit', '标签编辑', 1, 1, 1536650392, 1536650392, 1);
INSERT INTO `hc_system_permission_backup` VALUES (48, 'tag.tag.list', '标签列表', 1, 1, 0, 0, 1);
INSERT INTO `hc_system_permission_backup` VALUES (49, 'portal.promotion.list', '推荐列表', 1, 1, 1536920084, 1536923856, 1);
INSERT INTO `hc_system_permission_backup` VALUES (51, 'portal.promotion.add', '推荐添加', 1, 1, 1536920309, 1536923865, 1);
INSERT INTO `hc_system_permission_backup` VALUES (52, 'portal.promotion.edit', '推荐编辑', 1, 1, 1536920328, 1536923874, 1);
INSERT INTO `hc_system_permission_backup` VALUES (53, 'shop.type.add', '添加商品分类类别', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (54, 'shop.type.edit', '修改商品分类类别', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (55, 'shop.type.del', '删除商品分类类别', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (56, 'shop.property.list', '商品分类类别列表', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (57, 'shop.property.list', '商品属性列表', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (58, 'shop.property.add', '添加商品属性配置', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (59, 'shop.property.edit', '修改商品属性配置', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (60, 'shop.property.del', '删除商品属性配置', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (61, 'shop.propertyoption.list', '商品属性值列表', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (62, 'shop.propertyoption.add', '添加商品属性值', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (63, 'shop.propertyoption.edit', '修改商品属性值', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (64, 'shop.propertyoption.del', '删除商品属性值', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (65, 'shop.typerelationproperty.list', '类别关联属性列表', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (66, 'shop.typerelationproperty.add', '添加类别关联属性', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (67, 'shop.typerelationproperty.edit', '修改类别关联属性', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (68, 'shop.typerelationproperty.del', '删除类别关联属性', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (69, 'shop.typerelationproperty.listByType', '类别关联属性查询接口', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (70, 'shop.typefilter.list', '筛选器配置列表', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (71, 'shop.typefilter.add', '添加筛选器配置', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (72, 'shop.typefilter.edit', '修改筛选器配置', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (73, 'shop.typefilter.del', '删除筛选器配置', 1, 1, 1536920328, 1536920328, 1);
INSERT INTO `hc_system_permission_backup` VALUES (75, 'portal.promotion.del', '推荐删除', 1, 1, 1536920148, 1536923818, 1);
INSERT INTO `hc_system_permission_backup` VALUES (76, 'system.permissiongroup.list', '权限组列表', 1, 1, 1548668312, 1548668312, 1);
INSERT INTO `hc_system_permission_backup` VALUES (77, 'system.permissiongroup.add', '添加用户组', 2, 1, 1548668701, 1548670493, 1);

-- ----------------------------
-- Table structure for hc_system_permission_group
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_permission_group`;
CREATE TABLE `hc_system_permission_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '中文显示名',
  `sign` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '英文标识组',
  `sort` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_permission_group
-- ----------------------------
INSERT INTO `hc_system_permission_group` VALUES (1, '未分组权限', 'no_group', 1, 1, 1548668701, 1548668701);
INSERT INTO `hc_system_permission_group` VALUES (2, '系统权限', 'system', 1, 1, 1548668701, 1548668701);

-- ----------------------------
-- Table structure for hc_system_role
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_role`;
CREATE TABLE `hc_system_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_role
-- ----------------------------
INSERT INTO `hc_system_role` VALUES (1, '超级管理员', 0, 0, 1);
INSERT INTO `hc_system_role` VALUES (2, '管理员', 0, 0, 1);
INSERT INTO `hc_system_role` VALUES (3, '内容编辑', 0, 0, 1);
INSERT INTO `hc_system_role` VALUES (4, '功能测试', 0, 0, 1);

-- ----------------------------
-- Table structure for hc_system_role_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_role_backup`;
CREATE TABLE `hc_system_role_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_role_backup
-- ----------------------------
INSERT INTO `hc_system_role_backup` VALUES (1, 'teste', 0, 0, 1);
INSERT INTO `hc_system_role_backup` VALUES (2, 'Operator', 0, 0, 0);
INSERT INTO `hc_system_role_backup` VALUES (3, 'Editor', 0, 0, 1);
INSERT INTO `hc_system_role_backup` VALUES (4, 'test', 1530191402, 1530191402, 1);
INSERT INTO `hc_system_role_backup` VALUES (5, 'fdsf', 1530251695, 1530251695, 1);

-- ----------------------------
-- Table structure for hc_system_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_role_permission`;
CREATE TABLE `hc_system_role_permission`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NULL DEFAULT NULL,
  `permission_mca` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1880 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_role_permission
-- ----------------------------
INSERT INTO `hc_system_role_permission` VALUES (1819, 1, 12, '');
INSERT INTO `hc_system_role_permission` VALUES (1820, 1, 107, '');
INSERT INTO `hc_system_role_permission` VALUES (1821, 1, 99, '');
INSERT INTO `hc_system_role_permission` VALUES (1822, 1, 38, '');
INSERT INTO `hc_system_role_permission` VALUES (1823, 1, 41, '');
INSERT INTO `hc_system_role_permission` VALUES (1824, 1, 58, '');
INSERT INTO `hc_system_role_permission` VALUES (1825, 1, 34, '');
INSERT INTO `hc_system_role_permission` VALUES (1826, 1, 36, '');
INSERT INTO `hc_system_role_permission` VALUES (1827, 1, 7, '');
INSERT INTO `hc_system_role_permission` VALUES (1828, 1, 89, '');
INSERT INTO `hc_system_role_permission` VALUES (1829, 1, 13, '');
INSERT INTO `hc_system_role_permission` VALUES (1830, 1, 32, '');
INSERT INTO `hc_system_role_permission` VALUES (1831, 1, 39, '');
INSERT INTO `hc_system_role_permission` VALUES (1832, 1, 33, '');
INSERT INTO `hc_system_role_permission` VALUES (1833, 1, 91, '');
INSERT INTO `hc_system_role_permission` VALUES (1834, 1, 101, '');
INSERT INTO `hc_system_role_permission` VALUES (1835, 1, 102, '');
INSERT INTO `hc_system_role_permission` VALUES (1836, 1, 55, '');
INSERT INTO `hc_system_role_permission` VALUES (1837, 1, 105, '');
INSERT INTO `hc_system_role_permission` VALUES (1838, 1, 18, '');
INSERT INTO `hc_system_role_permission` VALUES (1839, 1, 10, '');
INSERT INTO `hc_system_role_permission` VALUES (1840, 1, 94, '');
INSERT INTO `hc_system_role_permission` VALUES (1841, 1, 20, '');
INSERT INTO `hc_system_role_permission` VALUES (1842, 1, 17, '');
INSERT INTO `hc_system_role_permission` VALUES (1843, 1, 4, '');
INSERT INTO `hc_system_role_permission` VALUES (1844, 1, 1, '');
INSERT INTO `hc_system_role_permission` VALUES (1845, 1, 40, '');
INSERT INTO `hc_system_role_permission` VALUES (1846, 1, 103, '');
INSERT INTO `hc_system_role_permission` VALUES (1847, 1, 90, '');
INSERT INTO `hc_system_role_permission` VALUES (1848, 1, 19, '');
INSERT INTO `hc_system_role_permission` VALUES (1849, 1, 35, '');
INSERT INTO `hc_system_role_permission` VALUES (1850, 1, 93, '');
INSERT INTO `hc_system_role_permission` VALUES (1851, 1, 92, '');
INSERT INTO `hc_system_role_permission` VALUES (1852, 1, 100, '');
INSERT INTO `hc_system_role_permission` VALUES (1853, 1, 5, '');
INSERT INTO `hc_system_role_permission` VALUES (1854, 1, 85, '');
INSERT INTO `hc_system_role_permission` VALUES (1855, 1, 2, '');
INSERT INTO `hc_system_role_permission` VALUES (1856, 1, 97, '');
INSERT INTO `hc_system_role_permission` VALUES (1857, 1, 9, '');
INSERT INTO `hc_system_role_permission` VALUES (1858, 1, 8, '');
INSERT INTO `hc_system_role_permission` VALUES (1859, 1, 37, '');
INSERT INTO `hc_system_role_permission` VALUES (1860, 1, 108, '');
INSERT INTO `hc_system_role_permission` VALUES (1861, 1, 96, '');
INSERT INTO `hc_system_role_permission` VALUES (1862, 1, 3, '');
INSERT INTO `hc_system_role_permission` VALUES (1863, 1, 42, '');
INSERT INTO `hc_system_role_permission` VALUES (1864, 1, 104, '');
INSERT INTO `hc_system_role_permission` VALUES (1865, 1, 6, '');
INSERT INTO `hc_system_role_permission` VALUES (1866, 1, 86, '');
INSERT INTO `hc_system_role_permission` VALUES (1867, 1, 11, '');
INSERT INTO `hc_system_role_permission` VALUES (1868, 1, 87, '');
INSERT INTO `hc_system_role_permission` VALUES (1869, 1, 95, '');
INSERT INTO `hc_system_role_permission` VALUES (1870, 1, 57, '');
INSERT INTO `hc_system_role_permission` VALUES (1871, 1, 31, '');
INSERT INTO `hc_system_role_permission` VALUES (1872, 1, 56, '');
INSERT INTO `hc_system_role_permission` VALUES (1873, 1, 15, '');
INSERT INTO `hc_system_role_permission` VALUES (1874, 1, 88, '');
INSERT INTO `hc_system_role_permission` VALUES (1875, 1, 14, '');
INSERT INTO `hc_system_role_permission` VALUES (1876, 1, 84, '');
INSERT INTO `hc_system_role_permission` VALUES (1877, 1, 109, '');
INSERT INTO `hc_system_role_permission` VALUES (1878, 1, 16, '');
INSERT INTO `hc_system_role_permission` VALUES (1879, 1, 106, '');

-- ----------------------------
-- Table structure for hc_system_role_permission_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_role_permission_backup`;
CREATE TABLE `hc_system_role_permission_backup`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NULL DEFAULT NULL,
  `permission_mca` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 591 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_role_permission_backup
-- ----------------------------
INSERT INTO `hc_system_role_permission_backup` VALUES (8, 4, 1, 'article.article.add');
INSERT INTO `hc_system_role_permission_backup` VALUES (9, 4, 2, 'article.article.del');
INSERT INTO `hc_system_role_permission_backup` VALUES (10, 4, 41, 'system.user.del');
INSERT INTO `hc_system_role_permission_backup` VALUES (11, 4, 30, 'system.menu.edit');
INSERT INTO `hc_system_role_permission_backup` VALUES (12, 4, 29, 'system.menu.del');
INSERT INTO `hc_system_role_permission_backup` VALUES (13, 4, 42, 'system.user.edit');
INSERT INTO `hc_system_role_permission_backup` VALUES (14, 5, 1, 'article.article.add');
INSERT INTO `hc_system_role_permission_backup` VALUES (15, 5, 28, 'system.menu.add');
INSERT INTO `hc_system_role_permission_backup` VALUES (16, 5, 40, 'system.user.add');
INSERT INTO `hc_system_role_permission_backup` VALUES (21, 1, 28, 'system.menu.add');
INSERT INTO `hc_system_role_permission_backup` VALUES (516, 3, 63, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (517, 3, 52, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (518, 3, 12, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (519, 3, 28, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (520, 3, 38, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (521, 3, 41, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (522, 3, 58, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (523, 3, 25, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (524, 3, 76, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (525, 3, 71, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (526, 3, 34, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (527, 3, 48, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (528, 3, 36, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (529, 3, 59, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (530, 3, 7, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (531, 3, 68, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (532, 3, 13, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (533, 3, 32, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (534, 3, 39, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (535, 3, 33, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (536, 3, 26, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (537, 3, 55, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (538, 3, 10, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (539, 3, 49, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (540, 3, 18, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (541, 3, 20, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (542, 3, 17, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (543, 3, 4, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (544, 3, 1, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (545, 3, 40, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (546, 3, 66, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (547, 3, 77, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (548, 3, 19, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (549, 3, 69, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (550, 3, 54, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (551, 3, 61, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (552, 3, 35, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (553, 3, 46, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (554, 3, 5, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (555, 3, 23, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (556, 3, 2, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (557, 3, 30, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (558, 3, 9, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (559, 3, 44, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (560, 3, 21, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (561, 3, 8, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (562, 3, 37, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (563, 3, 75, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (564, 3, 51, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (565, 3, 42, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (566, 3, 60, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (567, 3, 3, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (568, 3, 29, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (569, 3, 6, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (570, 3, 65, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (571, 3, 11, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (572, 3, 27, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (573, 3, 45, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (574, 3, 57, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (575, 3, 31, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (576, 3, 56, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (577, 3, 15, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (578, 3, 24, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (579, 3, 73, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (580, 3, 67, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (581, 3, 14, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (582, 3, 72, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (583, 3, 64, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (584, 3, 43, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (585, 3, 53, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (586, 3, 16, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (587, 3, 70, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (588, 3, 22, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (589, 3, 47, '');
INSERT INTO `hc_system_role_permission_backup` VALUES (590, 3, 62, '');

-- ----------------------------
-- Table structure for hc_system_setting
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_setting`;
CREATE TABLE `hc_system_setting`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `explain` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `deleted` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'system setting' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_setting
-- ----------------------------
INSERT INTO `hc_system_setting` VALUES (1, 'github.appid5', '9fdee5ef1f78648be7fb111', 1576809722, 1577270847, 'github', 1);
INSERT INTO `hc_system_setting` VALUES (2, '2222', '3333', 1577263101, 1577270615, 'demo', 1);
INSERT INTO `hc_system_setting` VALUES (3, 'github.appid', '9fdee5ef1f78648be7fb', 1577272059, 1577441739, 'Github Oauth Appid', 0);
INSERT INTO `hc_system_setting` VALUES (4, 'github.secret', '3cd61eb06a89a3a5741a7e1eb49e581a9ff8fb84', 1577272128, 1577441740, 'Github Oauth Secret', 0);
INSERT INTO `hc_system_setting` VALUES (5, 'github.access_token_url', 'https://github.com/login/oauth/access_token', 1577273767, 1577441741, 'Github Oauth Token Url', 0);
INSERT INTO `hc_system_setting` VALUES (6, 'github.user_info_url', 'https://api.github.com/user?access_token=', 1577273833, 1577441743, 'Github Oauth User Info URL', 0);
INSERT INTO `hc_system_setting` VALUES (7, 'mail.smtp.protocol', 'smtps', 1577437231, 1577441744, 'mail.smtp.protocol', 0);
INSERT INTO `hc_system_setting` VALUES (8, 'mail.smtp.host', 'smtp.putao.com', 1577437294, 1577441746, 'mail.smtp.host', 0);
INSERT INTO `hc_system_setting` VALUES (9, 'mail.smtp.user', 'site-monitor@putao.com', 1577437337, 1577441748, 'mail.smtp.user', 0);
INSERT INTO `hc_system_setting` VALUES (10, 'mail.smtp.password', 'putao852741963456789123!~', 1577437375, 1577441749, 'mail.smtp.password', 0);
INSERT INTO `hc_system_setting` VALUES (11, 'mail.smtp.from', 'site-monitor@putao.com', 1577437415, 1577441751, 'mail.smtp.from', 0);

-- ----------------------------
-- Table structure for hc_system_user
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_user`;
CREATE TABLE `hc_system_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `salt` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `supered` tinyint(1) NULL DEFAULT NULL,
  `language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_user
-- ----------------------------
INSERT INTO `hc_system_user` VALUES (1, 'admin@putao.com', '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918', '', '超级管理员', '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918', 1545203856, 1545203856, 1, 1, 'zh-cn');
INSERT INTO `hc_system_user` VALUES (2, 'test@putao.com', 'EE79976C9380D5E337FC1C095ECE8C8F22F91F306CEEB161FA51FECEDE2C4BA1', '', '功能测试', '', 1545203856, 1545203856, 1, 0, 'zh-cn');

-- ----------------------------
-- Table structure for hc_system_user_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_user_backup`;
CREATE TABLE `hc_system_user_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `salt` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created` int(11) NOT NULL DEFAULT 0,
  `updated` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `supered` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_user_backup
-- ----------------------------
INSERT INTO `hc_system_user_backup` VALUES (1, 'admin@putao.com', '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918', '', 'ds1', '', 1530081736, 1530081736, 1, 1);
INSERT INTO `hc_system_user_backup` VALUES (2, 'test@putao.com', '163B62868E989E49F4CD14DDBB4CF16EDAC1695F2A6605570B6010199BF0B47C', 'test', 'fdasfd', NULL, 1529917672, 1529917672, 1, 1);

-- ----------------------------
-- Table structure for hc_system_user_role
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_user_role`;
CREATE TABLE `hc_system_user_role`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id`(`user_id`) USING BTREE,
  INDEX `fk_role_id`(`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_user_role
-- ----------------------------
INSERT INTO `hc_system_user_role` VALUES (2, 2, 4);
INSERT INTO `hc_system_user_role` VALUES (4, 1, 1);

-- ----------------------------
-- Table structure for hc_system_user_role_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_system_user_role_backup`;
CREATE TABLE `hc_system_user_role_backup`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id`(`user_id`) USING BTREE,
  INDEX `fk_role_id`(`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_system_user_role_backup
-- ----------------------------
INSERT INTO `hc_system_user_role_backup` VALUES (12, 66, 1);
INSERT INTO `hc_system_user_role_backup` VALUES (13, 66, 2);
INSERT INTO `hc_system_user_role_backup` VALUES (14, 99, 3);
INSERT INTO `hc_system_user_role_backup` VALUES (15, 100, 3);
INSERT INTO `hc_system_user_role_backup` VALUES (16, 98, 3);
INSERT INTO `hc_system_user_role_backup` VALUES (17, 98, 2);
INSERT INTO `hc_system_user_role_backup` VALUES (34, 1, 3);
INSERT INTO `hc_system_user_role_backup` VALUES (35, 1, 2);
INSERT INTO `hc_system_user_role_backup` VALUES (36, 1, 1);
INSERT INTO `hc_system_user_role_backup` VALUES (37, 101, 3);

-- ----------------------------
-- Table structure for hc_tag_article_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_tag_article_backup`;
CREATE TABLE `hc_tag_article_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `created` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '标签关联文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_tag_article_backup
-- ----------------------------
INSERT INTO `hc_tag_article_backup` VALUES (1, 49, 16, 1536719438);
INSERT INTO `hc_tag_article_backup` VALUES (2, 49, 17, 1536720301);
INSERT INTO `hc_tag_article_backup` VALUES (4, 2, 19, 1536721378);
INSERT INTO `hc_tag_article_backup` VALUES (5, 2, 20, 1536721777);
INSERT INTO `hc_tag_article_backup` VALUES (6, 1, 21, 1536721959);
INSERT INTO `hc_tag_article_backup` VALUES (7, 2, 21, 1536721959);
INSERT INTO `hc_tag_article_backup` VALUES (12, 1, 18, 1536734296);
INSERT INTO `hc_tag_article_backup` VALUES (13, 2, 18, 1536734296);
INSERT INTO `hc_tag_article_backup` VALUES (22, 1, 9, 1536802876);
INSERT INTO `hc_tag_article_backup` VALUES (23, 0, 9, 1536802876);
INSERT INTO `hc_tag_article_backup` VALUES (24, 1, 22, 1536804426);
INSERT INTO `hc_tag_article_backup` VALUES (25, 2, 22, 1536804426);
INSERT INTO `hc_tag_article_backup` VALUES (26, 1, 26, 1536810232);
INSERT INTO `hc_tag_article_backup` VALUES (27, 0, 26, 1536810232);
INSERT INTO `hc_tag_article_backup` VALUES (44, 1, 27, 1536842269);
INSERT INTO `hc_tag_article_backup` VALUES (45, 0, 27, 1536842269);
INSERT INTO `hc_tag_article_backup` VALUES (46, 0, 28, 1536842301);
INSERT INTO `hc_tag_article_backup` VALUES (47, 2, 28, 1536842301);
INSERT INTO `hc_tag_article_backup` VALUES (48, 1, 7, 1536894783);
INSERT INTO `hc_tag_article_backup` VALUES (49, 0, 7, 1536894783);
INSERT INTO `hc_tag_article_backup` VALUES (50, 0, 35, 1543395507);
INSERT INTO `hc_tag_article_backup` VALUES (51, 2, 35, 1543395507);
INSERT INTO `hc_tag_article_backup` VALUES (52, 0, 36, 1543478012);
INSERT INTO `hc_tag_article_backup` VALUES (53, 0, 36, 1543478012);
INSERT INTO `hc_tag_article_backup` VALUES (54, 1, 37, 1543481163);
INSERT INTO `hc_tag_article_backup` VALUES (55, 2, 37, 1543481163);
INSERT INTO `hc_tag_article_backup` VALUES (56, 1, 38, 1543481715);
INSERT INTO `hc_tag_article_backup` VALUES (57, 2, 38, 1543481715);
INSERT INTO `hc_tag_article_backup` VALUES (58, 0, 39, 1543484709);
INSERT INTO `hc_tag_article_backup` VALUES (59, 2, 39, 1543484709);

-- ----------------------------
-- Table structure for hc_tag_tag_backup
-- ----------------------------
DROP TABLE IF EXISTS `hc_tag_tag_backup`;
CREATE TABLE `hc_tag_tag_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort` int(11) NULL DEFAULT 0,
  `updated` int(11) NULL DEFAULT NULL,
  `created` int(11) NULL DEFAULT NULL,
  `status` tinyint(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '标签管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_tag_tag_backup
-- ----------------------------
INSERT INTO `hc_tag_tag_backup` VALUES (1, 'abc', 0, 1536563714, 1536563714, 1);
INSERT INTO `hc_tag_tag_backup` VALUES (2, 'bcd', 0, 1536563714, 1536563714, 1);

-- ----------------------------
-- Table structure for hc_user
-- ----------------------------
DROP TABLE IF EXISTS `hc_user`;
CREATE TABLE `hc_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户登录名称',
  `mobile` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `salt` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '随机盐',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gender` tinyint(1) NULL DEFAULT NULL,
  `introduce` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个人简介',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '0未启用1正常2停用',
  `ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注册时的IP',
  `uas_unid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uas_openid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updated` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `created` int(11) NULL DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_user
-- ----------------------------

-- ----------------------------
-- Table structure for hc_user_oauth
-- ----------------------------
DROP TABLE IF EXISTS `hc_user_oauth`;
CREATE TABLE `hc_user_oauth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户uid',
  `oauth_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `flag` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '1 Git',
  `updated` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `created` int(11) NULL DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_user_oauth
-- ----------------------------
INSERT INTO `hc_user_oauth` VALUES (11, 35, '7113365', 1, 1576461750, 1576461750);

-- ----------------------------
-- Table structure for hc_user_verifycode
-- ----------------------------
DROP TABLE IF EXISTS `hc_user_verifycode`;
CREATE TABLE `hc_user_verifycode`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `code_type` tinyint(3) NULL DEFAULT 1 COMMENT '类型1.邮件验证码，2手机验证码',
  `account` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户，邮箱或手机号',
  `code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '验证码',
  `status` tinyint(3) NOT NULL DEFAULT 1 COMMENT '可用状态，1.可用，未使用过，0.不可用 已经使用过',
  `created` int(10) NULL DEFAULT 0 COMMENT '创建时间',
  `updated` int(10) NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `hc_user_verifycode_account_IDX`(`account`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hc_user_verifycode
-- ----------------------------


SET FOREIGN_KEY_CHECKS = 1;
