/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : happy

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 17/02/2020 17:31:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add menus', 6, 'add_menus');
INSERT INTO `auth_permission` VALUES (22, 'Can change menus', 6, 'change_menus');
INSERT INTO `auth_permission` VALUES (23, 'Can delete menus', 6, 'delete_menus');
INSERT INTO `auth_permission` VALUES (24, 'Can view menus', 6, 'view_menus');
INSERT INTO `auth_permission` VALUES (25, 'Can add roles', 7, 'add_roles');
INSERT INTO `auth_permission` VALUES (26, 'Can change roles', 7, 'change_roles');
INSERT INTO `auth_permission` VALUES (27, 'Can delete roles', 7, 'delete_roles');
INSERT INTO `auth_permission` VALUES (28, 'Can view roles', 7, 'view_roles');
INSERT INTO `auth_permission` VALUES (29, 'Can add options', 8, 'add_options');
INSERT INTO `auth_permission` VALUES (30, 'Can change options', 8, 'change_options');
INSERT INTO `auth_permission` VALUES (31, 'Can delete options', 8, 'delete_options');
INSERT INTO `auth_permission` VALUES (32, 'Can view options', 8, 'view_options');
INSERT INTO `auth_permission` VALUES (33, 'Can add new user', 9, 'add_newuser');
INSERT INTO `auth_permission` VALUES (34, 'Can change new user', 9, 'change_newuser');
INSERT INTO `auth_permission` VALUES (35, 'Can delete new user', 9, 'delete_newuser');
INSERT INTO `auth_permission` VALUES (36, 'Can view new user', 9, 'view_newuser');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_newuser_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_newuser_id` FOREIGN KEY (`user_id`) REFERENCES `newuser` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (6, 'new', 'menus');
INSERT INTO `django_content_type` VALUES (9, 'new', 'newuser');
INSERT INTO `django_content_type` VALUES (8, 'new', 'options');
INSERT INTO `django_content_type` VALUES (7, 'new', 'roles');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2020-01-29 09:55:00.149400');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2020-01-29 09:55:00.426400');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2020-01-29 09:55:00.761400');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2020-01-29 09:55:01.883400');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2020-01-29 09:55:01.918400');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2020-01-29 09:55:01.951400');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2020-01-29 09:55:02.007400');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2020-01-29 09:55:02.035400');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2020-01-29 09:55:02.093400');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2020-01-29 09:55:02.122400');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2020-01-29 09:55:02.158400');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2020-01-29 09:55:02.428400');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2020-01-29 09:55:02.437400');
INSERT INTO `django_migrations` VALUES (14, 'new', '0001_initial', '2020-01-29 09:55:03.289400');
INSERT INTO `django_migrations` VALUES (15, 'admin', '0001_initial', '2020-01-29 09:55:06.731400');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0002_logentry_remove_auto_add', '2020-01-29 09:55:07.138400');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0003_logentry_add_action_flag_choices', '2020-01-29 09:55:07.167400');
INSERT INTO `django_migrations` VALUES (18, 'sessions', '0001_initial', '2020-01-29 09:55:07.290400');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0b362a39ts0gnpyb3a8fk08fufjs8prf', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:15:27.910602');
INSERT INTO `django_session` VALUES ('0v8lhey5u8xjrzorcht7njojkavcvhcw', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:12:35.967602');
INSERT INTO `django_session` VALUES ('2i911k0fq5pinlhk0nvdch3kyiedk86w', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 13:17:26.837610');
INSERT INTO `django_session` VALUES ('3oijp9ed1knul94vyb8yxjv5zu92c07z', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 12:42:56.873610');
INSERT INTO `django_session` VALUES ('3wt78wmtaoum14geynzrliy0xawi07yn', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:04:28.851602');
INSERT INTO `django_session` VALUES ('4ahbfwxbh49kemyu6ds0h2hywllnpmlt', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 11:40:26.431602');
INSERT INTO `django_session` VALUES ('4lt04p7en69fzi2h6vc2h9fhgryc0u08', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 12:41:24.256610');
INSERT INTO `django_session` VALUES ('51ohkxnjl36bwyyyyp2tdofor7pnxllp', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 08:20:20.998602');
INSERT INTO `django_session` VALUES ('6frxx2ywu6dunjrjqomdcqtuxyxz2xwv', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 08:16:06.511602');
INSERT INTO `django_session` VALUES ('6vli9u5vv91vgy1tnktcni1yzs5qut3g', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 12:45:59.563610');
INSERT INTO `django_session` VALUES ('7xy6p8fzd4br99iywaehmgmq1ksjrq9v', 'OGFjODMxZDA5M2FmN2I1MWNhYmQwMzY1MzY3ZTVkZWZkNjdhYTBkOTp7fQ==', '2020-02-28 10:33:39.709602');
INSERT INTO `django_session` VALUES ('8drdf6rtbsr6my8md812i0qhvk63sg5c', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 06:50:37.052602');
INSERT INTO `django_session` VALUES ('8nfwvwvhq17xnyucza4g7f70qcvr5lh6', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 13:04:49.320610');
INSERT INTO `django_session` VALUES ('9aaacsl6b2g7tkvp67oaqe0hgdosr8gt', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:56:05.559602');
INSERT INTO `django_session` VALUES ('9wpkq84ldpavd3dnbw836jrdtbs8rtqm', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 12:19:27.030610');
INSERT INTO `django_session` VALUES ('aqpdekx22t344zgyp3px5l4de24uf6xf', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:49:57.366602');
INSERT INTO `django_session` VALUES ('at2lke105uld6q140abplccyqpzz4vi8', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 13:16:16.981610');
INSERT INTO `django_session` VALUES ('azojxoi2hqfxmovkzgovara98n14sqz9', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:59:09.554602');
INSERT INTO `django_session` VALUES ('bqs6aatdzx4a33y30fbx69t15p6p01t4', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:06:54.837602');
INSERT INTO `django_session` VALUES ('cy2ckxqxo5cyx6l4gt2ipt1mbarzwis4', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:19:15.443602');
INSERT INTO `django_session` VALUES ('e2bd52f25dbm1euunka8du9qcg83ixsf', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 08:23:21.968602');
INSERT INTO `django_session` VALUES ('e72xnanpsdolzdbzt21cso784ppflet9', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 08:01:11.721602');
INSERT INTO `django_session` VALUES ('exbyqw8h03um3y1gvyjhk6nalsdhty9l', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:02:25.880602');
INSERT INTO `django_session` VALUES ('f64ihgnluupsedofrdkv5svw7ot0pvgz', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:28:50.391602');
INSERT INTO `django_session` VALUES ('fa9isrta23mwlu69c8few6ain5rx1ltx', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:17:09.457602');
INSERT INTO `django_session` VALUES ('hntzaen38vdns760ksyt37hjr8aia3fm', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 06:52:13.700602');
INSERT INTO `django_session` VALUES ('i6fsmvqcfn8h8uekeinn99j2xn41izcm', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 08:08:35.111602');
INSERT INTO `django_session` VALUES ('igmatr1kfezh69y3dsbfzdji8zm8deuv', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 13:15:37.124610');
INSERT INTO `django_session` VALUES ('igoq12cj0o0s7rvr67vqb77d5sg8vs6a', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 06:28:11.253602');
INSERT INTO `django_session` VALUES ('jbnrib4somj27hcv375g3qjifq1jjfd2', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 08:04:05.519602');
INSERT INTO `django_session` VALUES ('jr1crw9tly3elzuvi1f1dq90tin9yopl', 'OGFjODMxZDA5M2FmN2I1MWNhYmQwMzY1MzY3ZTVkZWZkNjdhYTBkOTp7fQ==', '2020-02-28 10:33:35.959602');
INSERT INTO `django_session` VALUES ('jyvtoehqfkg729wmf32d1qqba48jo798', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:22:55.112602');
INSERT INTO `django_session` VALUES ('k33iftsu53ahbx6mqsvsj67el3l3nxs5', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 12:10:53.275610');
INSERT INTO `django_session` VALUES ('k8rwx1cplhjcb2v6fj6ctyw49zulnn47', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:42:43.139602');
INSERT INTO `django_session` VALUES ('oid7c9nis7drye322lydf7xxqznon2cg', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 12:01:05.418610');
INSERT INTO `django_session` VALUES ('oww862w12pc5qbet5vgi3xpytttsrp1u', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 06:53:07.790602');
INSERT INTO `django_session` VALUES ('q1jzng8iqj80qzow2rj55ryv9r6cpw6u', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:31:24.126602');
INSERT INTO `django_session` VALUES ('r40kxr2mr79yhedumpqwbz0w6jb4qs16', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 08:07:05.708602');
INSERT INTO `django_session` VALUES ('rl5c9cjx3jbnbskj10h6hysc210tu7tz', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:57:35.362602');
INSERT INTO `django_session` VALUES ('s5uq64fboh3ivybllmdclslx460ov4vv', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 06:29:15.259602');
INSERT INTO `django_session` VALUES ('snnp2qg25hphx01robgxfegihtcm0vnt', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:36:33.575602');
INSERT INTO `django_session` VALUES ('sowufh56kjahi8qzl3my2rtxcthvgg9y', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 12:57:28.692610');
INSERT INTO `django_session` VALUES ('sy0ym0kz4dpsp3h7i1n9vlyjfkihpf0j', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:17:36.145602');
INSERT INTO `django_session` VALUES ('ua4msgvmln88d3ofkgg706qbhqbezhq1', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:01:11.135602');
INSERT INTO `django_session` VALUES ('ubinxq6o513xyd2agifwks91fzyi96np', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:05:25.413602');
INSERT INTO `django_session` VALUES ('uqplkjgc49vbv302dgllovt1psm64r91', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 08:29:27.906602');
INSERT INTO `django_session` VALUES ('uv78772448zi5n10b32i0562jh3c5lhd', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:35:38.762602');
INSERT INTO `django_session` VALUES ('wbbbt9jzesqe7hy48k37sqgiq0q3ut03', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-27 12:40:28.605610');
INSERT INTO `django_session` VALUES ('wbtp9k0iny0bzay3ngtgogwuzfymrnh2', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 06:29:44.765602');
INSERT INTO `django_session` VALUES ('y8il7hkw8wf9rcw0btzyfb3kf279v6gm', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:44:16.672602');
INSERT INTO `django_session` VALUES ('ydacgocysx8nouawzsz2zjeuvyp750lo', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 07:27:26.027602');
INSERT INTO `django_session` VALUES ('yhzgom5qjkajsq996kqkdf4b98mtpk6f', 'ZWE0MWY0MmE5OTVjYTE1M2RjMWZiMmU5ZTM3YjNjOWQyMzZiNGMzMTp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTNkZTkyMDcyY2I1ODZhNTZiOTUyNjZlYTNmOWFlNGYyN2ZjNWNmMCJ9', '2020-02-28 06:51:10.749602');

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `url` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `icon` varchar(56) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `order` varchar(56) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `menuself_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menus_menuself_id_4a25815f_fk_menus_id`(`menuself_id`) USING BTREE,
  CONSTRAINT `menus_menuself_id_4a25815f_fk_menus_id` FOREIGN KEY (`menuself_id`) REFERENCES `menus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menus
-- ----------------------------
INSERT INTO `menus` VALUES (34, '管理系统', '/users', 'table', '8', NULL);
INSERT INTO `menus` VALUES (35, '菜单管理', '/menus', '', '5', 34);
INSERT INTO `menus` VALUES (36, '权限管理', '/controls', '', '3', 34);
INSERT INTO `menus` VALUES (42, '角色管理', '/roles', '', '2', 34);
INSERT INTO `menus` VALUES (44, '首页', '/', 'dashboard', '1', NULL);
INSERT INTO `menus` VALUES (45, '首页内容', '/dashboard', '', '5', 44);
INSERT INTO `menus` VALUES (48, '用户管理', '/persons', '', '1', 34);
INSERT INTO `menus` VALUES (49, 'form表单制定', '/form', 'form', '6', NULL);

-- ----------------------------
-- Table structure for newuser
-- ----------------------------
DROP TABLE IF EXISTS `newuser`;
CREATE TABLE `newuser`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `newuser_role_id_61fd9b13_fk_roles_id`(`role_id`) USING BTREE,
  CONSTRAINT `newuser_role_id_61fd9b13_fk_roles_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of newuser
-- ----------------------------
INSERT INTO `newuser` VALUES (1, 'd82494f05d6917ba02f7aaa29689ccb444bb73f20380876cb05d1f37537b7892', NULL, 1, 'admin', '', '', '11@qq.com', 1, 1, '2020-01-29 10:17:06.911400', 11);
INSERT INTO `newuser` VALUES (2, '449b6e09ebb3547e9c1ccb03cfb7f96f4db138096d9fb0e3e80fedb7695bbb75', NULL, 0, 'admin2323', '', '', '', 0, 1, '2020-02-12 08:59:52.481419', 1);
INSERT INTO `newuser` VALUES (4, 'pbkdf2_sha256$150000$nlp0vGGnOILx$9kPBhavOeF0QyhxwV39N+a5rB8OPBlvBu8+iW/ULTkQ=', '2020-02-16 10:44:52.599000', 0, 'admin777', '', '', '', 0, 1, '2020-02-12 09:52:18.166419', 11);
INSERT INTO `newuser` VALUES (12, 'pbkdf2_sha256$150000$uJjh5T33ZGOm$u5nbNfgl+cmmNPE8h2Wa/yPT4XRZuAyoo8ZvSwJPtn8=', '2020-02-17 09:20:14.749000', 0, 'admin888', '', '', '', 0, 1, '2020-02-13 11:12:13.999610', 11);
INSERT INTO `newuser` VALUES (13, 'pbkdf2_sha256$150000$JSVMRiC6ezD4$LMRGTttXjHmKPJFO/JzY9ULffVGA1Os1o/etvgGGqHM=', '2020-02-15 10:23:09.910208', 0, 'ceshi01', '', '', '', 0, 1, '2020-02-15 10:23:01.066208', 1);

-- ----------------------------
-- Table structure for newuser_groups
-- ----------------------------
DROP TABLE IF EXISTS `newuser_groups`;
CREATE TABLE `newuser_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `newuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `newuser_groups_newuser_id_group_id_6e81469f_uniq`(`newuser_id`, `group_id`) USING BTREE,
  INDEX `newuser_groups_group_id_835ce3cd_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `newuser_groups_group_id_835ce3cd_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `newuser_groups_newuser_id_b04390cd_fk_newuser_id` FOREIGN KEY (`newuser_id`) REFERENCES `newuser` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for newuser_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `newuser_user_permissions`;
CREATE TABLE `newuser_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `newuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `newuser_user_permissions_newuser_id_permission_id_88f8765a_uniq`(`newuser_id`, `permission_id`) USING BTREE,
  INDEX `newuser_user_permiss_permission_id_aadb73e4_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `newuser_user_permiss_permission_id_aadb73e4_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `newuser_user_permissions_newuser_id_1b5c9cdf_fk_newuser_id` FOREIGN KEY (`newuser_id`) REFERENCES `newuser` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for options
-- ----------------------------
DROP TABLE IF EXISTS `options`;
CREATE TABLE `options`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `url` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `method` varchar(56) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `options_menu_id_38d15852_fk_menus_id`(`menu_id`) USING BTREE,
  CONSTRAINT `options_menu_id_38d15852_fk_menus_id` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of options
-- ----------------------------
INSERT INTO `options` VALUES (19, '首页内容显示', '/index/router/$', 'GET', 45);
INSERT INTO `options` VALUES (23, '获取菜单信息', '/users/menus/all/(\\d+)/(\\d+)/$', 'GET', 35);
INSERT INTO `options` VALUES (24, '添加权限数据', '/users/controls/add/$', 'POST', 36);
INSERT INTO `options` VALUES (26, '添加菜单数据', '/users/menus/add/$', 'POST', 35);
INSERT INTO `options` VALUES (27, '删除菜单数据', '/users/menus/delete/$', 'DELETE', 35);
INSERT INTO `options` VALUES (28, '删除权限数据', '/users/controls/delete/$', 'DELETE', 36);
INSERT INTO `options` VALUES (29, '获取权限信息', '/users/controls/all/(\\d+)/(\\d+)/$', 'GET', 36);
INSERT INTO `options` VALUES (30, '获取角色信息', '/users/roles/all/(\\d+)/(\\d+)/$', 'GET', 42);
INSERT INTO `options` VALUES (31, '添加角色数据', '/users/roles/add/$', 'POST', 42);
INSERT INTO `options` VALUES (32, '删除角色数据', '/users/roles/delete/$', 'DELETE', 42);
INSERT INTO `options` VALUES (33, '获取用户信息', '/users/persons/all/(\\d+)/(\\d+)/$', 'GET', 48);
INSERT INTO `options` VALUES (34, '添加用户数据', '/users/persons/add/$', 'POST', 48);
INSERT INTO `options` VALUES (35, '删除用户数据', '/users/persons/delete/$', 'DELETE', 48);
INSERT INTO `options` VALUES (36, '显示form表单', '/234123123', 'GET', 49);

-- ----------------------------
-- Table structure for options_role
-- ----------------------------
DROP TABLE IF EXISTS `options_role`;
CREATE TABLE `options_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `options_id` int(11) NOT NULL,
  `roles_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `options_role_options_id_roles_id_591f7544_uniq`(`options_id`, `roles_id`) USING BTREE,
  INDEX `options_role_roles_id_61c675cf_fk_roles_id`(`roles_id`) USING BTREE,
  CONSTRAINT `options_role_options_id_05a6c4e2_fk_options_id` FOREIGN KEY (`options_id`) REFERENCES `options` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `options_role_roles_id_61c675cf_fk_roles_id` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 265 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of options_role
-- ----------------------------
INSERT INTO `options_role` VALUES (196, 19, 1);
INSERT INTO `options_role` VALUES (256, 19, 11);
INSERT INTO `options_role` VALUES (257, 23, 11);
INSERT INTO `options_role` VALUES (258, 24, 11);
INSERT INTO `options_role` VALUES (259, 26, 11);
INSERT INTO `options_role` VALUES (260, 27, 11);
INSERT INTO `options_role` VALUES (261, 28, 11);
INSERT INTO `options_role` VALUES (262, 29, 11);
INSERT INTO `options_role` VALUES (263, 30, 11);
INSERT INTO `options_role` VALUES (264, 31, 11);
INSERT INTO `options_role` VALUES (251, 32, 11);
INSERT INTO `options_role` VALUES (252, 33, 11);
INSERT INTO `options_role` VALUES (253, 34, 11);
INSERT INTO `options_role` VALUES (254, 35, 11);
INSERT INTO `options_role` VALUES (255, 36, 11);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, '超级管理员');
INSERT INTO `roles` VALUES (11, 'superadmin');

SET FOREIGN_KEY_CHECKS = 1;
