/*
 Navicat Premium Data Transfer

 Source Server         : openGauss
 Source Server Type    : PostgreSQL
 Source Host           : 192.168.236.142:26000
 Source Catalog        : chenwkmis03
 Source Schema         : cwk   --  public

 Target Server Type    : PostgreSQL
 Target Server Version : 90204
 File Encoding         : 65001

*/


-- ----------------------------
-- 管理员表结构
-- ----------------------------
DROP TABLE IF EXISTS "public"."chenwk_admin03";
CREATE TABLE "public"."chenwk_admin03" (
  "cwk_id03" int8 NOT NULL,
  "cwk_password03" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "cwk_role03" varchar(255) COLLATE "pg_catalog"."default"--编码规则
)
;

-- ----------------------------
-- Records of chenwk_admin03
-- ----------------------------
INSERT INTO "public"."chenwk_admin03" VALUES (123456, '123456', 'SUPER_ADMIN');
INSERT INTO "public"."chenwk_admin03" VALUES (88888, '88888', 'SUPER_ADMIN');
INSERT INTO "public"."chenwk_admin03" VALUES (99999, '99999', 'SUPER_ADMIN');

-- ----------------------------
-- 班级表结构
-- ----------------------------
DROP TABLE IF EXISTS "public"."chenwk_class03";
CREATE TABLE "public"."chenwk_class03" (
  "cwk_id03" int4 NOT NULL,
  "cwk_major_id03" int8 NOT NULL,
  "cwk_name03" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "cwk_count_of_students03" int4 DEFAULT 0,
  "cwk_head_teacher_id03" int8
)
;

-- ----------------------------
-- 班级表数据
-- ----------------------------
INSERT INTO "public"."chenwk_class03" VALUES (1004, 11, '电气2302', 0, 20009);
INSERT INTO "public"."chenwk_class03" VALUES (1009, 11, '电气2301', 0, 20009);
INSERT INTO "public"."chenwk_class03" VALUES (1005, 4, '数字媒体2301', 0, 20019);
INSERT INTO "public"."chenwk_class03" VALUES (1006, 4, '数字媒体2302', 0, 20019);
INSERT INTO "public"."chenwk_class03" VALUES (1007, 4, '数字媒体2303', 0, 20019);
INSERT INTO "public"."chenwk_class03" VALUES (1003, 7, '计科2301', 1, 20001);
INSERT INTO "public"."chenwk_class03" VALUES (1008, 2, '软工2301', 2, 20011);
INSERT INTO "public"."chenwk_class03" VALUES (1002, 2, '软工2302', 2, 20011);
INSERT INTO "public"."chenwk_class03" VALUES (1010, 1, '网工2301', 1, 20010);
INSERT INTO "public"."chenwk_class03" VALUES (1011, 1, '网工2302', 2, 20003);
INSERT INTO "public"."chenwk_class03" VALUES (1001, 1, '计科2302', 2, 20006);
INSERT INTO "public"."chenwk_class03" VALUES (1012, 1, '计科2303', 2, 20006);

-- ----------------------------
-- 学院表结构
-- ----------------------------
DROP TABLE IF EXISTS "public"."chenwk_college03";
CREATE TABLE "public"."chenwk_college03" (
  "cwk_id03" int4 NOT NULL,
  "cwk_name03" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- 学院表数据
-- ----------------------------
INSERT INTO "public"."chenwk_college03" VALUES (10000, '计算机科学与技术学院');
INSERT INTO "public"."chenwk_college03" VALUES (10001, '设计与建筑学院');
INSERT INTO "public"."chenwk_college03" VALUES (10002, '化学工程');
INSERT INTO "public"."chenwk_college03" VALUES (10005, '信息学院');
INSERT INTO "public"."chenwk_college03" VALUES (10006, '人文学院');
INSERT INTO "public"."chenwk_college03" VALUES (10007, '机械学院');
INSERT INTO "public"."chenwk_college03" VALUES (10008, '能源与动力学院');
INSERT INTO "public"."chenwk_college03" VALUES (10009, '马克思主义学院');
INSERT INTO "public"."chenwk_college03" VALUES (10010, '外国语学院');
INSERT INTO "public"."chenwk_college03" VALUES (10011, '理学院');

-- ----------------------------
-- 课程表结构
-- ----------------------------
DROP TABLE IF EXISTS "public"."chenwk_course03";
CREATE TABLE "public"."chenwk_course03" (
  "cwk_id03" char(7) COLLATE "pg_catalog"."default" NOT NULL,
  "cwk_name03" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "cwk_term03" varchar(20) COLLATE "pg_catalog"."default",
  "cwk_college_id03" int4,
  "cwk_examination_method03" varchar(50) COLLATE "pg_catalog"."default",
  "cwk_credit03" float8,
  "cwk_hours03" int4,
  "cwk_attribute03" varchar(50) COLLATE "pg_catalog"."default",
  "cwk_year03" int4,
	"cwk_final_exam_date03" DATE
)
;

INSERT INTO "public"."chenwk_course03"
("cwk_id03", "cwk_name03", "cwk_term03", "cwk_college_id03", 
 "cwk_examination_method03", "cwk_credit03", "cwk_hours03", 
 "cwk_attribute03", "cwk_year03", "cwk_final_exam_date03")
VALUES 
-- 计算机科学与技术学院
('1002   ', '计算机网络原理', '2024-2025(1)', 10000, '考试', 3, 48, '必修课', 2024, DATE '2025-06-22'),
('1003   ', '计算方法与设计', '2024-2025(2)', 10000, '考察', 3, 48, '选修课', 2024, NULL),
('1001   ', '计算机组成原理', '2024-2025(2)', 10000, '考试', 3, 48, '必修课', 2024, DATE '2025-06-21'),
('1000   ', '数据库原理', '2024-2025(2)', 10000, '考试', 3, 48, '必修课', 2024, DATE '2025-06-20'),
('1005   ', '算法设计与分析', '2024-2025(2)', 10000, '考试', 3, 48, '选修课', 2025, DATE '2025-06-24'),
('1015   ', '数字逻辑电路', '2024-2025(2)', 10000, '考试', 4, 64, '必修课', 2025, DATE '2025-06-29'),
('1004   ', '操作系统原理', '2024-2025(1)', 10000, '考试', 4, 64, '必修课', 2024, DATE '2025-06-23'),
('1006   ', '软件工程', '2024-2025(1)', 10000, '考察', 3, 48, '必修课', 2024, NULL),
('1007   ', '人工智能基础', '2024-2025(2)', 10000, '考察', 2, 32, '选修课', 2024, NULL),
('1008   ', '编译原理', '2024-2025(1)', 10000, '考试', 4, 64, '必修课', 2025, DATE '2025-06-25'),
('1009   ', '计算机图形学', '2024-2025(2)', 10000, '考察', 3, 48, '选修课', 2025, NULL),
('1010   ', '网络安全基础', '2024-2025(1)', 10000, '考试', 3, 48, '选修课', 2025, DATE '2025-06-26'),
('1011   ', '大数据技术', '2024-2025(2)', 10000, '考察', 3, 48, '选修课', 2025, NULL),
('1012   ', '嵌入式系统', '2024-2025(1)', 10000, '考试', 3, 48, '选修课', 2025, DATE '2025-06-27'),
('1013   ', '分布式系统', '2024-2025(2)', 10000, '考试', 3, 48, '选修课', 2025, DATE '2025-06-28'),
('1014   ', '机器学习', '2024-2025(1)', 10000, '考察', 3, 48, '选修课', 2025, NULL),

-- 信息学院
('2000   ', '信号与系统', '2024-2025(1)', 10005, '考试', 4, 64, '必修课', 2024, DATE '2025-06-20'),
('2001   ', '通信原理', '2024-2025(2)', 10005, '考试', 3, 48, '必修课', 2024, DATE '2025-06-21'),
('2002   ', '数字信号处理', '2024-2025(1)', 10005, '考试', 3, 48, '必修课', 2025, DATE '2025-06-22'),
('2003   ', '电磁场与电磁波', '2024-2025(2)', 10005, '考试', 4, 64, '必修课', 2025, DATE '2025-06-23'),

-- 机械学院
('3000   ', '机械设计基础', '2024-2025(1)', 10007, '考试', 4, 64, '必修课', 2024, DATE '2025-06-24'),
('3001   ', '材料力学', '2024-2025(2)', 10007, '考试', 3, 48, '必修课', 2024, DATE '2025-06-25'),
('3002   ', '机器人学基础', '2024-2025(1)', 10007, '考察', 3, 48, '选修课', 2025, NULL),

-- 外国语学院
('4000   ', '高级英语', '2024-2025(1)', 10010, '考察', 2, 32, '必修课', 2024, NULL),
('4001   ', '翻译理论与实践', '2024-2025(2)', 10010, '考察', 3, 48, '选修课', 2024, NULL),
('4002   ', '德语入门', '2024-2025(1)', 10010, '考察', 2, 32, '选修课', 2025, NULL);

-- ----------------------------
DROP TABLE IF EXISTS "public"."chenwk_course_schedule03";
CREATE TABLE "public"."chenwk_course_schedule03" (
  "cwk_course_id03" char(7) COLLATE "pg_catalog"."default" NOT NULL,
  "cwk_class_id03" int4 NOT NULL,
  "cwk_teacher_id03" int8
)
;

-- ----------------------------
-- 课程安排表数据
-- ----------------------------
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1000   ', 1001, 20006); -- 数据库原理 - 计科2302 - 李甜甜
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1000   ', 1002, 20011); -- 数据库原理 - 软工2302 - 管秋
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1001   ', 1001, 20006); -- 计算机组成原理 - 计科2302 - 李甜甜
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1001   ', 1003, 20001); -- 计算机组成原理 - 计科2301 - 党源杰
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1002   ', 1002, 20011); -- 计算机网络原理 - 软工2302 - 管秋
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1002   ', 1012, 20010); -- 计算机网络原理 - 网工2301 - 陈朋
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1003   ', 1003, 20001); -- 计算方法与设计 - 计科2301 - 党源杰
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1003   ', 1002, 20004); -- 计算方法与设计 - 软工2302 - 邱杰凡
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1004   ', 1003, 20001); -- 操作系统原理 - 计科2301 - 党源杰
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1004   ', 1012, 20010); -- 操作系统原理 - 网工2301 - 陈朋
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1005   ', 1001, 20019); -- 算法设计与分析 - 计科2302 - 陈振波
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1005   ', 1005, 20019); -- 算法设计与分析 - 数字媒体2303 - 陈振波
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1006   ', 1002, 20011); -- 软件工程 - 软工2302 - 管秋
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1006   ', 1003, 20001); -- 软件工程 - 计科2301 - 党源杰
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1007   ', 1005, 20019); -- 人工智能基础 - 数字媒体2303 - 陈振波
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1008   ', 1003, 20008); -- 编译原理 - 计科2301 - 熊丽荣
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1008   ', 1012, 20008); -- 编译原理 - 网工2301 - 熊丽荣
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1009   ', 1005, 20019); -- 计算机图形学 - 数字媒体2303 - 陈振波
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1010   ', 1012, 20010); -- 网络安全基础 - 网工2301 - 陈朋
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1010   ', 1011, 20003); -- 网络安全基础 - 网工2302 - 朱明杰
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1011   ', 1011, 20003); -- 大数据技术 - 网工2302 - 朱明杰
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1012   ', 1012, 20010); -- 嵌入式系统 - 网工2301 - 陈朋
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1013   ', 1011, 20003); -- 分布式系统 - 网工2302 - 朱明杰
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1014   ', 1005, 20019); -- 机器学习 - 数字媒体2303 - 陈振波
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1015   ', 1001, 20006); -- 数字逻辑电路 - 计科2302 - 李甜甜
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('1015   ', 1012, 20008); -- 数字逻辑电路 - 网工2301 - 熊丽荣

-- 信息学院(10005)的课程安排
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('2000   ', 1004, 20009); -- 信号与系统 - 电气2304 - 褚衍清
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('2001   ', 1004, 20009); -- 通信原理 - 电气2304 - 褚衍清
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('2002   ', 1004, 20009); -- 数字信号处理 - 电气2304 - 褚衍清
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('2003   ', 1004, 20009); -- 电磁场与电磁波 - 电气2304 - 褚衍清

-- 机械学院(10007)的课程安排
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('3000   ', 1005, 20007); -- 机械设计基础 - 数字媒体2303 - 王金虎
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('3001   ', 1005, 20007); -- 材料力学 - 数字媒体2303 - 王金虎
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('3002   ', 1005, 20007); -- 机器人学基础 - 数字媒体2303 - 王金虎

-- 外国语学院(10010)的课程安排
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('4000   ', 1001, 20020); -- 高级英语 - 计科2302 - 曾嵘
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('4000   ', 1002, 20020); -- 高级英语 - 软工2302 - 曾嵘
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('4000   ', 1003, 20020); -- 高级英语 - 计科2301 - 曾嵘
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('4001   ', 1005, 20020); -- 翻译理论与实践 - 数字媒体2303 - 曾嵘
INSERT INTO "public"."chenwk_course_schedule03" VALUES ('4002   ', 1004, 20020); -- 德语入门 - 电气2304 - 曾嵘


-- ----------------------------
-- 专业表结构
-- ----------------------------
DROP TABLE IF EXISTS "public"."chenwk_major03";
CREATE TABLE "public"."chenwk_major03" (
  "cwk_id03" int4 NOT NULL,
  "cwk_name03" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "cwk_college_id03" int4
)
;

-- ----------------------------
-- 专业表数据
-- ----------------------------
INSERT INTO "public"."chenwk_major03" VALUES (1, '计算机科学与技术', 10000);
INSERT INTO "public"."chenwk_major03" VALUES (3, '网络工程', 10000);
INSERT INTO "public"."chenwk_major03" VALUES (4, '数字媒体技术', 10000);
INSERT INTO "public"."chenwk_major03" VALUES (2, '软件工程', 10000);
INSERT INTO "public"."chenwk_major03" VALUES (5, '大数据', 10000);
INSERT INTO "public"."chenwk_major03" VALUES (7, '计算机智能', 10000);
INSERT INTO "public"."chenwk_major03" VALUES (11, '电气工程', 10005);
INSERT INTO "public"."chenwk_major03" VALUES (12, '通讯工程', 10005);
INSERT INTO "public"."chenwk_major03" VALUES (13, '英语', 10010);
INSERT INTO "public"."chenwk_major03" VALUES (14, '德语', 10010);
INSERT INTO "public"."chenwk_major03" VALUES (15, '机器人工程', 10007);
INSERT INTO "public"."chenwk_major03" VALUES (10, '自动化工程', 10005);

-- ----------------------------
-- 成绩表结构
-- ----------------------------
DROP TABLE IF EXISTS "public"."chenwk_score03";
CREATE TABLE "public"."chenwk_score03" (
  "cwk_student_id03" int8 NOT NULL,
  "cwk_course_id03" char(7) COLLATE "pg_catalog"."default" NOT NULL,
  "cwk_teacher_id03" int4,
  "cwk_score03" float8,
  "cwk_retake03" bool DEFAULT false,
  "cwk_term03" varchar(20) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- 成绩表数据
-- ----------------------------
INSERT INTO "public"."chenwk_score03" 
("cwk_student_id03", "cwk_course_id03", "cwk_teacher_id03", "cwk_score03", "cwk_retake03", "cwk_term03")
VALUES
(302023351202, '1000   ', 20004, 95, false, '2023-2024(2)'),
(302023351202, '1001   ', 20006, 97, false, '2023-2024(2)'),
(302023350317, '1003   ', 20004, 95, false, '2023-2024(1)'),
(302023350932, '1001   ', 20006, 77, false, '2023-2024(1)'),
(302023350823, '1003   ', 20011, 99, false, '2023-2024(1)'),
(302023350932, '1003   ', 20011, 70, false, '2023-2024(1)'),
(302023350823, '1000   ', 20011, 91, false, '2023-2024(2)'),
(302023350932, '1000   ', 20004, 98, false, '2023-2024(2)'),
(302023350932, '1015   ', 20006, 96, false, '2024-2025(2)'),
(302023350823, '1005   ', 20019, 58, false, '2024-2025(2)'),
(302023350932, '1005   ', 20019, 88, false, '2024-2025(2)'),
(302023350317, '1001   ', 20008, 100, false, '2023-2024(2)'),
(302023350902, '1000   ', 20008, 64, false, '2023-2024(2)'),
(302023350931, '1000   ', 20008, 84, false, '2023-2024(2)'),
(302023350812, '1005   ', 20006, 98, false, '2024-2025(2)'),
(302023350823, '1015   ', 20006, 92, false, '2024-2025(2)'),
(302023315033, '1015   ', 20008, 80, false, '2024-2025(2)'),
(302023315033, '1000   ', 20019, 80, false, '2023-2024(2)'),
(302023351202, '1003   ', 20004, 40, false, '2023-2024(1)'),

-- 张敏(302023310000)
(302023310000, '1001   ', 20006, 92, false, '2024-2025(2)'),
(302023310000, '1000   ', 20006, 85, false, '2024-2025(2)'),
(302023310000, '1002   ', 20011, 78, false, '2024-2025(1)'),
(302023310000, '1006   ', 20011, 88, false, '2024-2025(1)'),

-- 刘静(302023310001)
(302023310001, '1002   ', 20011, 95, false, '2024-2025(1)'),
(302023310001, '1001   ', 20006, 82, false, '2024-2025(2)'),
(302023310001, '1007   ', 20019, 90, false, '2024-2025(2)'),
(302023310001, '1010   ', 20010, 76, false, '2024-2025(1)'),

-- 陈丽(302023310002)
(302023310002, '1003   ', 20001, 88, false, '2024-2025(2)'),
(302023310002, '1005   ', 20019, 92, false, '2024-2025(2)'),
(302023310002, '1009   ', 20019, 85, false, '2024-2025(2)'),

-- 周伟(302023310003)
(302023310003, '1001   ', 20006, 95, false, '2024-2025(2)'),
(302023310003, '1004   ', 20001, 78, false, '2024-2025(1)'),
(302023310003, '1008   ', 20008, 82, false, '2024-2025(1)'),
(302023310003, '1015   ', 20006, 90, false, '2024-2025(2)'),

-- 刘静(302023310004)
(302023310004, '1002   ', 20011, 85, false, '2024-2025(1)'),
(302023310004, '1000   ', 20006, 92, false, '2024-2025(2)'),
(302023310004, '1011   ', 20003, 88, false, '2024-2025(2)'),

-- 张强(302023310005)
(302023310005, '1004   ', 20001, 76, false, '2024-2025(1)'),
(302023310005, '1006   ', 20011, 82, false, '2024-2025(1)'),
(302023310005, '1012   ', 20010, 90, false, '2024-2025(1)'),
(302023310005, '1014   ', 20019, 85, false, '2024-2025(1)'),

-- 郑斌(302023310006)
(302023310006, '1004   ', 20001, 92, false, '2024-2025(1)'),
(302023310006, '1007   ', 20019, 88, false, '2024-2025(2)'),
(302023310006, '1010   ', 20010, 78, false, '2024-2025(1)'),
(302023310006, '1013   ', 20003, 85, false, '2024-2025(2)'),

-- 李娜(302023310007)
(302023310007, '1004   ', 20001, 95, false, '2024-2025(1)'),
(302023310007, '1001   ', 20006, 82, false, '2024-2025(2)'),
(302023310007, '1009   ', 20019, 90, false, '2024-2025(2)'),
(302023310007, '1015   ', 20006, 76, false, '2024-2025(2)'),

-- 杨红(302023310008)
(302023310008, '1010   ', 20010, 88, false, '2024-2025(1)'),
(302023310008, '1002   ', 20011, 92, false, '2024-2025(1)'),
(302023310008, '1008   ', 20008, 85, false, '2024-2025(1)'),
(302023310008, '1011   ', 20003, 78, false, '2024-2025(2)'),

-- 王磊(302023310009)
(302023310009, '1002   ', 20011, 90, false, '2024-2025(1)'),
(302023310009, '1004   ', 20001, 76, false, '2024-2025(1)'),
(302023310009, '1012   ', 20010, 82, false, '2024-2025(1)'),
(302023310009, '1015   ', 20006, 95, false, '2024-2025(2)'),

-- 未出成绩
(302023310010, '1003   ', 20001, NULL, false, '2024-2025(2)'),
(302023310011, '1004   ', 20001, NULL, false, '2024-2025(1)'),
(302023310012, '1002   ', 20011, NULL, false, '2024-2025(1)'),
(302023310013, '1003   ', 20001, NULL, false, '2024-2025(2)'),
(302023310014, '1006   ', 20011, NULL, false, '2024-2025(1)');
-- ----------------------------
-- 学生表结构
-- ----------------------------
DROP TABLE IF EXISTS "public"."chenwk_student03";
CREATE TABLE "public"."chenwk_student03" (
  "cwk_id03" int8 NOT NULL,
  "cwk_name03" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "cwk_gender03" varchar(10) COLLATE "pg_catalog"."default",
  "cwk_birth_year03" int4,
  "cwk_class_id03" int4,
  "cwk_credits03" float8 DEFAULT 0,
  "cwk_hometown03" varchar(50) COLLATE "pg_catalog"."default",
  "cwk_password03" varchar(50) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of chenwk_student03-- 插入学生信息
-- ----------------------------
INSERT INTO "public"."chenwk_student03" VALUES (302023350317, '张洋诚', '女', 2004, 1002, 3, '浙江', 'zjut302023350317');
INSERT INTO "public"."chenwk_student03" VALUES (302023350823, '秦浩轩', '男', 2004, 1001, 7, '浙江', 'zjut302023350823');
INSERT INTO "public"."chenwk_student03" VALUES (302023350932, '陈伟康', '男', 2003, 1001, 16, '浙江', 'zjut302023350021');
INSERT INTO "public"."chenwk_student03" VALUES (302023350902, '卢振宇', '男', 2003, 1011, 3, '浙江', 'zjut302023350902');
INSERT INTO "public"."chenwk_student03" VALUES (302023350931, '杨皓予', '男', 2003, 1011, 3, '浙江', 'zjut302023350931');
INSERT INTO "public"."chenwk_student03" VALUES (302023350812, '杨晶晶', '女', 2005, 1003, 6, '浙江', 'zjut302023350812');
INSERT INTO "public"."chenwk_student03" VALUES (302023315033, '陈李炀', '男', 2004, 1012, 4, '浙江', 'zjut302023315033');
INSERT INTO "public"."chenwk_student03" VALUES (302023351202, '微澜', '男', 2004, 1002, 3, '浙江', 'zjut302023351202');

INSERT INTO "public"."chenwk_student03" VALUES (302023310000, '张敏', '女', 1999, 1001, 0, '江西', 'zjut302023310000');
INSERT INTO "public"."chenwk_student03" VALUES (302023310001, '刘静', '女', 2002, 1002, 0, '河南', 'zjut302023310001');
INSERT INTO "public"."chenwk_student03" VALUES (302023310002, '陈丽', '女', 2005, 1003, 0, '湖北', 'zjut302023310002');
INSERT INTO "public"."chenwk_student03" VALUES (302023310003, '周伟', '男', 1999, 1001, 0, '上海', 'zjut302023310003');
INSERT INTO "public"."chenwk_student03" VALUES (302023310004, '刘静', '女', 2004, 1002, 0, '内蒙古', 'zjut302023310004');
INSERT INTO "public"."chenwk_student03" VALUES (302023310005, '张强', '男', 2000, 1004, 0, '宁夏', 'zjut302023310005');
INSERT INTO "public"."chenwk_student03" VALUES (302023310006, '郑斌', '男', 2000, 1004, 0, '江苏', 'zjut302023310006');
INSERT INTO "public"."chenwk_student03" VALUES (302023310007, '李娜', '女', 2003, 1004, 0, '山西', 'zjut302023310007');
INSERT INTO "public"."chenwk_student03" VALUES (302023310008, '杨红', '女', 2000, 1010, 0, '云南', 'zjut302023310008');
INSERT INTO "public"."chenwk_student03" VALUES (302023310009, '王磊', '男', 2001, 1002, 0, '辽宁', 'zjut302023310009');
INSERT INTO "public"."chenwk_student03" VALUES (302023310010, '陈涛', '男', 2003, 1003, 0, '江西', 'zjut302023310010');
INSERT INTO "public"."chenwk_student03" VALUES (302023310011, '李伟', '男', 2003, 1004, 0, '浙江', 'zjut302023310011');
INSERT INTO "public"."chenwk_student03" VALUES (302023310012, '郑艳', '女', 2005, 1002, 0, '广西', 'zjut302023310012');
INSERT INTO "public"."chenwk_student03" VALUES (302023310013, '杨杰', '男', 2003, 1003, 0, '甘肃', 'zjut302023310013');
INSERT INTO "public"."chenwk_student03" VALUES (302023310014, '李娜', '女', 2003, 1006, 0, '北京', 'zjut302023310014');
INSERT INTO "public"."chenwk_student03" VALUES (302023310015, '周婷', '女', 1999, 1003, 0, '天津', 'zjut302023310015');
INSERT INTO "public"."chenwk_student03" VALUES (302023310016, '周婷', '女', 2004, 1003, 0, '安徽', 'zjut302023310016');
INSERT INTO "public"."chenwk_student03" VALUES (302023310017, '吴磊', '男', 2004, 1005, 0, '云南', 'zjut302023310017');
INSERT INTO "public"."chenwk_student03" VALUES (302023310018, '周婷', '女', 2002, 1010, 0, '湖北', 'zjut302023310018');
INSERT INTO "public"."chenwk_student03" VALUES (302023310019, '刘静', '女', 2005, 1002, 0, '湖北', 'zjut302023310019');
INSERT INTO "public"."chenwk_student03" VALUES (302023310020, '刘静', '女', 2005, 1008, 0, '辽宁', 'zjut302023310020');
INSERT INTO "public"."chenwk_student03" VALUES (302023310021, '杨红', '女', 1999, 1008, 0, '新疆', 'zjut302023310021');
INSERT INTO "public"."chenwk_student03" VALUES (302023310022, '张敏', '女', 2002, 1004, 0, '河北', 'zjut302023310022');
INSERT INTO "public"."chenwk_student03" VALUES (302023310023, '杨红', '女', 2001, 1010, 0, '青海', 'zjut302023310023');
INSERT INTO "public"."chenwk_student03" VALUES (302023310024, '吴洁', '女', 1999, 1009, 0, '天津', 'zjut302023310024');
INSERT INTO "public"."chenwk_student03" VALUES (302023310025, '李伟', '男', 2000, 1003, 0, '陕西', 'zjut302023310025');
INSERT INTO "public"."chenwk_student03" VALUES (302023310026, '周伟', '男', 2004, 1008, 0, '山西', 'zjut302023310026');
INSERT INTO "public"."chenwk_student03" VALUES (302023310027, '李伟', '男', 2001, 1004, 0, '江西', 'zjut302023310027');
INSERT INTO "public"."chenwk_student03" VALUES (302023310028, '陈涛', '男', 2004, 1010, 0, '河北', 'zjut302023310028');
INSERT INTO "public"."chenwk_student03" VALUES (302023310029, '吴洁', '女', 2003, 1006, 0, '安徽', 'zjut302023310029');
INSERT INTO "public"."chenwk_student03" VALUES (302023310030, '杨红', '女', 2004, 1008, 0, '湖北', 'zjut302023310030');
INSERT INTO "public"."chenwk_student03" VALUES (302023310031, '陈丽', '女', 2000, 1002, 0, '海南', 'zjut302023310031');
INSERT INTO "public"."chenwk_student03" VALUES (302023310032, '杨杰', '男', 1999, 1009, 0, '天津', 'zjut302023310032');
INSERT INTO "public"."chenwk_student03" VALUES (302023310033, '刘洋', '男', 2000, 1008, 0, '湖北', 'zjut302023310033');
INSERT INTO "public"."chenwk_student03" VALUES (302023310034, '李娜', '女', 2005, 1004, 0, '福建', 'zjut302023310034');
INSERT INTO "public"."chenwk_student03" VALUES (302023310035, '杨杰', '男', 2000, 1005, 0, '北京', 'zjut302023310035');
INSERT INTO "public"."chenwk_student03" VALUES (302023310036, '陈涛', '男', 1999, 1001, 0, '吉林', 'zjut302023310036');
INSERT INTO "public"."chenwk_student03" VALUES (302023310037, '张敏', '女', 2004, 1008, 0, '浙江', 'zjut302023310037');
INSERT INTO "public"."chenwk_student03" VALUES (302023310038, '郑斌', '男', 2001, 1008, 0, '陕西', 'zjut302023310038');
INSERT INTO "public"."chenwk_student03" VALUES (302023310039, '杨红', '女', 2000, 1001, 0, '湖北', 'zjut302023310039');
INSERT INTO "public"."chenwk_student03" VALUES (302023310040, '李娜', '女', 2005, 1002, 0, '江西', 'zjut302023310040');
INSERT INTO "public"."chenwk_student03" VALUES (302023310041, '李娜', '女', 2003, 1001, 0, '江苏', 'zjut302023310041');
INSERT INTO "public"."chenwk_student03" VALUES (302023310042, '郑斌', '男', 2001, 1002, 0, '湖南', 'zjut302023310042');
INSERT INTO "public"."chenwk_student03" VALUES (302023310043, '吴磊', '男', 2005, 1003, 0, '云南', 'zjut302023310043');
INSERT INTO "public"."chenwk_student03" VALUES (302023310044, '吴磊', '男', 2002, 1008, 0, '重庆', 'zjut302023310044');
INSERT INTO "public"."chenwk_student03" VALUES (302023310045, '陈丽', '女', 2005, 1010, 0, '安徽', 'zjut302023310045');
INSERT INTO "public"."chenwk_student03" VALUES (302023310046, '郑艳', '女', 2003, 1001, 0, '云南', 'zjut302023310046');
INSERT INTO "public"."chenwk_student03" VALUES (302023310047, '刘洋', '男', 2004, 1004, 0, '湖北', 'zjut302023310047');
INSERT INTO "public"."chenwk_student03" VALUES (302023310048, '王磊', '男', 2000, 1003, 0, '吉林', 'zjut302023310048');
INSERT INTO "public"."chenwk_student03" VALUES (302023310049, '王磊', '男', 1999, 1003, 0, '山西', 'zjut302023310049');
INSERT INTO "public"."chenwk_student03" VALUES (302023310050, '陈丽', '女', 1999, 1004, 0, '福建', 'zjut302023310050');
INSERT INTO "public"."chenwk_student03" VALUES (302023310051, '周婷', '女', 1999, 1004, 0, '重庆', 'zjut302023310051');
INSERT INTO "public"."chenwk_student03" VALUES (302023310052, '郑艳', '女', 2004, 1004, 0, '安徽', 'zjut302023310052');
INSERT INTO "public"."chenwk_student03" VALUES (302023310053, '吴磊', '男', 2000, 1003, 0, '重庆', 'zjut302023310053');
INSERT INTO "public"."chenwk_student03" VALUES (302023310054, '张敏', '女', 1999, 1001, 0, '山东', 'zjut302023310054');
INSERT INTO "public"."chenwk_student03" VALUES (302023310055, '郑艳', '女', 2004, 1010, 0, '重庆', 'zjut302023310055');
INSERT INTO "public"."chenwk_student03" VALUES (302023310056, '周婷', '女', 1999, 1008, 0, '青海', 'zjut302023310056');
INSERT INTO "public"."chenwk_student03" VALUES (302023310057, '赵倩', '女', 2001, 1009, 0, '吉林', 'zjut302023310057');
INSERT INTO "public"."chenwk_student03" VALUES (302023310058, '周婷', '女', 1999, 1010, 0, '上海', 'zjut302023310058');
INSERT INTO "public"."chenwk_student03" VALUES (302023310059, '杨红', '女', 2003, 1005, 0, '北京', 'zjut302023310059');
INSERT INTO "public"."chenwk_student03" VALUES (302023310060, '刘洋', '男', 2004, 1010, 0, '辽宁', 'zjut302023310060');
INSERT INTO "public"."chenwk_student03" VALUES (302023310061, '陈涛', '男', 2003, 1001, 0, '内蒙古', 'zjut302023310061');
INSERT INTO "public"."chenwk_student03" VALUES (302023310062, '周伟', '男', 2003, 1008, 0, '重庆', 'zjut302023310062');
INSERT INTO "public"."chenwk_student03" VALUES (302023310063, '张敏', '女', 2003, 1003, 0, '贵州', 'zjut302023310063');
INSERT INTO "public"."chenwk_student03" VALUES (302023310064, '李娜', '女', 2002, 1006, 0, '安徽', 'zjut302023310064');
INSERT INTO "public"."chenwk_student03" VALUES (302023310065, '杨红', '女', 2004, 1002, 0, '新疆', 'zjut302023310065');
INSERT INTO "public"."chenwk_student03" VALUES (302023310066, '杨杰', '男', 2002, 1008, 0, '福建', 'zjut302023310066');
INSERT INTO "public"."chenwk_student03" VALUES (302023310067, '吴洁', '女', 1999, 1008, 0, '广东', 'zjut302023310067');
INSERT INTO "public"."chenwk_student03" VALUES (302023310068, '陈丽', '女', 2001, 1002, 0, '内蒙古', 'zjut302023310068');
INSERT INTO "public"."chenwk_student03" VALUES (302023310069, '吴洁', '女', 2005, 1001, 0, '甘肃', 'zjut302023310069');
INSERT INTO "public"."chenwk_student03" VALUES (302023310070, '赵倩', '女', 1999, 1004, 0, '黑龙江', 'zjut302023310070');
INSERT INTO "public"."chenwk_student03" VALUES (302023310071, '郑艳', '女', 2005, 1008, 0, '贵州', 'zjut302023310071');
INSERT INTO "public"."chenwk_student03" VALUES (302023310072, '王芳', '女', 2000, 1005, 0, '吉林', 'zjut302023310072');
INSERT INTO "public"."chenwk_student03" VALUES (302023310073, '陈涛', '男', 2002, 1008, 0, '浙江', 'zjut302023310073');
INSERT INTO "public"."chenwk_student03" VALUES (302023310074, '郑斌', '男', 2005, 1004, 0, '青海', 'zjut302023310074');
INSERT INTO "public"."chenwk_student03" VALUES (302023310075, '陈涛', '男', 2003, 1001, 0, '吉林', 'zjut302023310075');
INSERT INTO "public"."chenwk_student03" VALUES (302023310076, '李娜', '女', 2000, 1002, 0, '山西', 'zjut302023310076');
INSERT INTO "public"."chenwk_student03" VALUES (302023310077, '王磊', '男', 2002, 1005, 0, '黑龙江', 'zjut302023310077');
INSERT INTO "public"."chenwk_student03" VALUES (302023310078, '赵倩', '女', 2005, 1008, 0, '陕西', 'zjut302023310078');
INSERT INTO "public"."chenwk_student03" VALUES (302023310079, '周伟', '男', 2003, 1003, 0, '江西', 'zjut302023310079');
INSERT INTO "public"."chenwk_student03" VALUES (302023310080, '郑斌', '男', 2003, 1003, 0, '新疆', 'zjut302023310080');
INSERT INTO "public"."chenwk_student03" VALUES (302023310081, '陈涛', '男', 2005, 1003, 0, '河南', 'zjut302023310081');
INSERT INTO "public"."chenwk_student03" VALUES (302023310082, '王芳', '女', 2001, 1005, 0, '宁夏', 'zjut302023310082');
INSERT INTO "public"."chenwk_student03" VALUES (302023310083, '张敏', '女', 2002, 1009, 0, '陕西', 'zjut302023310083');
INSERT INTO "public"."chenwk_student03" VALUES (302023310084, '杨红', '女', 2003, 1009, 0, '江西', 'zjut302023310084');



-- UPDATE chenwk_student03
-- SET cwk_password03=123456
-- WHERE cwk_id03 = 302023315033 AND cwk_password03 = 'zjut302023315033';
-- ----------------------------
-- Table structure for chenwk_teacher03
-- ----------------------------
DROP TABLE IF EXISTS "public"."chenwk_teacher03";
CREATE TABLE "public"."chenwk_teacher03" (
  "cwk_id03" int4 NOT NULL,
  "cwk_name03" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "cwk_gender03" varchar(10) COLLATE "pg_catalog"."default",
  "cwk_birth_year03" int4,
  "cwk_title03" varchar(50) COLLATE "pg_catalog"."default",
  "cwk_college_id03" int4,
  "cwk_phone03" varchar(20) COLLATE "pg_catalog"."default",
  "cwk_password03" varchar(50) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of chenwk_teacher03
-- ----------------------------
INSERT INTO "public"."chenwk_teacher03" VALUES (20006, '李甜甜', '女', 2007, '教授', 10000, '15421854678', 'zjut20006');
INSERT INTO "public"."chenwk_teacher03" VALUES (20004, '邱杰凡', '男', 1980, '副教授', 10000, '15356746445', '123456');
INSERT INTO "public"."chenwk_teacher03" VALUES (20003, '朱明杰', '男', 1995, '辅导员', 10000, '15356749663', 'zjut20003');
INSERT INTO "public"."chenwk_teacher03" VALUES (20001, '党源杰', '男', 1995, '讲师', 10000, '15356474665', 'zjut20001');
INSERT INTO "public"."chenwk_teacher03" VALUES (20007, '王金虎', '男', 1980, '副教授', 10007, '16478964553', 'zjut20007');
INSERT INTO "public"."chenwk_teacher03" VALUES (20008, '熊丽荣', '女', 1986, '教授', 10000, '16478945663', 'zjut20008');
INSERT INTO "public"."chenwk_teacher03" VALUES (20009, '褚衍清', '男', 1984, '副教授', 10005, '16556472334', 'zjut20009');
INSERT INTO "public"."chenwk_teacher03" VALUES (20011, '管秋', '女', 1969, '教授', 10000, '16423121554', 'zjut20011');
INSERT INTO "public"."chenwk_teacher03" VALUES (20013, '陈晶莹', '女', 1989, '讲师', 10009, '16478965443', 'zjut20013');
INSERT INTO "public"."chenwk_teacher03" VALUES (20015, '陈仁涛', '男', 1975, '教授', 10009, '16432123446', 'zjut20015');
INSERT INTO "public"."chenwk_teacher03" VALUES (20019, '陈振波', '男', 1980, '副教授', 10000, '16432321663', 'zjut20019');
INSERT INTO "public"."chenwk_teacher03" VALUES (20020, '曾嵘', '女', 1978, '教授', 10010, '16432321221', 'zjut20020');
INSERT INTO "public"."chenwk_teacher03" VALUES (20010, '陈朋', '男', 1972, '教授', 10000, '15364859773', 'zjut20010');
INSERT INTO "public"."chenwk_teacher03" VALUES (20000, '高翔', '男', 1970, '院士', 10008, '14654978556', 'zjut20000');

-- 触发器11111111111111111111111111111111111111111111111111111111111111111111111111111
-- 学生删除后触发     班级人数-1   
DROP FUNCTION IF EXISTS "public"."decrease_student_count"();
CREATE OR REPLACE FUNCTION "public"."decrease_student_count"()
  RETURNS "pg_catalog"."trigger" AS $BODY$     --返回值是“触发器”
BEGIN
    UPDATE chenwk_class03
    SET cwk_count_of_students03 = cwk_count_of_students03 - 1
    WHERE cwk_id03 = OLD.cwk_class_id03;

    RETURN OLD;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE --语言  稳定性
  COST 100;    --执行代价

-- ----------------------------2222
-- 课程被删除时级联删除课程下所有学生的成绩
DROP FUNCTION IF EXISTS "public"."delete_score_record"();
CREATE OR REPLACE FUNCTION "public"."delete_score_record"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
DELETE FROM chenwk_score03
WHERE cwk_course_id03 = OLD.cwk_course_id03
AND cwk_student_id03 IN (SELECT cwk_id03 FROM chenwk_student03 WHERE cwk_class_id03 = OLD.cwk_class_id03);
RETURN OLD;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------33333
-- 开设课程  初始化学生成绩
DROP FUNCTION IF EXISTS "public"."generate_score_record"();
CREATE OR REPLACE FUNCTION "public"."generate_score_record"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
    INSERT INTO chenwk_score03 (cwk_student_id03, cwk_course_id03, cwk_teacher_id03, cwk_term03)
    SELECT chenwk_student03.cwk_id03, NEW.cwk_course_id03, NEW.cwk_teacher_id03, (SELECT cwk_term03 FROM chenwk_course03 WHERE cwk_id03 = NEW.cwk_course_id03)
    FROM chenwk_student03
    WHERE cwk_class_id03 = NEW.cwk_class_id03;

    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------444444
-- 插入学生时班级人数自动增加1
DROP FUNCTION IF EXISTS "public"."increment_student_count"();
CREATE OR REPLACE FUNCTION "public"."increment_student_count"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
    UPDATE chenwk_class03
    SET cwk_count_of_students03 = (cwk_count_of_students03 + 1)
    WHERE cwk_id03 = NEW.cwk_class_id03;

    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


-- ----------------------------555555
--成绩更新时自动更新学分 以及对应的重修判断  
DROP FUNCTION IF EXISTS "public"."update_credit"();
CREATE OR REPLACE FUNCTION "public"."update_credit"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
    IF (NEW.cwk_score03 >= 60 AND OLD.cwk_score03 IS NULL)
			OR (NEW.cwk_score03 >= 60 AND OLD.cwk_score03 < 60) THEN
        UPDATE chenwk_student03
        SET cwk_credits03 = cwk_credits03 + (SELECT cwk_credit03 FROM chenwk_course03 WHERE cwk_id03 = NEW.cwk_course_id03)
        WHERE cwk_id03 = NEW.cwk_student_id03;
    END IF; 

    IF NEW.cwk_score03 < 60 AND OLD.cwk_score03 IS NULL THEN
        UPDATE chenwk_score03
        SET cwk_retake03 = true  --重修
        WHERE cwk_student_id03 = NEW.cwk_student_id03;
    END IF;
    
    IF (NEW.cwk_score03 < 60 AND OLD.cwk_score03 >= 60) THEN
        UPDATE chenwk_student03
        SET cwk_credits03 = cwk_credits03 - (SELECT cwk_credit03 FROM chenwk_course03 WHERE cwk_id03 = NEW.cwk_course_id03)  --扣除课程相应的学分
        WHERE cwk_id03 = NEW.cwk_student_id03;
    END IF;

    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


-- 存储    mapper调用
DROP FUNCTION IF EXISTS "public"."admin_change_password"("new_password" varchar, "admin_id" int8);
CREATE OR REPLACE FUNCTION "public"."admin_change_password"("new_password" varchar, "admin_id" int8)
  RETURNS "pg_catalog"."void" AS $BODY$   --函数体开始标志    返回值为void
BEGIN
    UPDATE chenwk_admin03
    SET cwk_password03 = new_password
    WHERE cwk_id03 = admin_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- 选择直接在mapper接口上注解写入

-- -- 学生家乡统计
-- DROP FUNCTION IF EXISTS "public"."count_students_by_hometown"("p_hometown" text, OUT "p_count" int4);
-- CREATE OR REPLACE FUNCTION "public"."count_students_by_hometown"(IN "p_hometown" text, OUT "p_count" int4)
--   RETURNS "pg_catalog"."int4" AS $BODY$
-- DECLARE
--     result_count INT:=0;
-- BEGIN
--     SELECT COUNT(*) INTO result_count
--     FROM chenwk_student03
--     WHERE cwk_hometown03 = p_hometown;
--     RETURN result_count;
-- END$BODY$
--   LANGUAGE plpgsql VOLATILE
--   COST 100;

-- ----------------------------
-- 添加管理员
DROP FUNCTION IF EXISTS "public"."insert_admin"("new_id" int8, "new_password" varchar, "new_role" varchar);
CREATE OR REPLACE FUNCTION "public"."insert_admin"("new_id" int8, "new_password" varchar, "new_role" varchar)
  RETURNS "pg_catalog"."void" AS $BODY$ DECLARE 
BEGIN
    INSERT INTO chenwk_admin03(
        cwk_id03, cwk_password03, cwk_role03
    )
    VALUES (new_id, new_password, new_role);
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- 添加班级
DROP FUNCTION IF EXISTS "public"."insert_class"("new_id" int8, "new_name" varchar, "major_name" varchar, "head_teacher_id" int8);
CREATE OR REPLACE FUNCTION "public"."insert_class"("new_id" int8, "new_name" varchar, "major_name" varchar, "head_teacher_id" int8)
  RETURNS "pg_catalog"."void" AS $BODY$ DECLARE 
BEGIN
    INSERT INTO chenwk_class03(
        cwk_id03, cwk_name03, cwk_major_id03, cwk_head_teacher_id03
    )
    VALUES (new_id, new_name, (SELECT cwk_id03 FROM chenwk_major03 WHERE cwk_name03 = major_name), head_teacher_id);
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
--添加学院
DROP FUNCTION IF EXISTS "public"."insert_college"("new_id" int8, "new_name" varchar);
CREATE OR REPLACE FUNCTION "public"."insert_college"("new_id" int8, "new_name" varchar)
  RETURNS "pg_catalog"."void" AS $BODY$ DECLARE 
BEGIN
    INSERT INTO chenwk_college03(
        cwk_id03, cwk_name03
    )
    VALUES (new_id, new_name);
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- 添加课程
DROP FUNCTION IF EXISTS "public"."insert_course"("new_id" int8, "new_name" varchar, "college_name" varchar, "term" varchar, "exam_method" varchar, "credit" float8, "hours" int4, "new_attribute" varchar, "new_year" int4);
CREATE OR REPLACE FUNCTION "public"."insert_course"("new_id" int8, "new_name" varchar, "college_name" varchar, "term" varchar, "exam_method" varchar, "credit" float8, "hours" int4, "new_attribute" varchar, "new_year" int4)
  RETURNS "pg_catalog"."void" AS $BODY$ DECLARE 
BEGIN
    INSERT INTO chenwk_course03(
        cwk_id03, cwk_name03, cwk_term03, cwk_college_id03, cwk_examination_method03, cwk_credit03, cwk_hours03, cwk_attribute03, cwk_year03
    )
    VALUES (new_id, new_name, term, (SELECT cwk_id03 FROM chenwk_college03 WHERE cwk_name03 = college_name), exam_method, credit, hours, new_attribute, new_year);
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- 添加课程安排
DROP FUNCTION IF EXISTS "public"."insert_course_schedule"("course_name" varchar, "class_name" varchar, "teacher_id" int8);
CREATE OR REPLACE FUNCTION "public"."insert_course_schedule"("course_name" varchar, "class_name" varchar, "teacher_id" int8)
  RETURNS "pg_catalog"."void" AS $BODY$ DECLARE 
BEGIN
    INSERT INTO chenwk_course_schedule03(
        cwk_course_id03, cwk_class_id03, cwk_teacher_id03
    )
    VALUES ((SELECT cwk_id03 FROM chenwk_course03 WHERE cwk_name03 = course_name), (SELECT cwk_id03 FROM chenwk_class03 WHERE cwk_name03 = class_name), teacher_id);
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- 添加专业
DROP FUNCTION IF EXISTS "public"."insert_major"("new_id" int8, "new_name" varchar, "college_name" varchar);
CREATE OR REPLACE FUNCTION "public"."insert_major"("new_id" int8, "new_name" varchar, "college_name" varchar)
  RETURNS "pg_catalog"."void" AS $BODY$ DECLARE 
BEGIN
    INSERT INTO chenwk_major03(
        cwk_id03, cwk_name03, cwk_college_id03
    )
    VALUES (new_id, new_name, (SELECT cwk_id03 FROM chenwk_college03 WHERE cwk_name03 = college_name));
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- 添加学生
DROP FUNCTION IF EXISTS "public"."insert_student"("new_id" int8, "new_name" varchar, "gender" varchar, "birth_year" int4, "class_name" varchar, "hometown" varchar, "password" varchar);
CREATE OR REPLACE FUNCTION "public"."insert_student"("new_id" int8, "new_name" varchar, "gender" varchar, "birth_year" int4, "class_name" varchar, "hometown" varchar, "password" varchar)
  RETURNS "pg_catalog"."void" AS $BODY$
BEGIN
    INSERT INTO chenwk_student03(
        cwk_id03, cwk_name03, cwk_gender03, cwk_birth_year03, cwk_class_id03, cwk_hometown03, cwk_password03
    )
    VALUES (
        new_id, new_name, gender, birth_year, 
        (SELECT cwk_id03 FROM chenwk_class03 WHERE cwk_name03 = class_name), 
        hometown, password
    );
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- 添加老师
DROP FUNCTION IF EXISTS "public"."insert_teacher"("new_id" int8, "new_name" varchar, "gender" varchar, "birth_year" int4, "college_name" varchar, "phone" varchar, "title" varchar, "password" varchar);
CREATE OR REPLACE FUNCTION "public"."insert_teacher"("new_id" int8, "new_name" varchar, "gender" varchar, "birth_year" int4, "college_name" varchar, "phone" varchar, "title" varchar, "password" varchar)
  RETURNS "pg_catalog"."void" AS $BODY$ DECLARE 
BEGIN
    INSERT INTO chenwk_teacher03(
        cwk_id03, cwk_name03, cwk_gender03, cwk_birth_year03, cwk_college_id03, cwk_phone03, cwk_title03, cwk_password03
    )
    VALUES (new_id, new_name, gender, birth_year, (SELECT cwk_id03 FROM chenwk_college03 WHERE cwk_name03 = college_name), phone, title, password);
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


-- ----------------------------
--学生修改密码
DROP FUNCTION IF EXISTS "public"."student_change_password"("new_password" varchar, "student_id" int8);
CREATE OR REPLACE FUNCTION "public"."student_change_password"("new_password" varchar, "student_id" int8)
  RETURNS "pg_catalog"."void" AS $BODY$
BEGIN
    UPDATE chenwk_student03
    SET cwk_password03 = new_password
    WHERE cwk_id03 = student_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- 老师修改密码
DROP FUNCTION IF EXISTS "public"."teacher_change_password"("new_password" varchar, "teacher_id" int8);
CREATE OR REPLACE FUNCTION "public"."teacher_change_password"("new_password" varchar, "teacher_id" int8)
  RETURNS "pg_catalog"."void" AS $BODY$
BEGIN
    UPDATE chenwk_teacher03
    SET cwk_password03 = new_password
    WHERE cwk_id03 = teacher_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


-- ----------------------------
-- 更新录入成绩
DROP FUNCTION IF EXISTS "public"."update_score"("student_id" int8, "course_id" varchar, "teacher_id" int8, "score" float8, "term" varchar);
CREATE OR REPLACE FUNCTION "public"."update_score"("student_id" int8, "course_id" varchar, "teacher_id" int8, "score" float8, "term" varchar)
  RETURNS "pg_catalog"."void" AS $BODY$ DECLARE 
BEGIN
    INSERT INTO chenwk_score03(
        cwk_student_id03, cwk_course_id03, cwk_teacher_id03, cwk_score03, cwk_term03
    )
    VALUES (student_id, course_id, teacher_id, score, term)
    ON DUPLICATE KEY UPDATE cwk_score03 = score;
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- -------------------------------视图构建-------------------------
-- -------------------------------视图构建-------------------------
-- -------------------------------视图构建-------------------------
-- -------------------------------视图构建-------------------------

-- ----------------------------
-- View structure for chenwk_student_score
-- ----------------------------
DROP VIEW IF EXISTS "public"."chenwk_student_score";
CREATE VIEW "public"."chenwk_student_score" AS  SELECT chenwk_score03.cwk_course_id03, 
    chenwk_course03.cwk_name03 AS cwk_course_name03, chenwk_course03.cwk_credit03, 
    chenwk_score03.cwk_score03, chenwk_score03.cwk_retake03, 
    chenwk_score03.cwk_student_id03
   FROM chenwk_score03, chenwk_course03
  WHERE chenwk_score03.cwk_course_id03 = chenwk_course03.cwk_id03;

-- ----------------------------
-- View structure for chenwk_student_course_schedule
-- ----------------------------
DROP VIEW IF EXISTS "public"."chenwk_student_course_schedule";
CREATE VIEW "public"."chenwk_student_course_schedule" AS  SELECT DISTINCT chenwk_score03.cwk_course_id03, 
    chenwk_course03.cwk_name03 AS cwk_course_name03, chenwk_course03.cwk_credit03, 
    chenwk_score03.cwk_teacher_id03, 
    chenwk_teacher03.cwk_name03 AS cwk_teacher_name03, chenwk_course03.cwk_term03
   FROM chenwk_score03, chenwk_course03, chenwk_teacher03
  WHERE chenwk_score03.cwk_course_id03 = chenwk_course03.cwk_id03 AND chenwk_score03.cwk_teacher_id03 = chenwk_teacher03.cwk_id03;

-- ----------------------------
-- View structure for chenwk_student_score_term
-- ----------------------------
DROP VIEW IF EXISTS "public"."chenwk_student_score_term";
CREATE VIEW "public"."chenwk_student_score_term" AS  SELECT g.cwk_student_id03, g.cwk_term03, c.cwk_year03, 
    sum(g.cwk_score03 * c.cwk_credit03) AS cwk_total_score03, 
    sum(c.cwk_credit03) AS cwk_total_credit03
   FROM chenwk_score03 g
   JOIN chenwk_course03 c ON g.cwk_course_id03 = c.cwk_id03
  GROUP BY g.cwk_student_id03, g.cwk_term03, c.cwk_year03;

-- ----------------------------
-- View structure for chenwk_teacher_course_ave_score
-- ----------------------------
DROP VIEW IF EXISTS "public"."chenwk_teacher_course_ave_score";
CREATE VIEW "public"."chenwk_teacher_course_ave_score" AS
SELECT 
    chenwk_course03.cwk_id03 AS cwk_course_id03, 
    chenwk_course03.cwk_name03 AS cwk_course_name03, 
    chenwk_course03.cwk_term03, 
    ROUND(AVG(chenwk_score03.cwk_score03)::numeric, 2) AS cwk_avg_score03, 
    chenwk_course_schedule03.cwk_teacher_id03, 
    chenwk_teacher03.cwk_name03 AS cwk_teacher_name03
FROM 
    chenwk_course03, 
    chenwk_class03, 
    chenwk_course_schedule03, 
    chenwk_score03, 
    chenwk_teacher03
WHERE 
    chenwk_course03.cwk_id03 = chenwk_course_schedule03.cwk_course_id03 AND 
    chenwk_course_schedule03.cwk_class_id03 = chenwk_class03.cwk_id03 AND 
    chenwk_score03.cwk_course_id03 = chenwk_course03.cwk_id03 AND 
    chenwk_course_schedule03.cwk_teacher_id03 = chenwk_teacher03.cwk_id03
GROUP BY 
    chenwk_course03.cwk_id03, 
    chenwk_course03.cwk_name03, 
    chenwk_course03.cwk_term03, 
    chenwk_course_schedule03.cwk_teacher_id03, 
    chenwk_teacher03.cwk_name03;

--chenwk_teacher_course_schedule
DROP VIEW IF EXISTS "public"."chenwk_teacher_course_schedule";
CREATE VIEW "public"."chenwk_teacher_course_schedule" AS  SELECT chenwk_course03.cwk_id03 AS cwk_course_id03, 
    chenwk_course03.cwk_name03 AS cwk_course_name03, 
    chenwk_class03.cwk_name03 AS cwk_class_name03, 
    chenwk_course_schedule03.cwk_teacher_id03, chenwk_course03.cwk_year03, 
    chenwk_course03.cwk_term03, chenwk_teacher03.cwk_name03 AS cwk_teacher_name03
   FROM chenwk_course03, chenwk_class03, chenwk_course_schedule03, chenwk_teacher03
  WHERE chenwk_course03.cwk_id03 = chenwk_course_schedule03.cwk_course_id03 AND chenwk_course_schedule03.cwk_class_id03 = chenwk_class03.cwk_id03 AND chenwk_course_schedule03.cwk_teacher_id03 = chenwk_teacher03.cwk_id03;

--  chenwk_student_score_year
DROP VIEW IF EXISTS "public"."chenwk_student_score_year";
CREATE VIEW "public"."chenwk_student_score_year" AS  SELECT t.cwk_student_id03, t.cwk_year03, s.cwk_name03 AS cwk_student_name03, 
    sum(t.cwk_total_score03) / sum(t.cwk_total_credit03) AS cwk_gpa03, 
    sum(t.cwk_total_credit03) AS cwk_credit03, m.cwk_name03 AS cwk_major_name03, 
    c.cwk_name03 AS cwk_class_name03
   FROM chenwk_student_score_term t, chenwk_student03 s, chenwk_major03 m, 
    chenwk_class03 c
  WHERE s.cwk_id03 = t.cwk_student_id03 AND s.cwk_class_id03 = c.cwk_id03 AND c.cwk_major_id03 = m.cwk_id03
  GROUP BY s.cwk_name03, t.cwk_year03, t.cwk_student_id03, m.cwk_name03, c.cwk_name03;

--  chenwk_teacher_course_score
DROP VIEW IF EXISTS "public"."chenwk_teacher_course_score";
CREATE VIEW "public"."chenwk_teacher_course_score" AS  SELECT chenwk_student03.cwk_id03 AS cwk_student_id03, 
    chenwk_student03.cwk_name03 AS cwk_student_name03, 
    chenwk_teacher03.cwk_id03 AS cwk_teacher_id03, 
    chenwk_teacher03.cwk_name03 AS cwk_teacher_name03, 
    chenwk_class03.cwk_id03 AS cwk_class_id03, 
    chenwk_class03.cwk_name03 AS cwk_class_name03, 
    chenwk_course03.cwk_id03 AS cwk_course_id03, 
    chenwk_course03.cwk_name03 AS cwk_course_name03, chenwk_course03.cwk_term03, 
    chenwk_score03.cwk_score03, chenwk_score03.cwk_retake03
   FROM chenwk_course_schedule03
   JOIN chenwk_student03 ON chenwk_course_schedule03.cwk_class_id03 = chenwk_student03.cwk_class_id03
   JOIN chenwk_teacher03 ON chenwk_course_schedule03.cwk_teacher_id03 = chenwk_teacher03.cwk_id03
   JOIN chenwk_class03 ON chenwk_course_schedule03.cwk_class_id03 = chenwk_class03.cwk_id03
   JOIN chenwk_course03 ON chenwk_course_schedule03.cwk_course_id03 = chenwk_course03.cwk_id03
   LEFT JOIN chenwk_score03 ON chenwk_student03.cwk_id03 = chenwk_score03.cwk_student_id03 AND chenwk_course03.cwk_id03 = chenwk_score03.cwk_course_id03 AND chenwk_teacher03.cwk_id03;

-- chenwk_student_course
DROP VIEW IF EXISTS "public"."chenwk_student_course";
CREATE VIEW "public"."  " AS  SELECT chenwk_student03.cwk_id03 AS cwk_student_id03, 
    chenwk_course_schedule03.cwk_teacher_id03, 
    chenwk_teacher03.cwk_name03 AS cwk_teacher_name03, 
    chenwk_course_schedule03.cwk_course_id03, 
    chenwk_course03.cwk_name03 AS cwk_course_name03, chenwk_course03.cwk_credit03, 
    chenwk_course03.cwk_term03
   FROM chenwk_student03, chenwk_teacher03, chenwk_course03, chenwk_class03, 
    chenwk_course_schedule03
  WHERE chenwk_student03.cwk_class_id03 = chenwk_class03.cwk_id03 AND chenwk_course_schedule03.cwk_course_id03 = chenwk_course03.cwk_id03 AND chenwk_course_schedule03.cwk_teacher_id03 = chenwk_teacher03.cwk_id03 AND chenwk_course_schedule03.cwk_class_id03 = chenwk_class03.cwk_id03;

-- table chenwk_admin03
CREATE UNIQUE INDEX "index_admin_id" ON "public"."chenwk_admin03" USING btree (
  "cwk_id03" "pg_catalog"."int8_ops" ASC NULLS LAST
);
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
-- 主键和外键约束

-- ----------------------------
-- admin表中之内有一个id  only_index_admin_id   约束的名称
ALTER TABLE "public"."chenwk_admin03" ADD CONSTRAINT "only_index_admin_id" UNIQUE ("cwk_id03");

-- 主键 table chenwk_admin03
ALTER TABLE "public"."chenwk_admin03" ADD CONSTRAINT "chenwk_admin_pkey" PRIMARY KEY ("cwk_id03");


-- Uniques structure for table chenwk_class03   唯一id
ALTER TABLE "public"."chenwk_class03" ADD CONSTRAINT "only_index_class_id" UNIQUE ("cwk_id03");

-- 主键 for table chenwk_class03
ALTER TABLE "public"."chenwk_class03" ADD CONSTRAINT "chenwk_class_pkey" PRIMARY KEY ("cwk_id03");




-- index_class_name是 chenwk_class03 表中存储 cwk_name03 字段值的目录
-- 查找更快。
CREATE INDEX "index_college_name" ON "public"."chenwk_college03" USING hash (
  "cwk_name03" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);

-- Uniques structure for table chenwk_college03   唯一id
ALTER TABLE "public"."chenwk_college03" ADD CONSTRAINT "only_index_college_id" UNIQUE ("cwk_id03");

-- ----------------------------
-- Primary Key structure for table chenwk_college03
-- ----------------------------
ALTER TABLE "public"."chenwk_college03" ADD CONSTRAINT "chenwk_college_pkey" PRIMARY KEY ("cwk_id03");

-- Indexes structure for table chenwk_course03
--为多个查询条件频繁使用的字段创建索引，提升查询性能。
CREATE INDEX "index_course_attribute" ON "public"."chenwk_course03" USING hash (
  "cwk_attribute03" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);
CREATE INDEX "index_course_college_id" ON "public"."chenwk_course03" USING btree (      --bTree
  "cwk_college_id03" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "index_course_examination_method" ON "public"."chenwk_course03" USING hash (
  "cwk_examination_method03" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);
CREATE INDEX "index_course_name" ON "public"."chenwk_course03" USING hash (
  "cwk_name03" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);
CREATE INDEX "index_course_term" ON "public"."chenwk_course03" USING hash (
  "cwk_term03" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);

-- ----------------------------
-- Uniques structure for table chenwk_course03   唯一id
-- ----------------------------
ALTER TABLE "public"."chenwk_course03" ADD CONSTRAINT "only_index_course_id" UNIQUE ("cwk_id03");


-- Checks structure for table chenwk_course03
-- 限制字段的取值范围，确保数据的合法性和一致性
ALTER TABLE "public"."chenwk_course03" ADD CONSTRAINT "cwk_course_attribute" CHECK (((cwk_attribute03)::text = ANY ((ARRAY['选修课'::character varying, '必修课'::character varying, '通识课'::character varying, '体育课'::character varying])::text[])));
ALTER TABLE "public"."chenwk_course03" ADD CONSTRAINT "cwk_examination_method" CHECK (((cwk_examination_method03)::text = ANY ((ARRAY['考察'::character varying, '考试'::character varying])::text[])));

-- Primary Key structure for table chenwk_course03  主键
ALTER TABLE "public"."chenwk_course03" ADD CONSTRAINT "chenwk_course_pkey" PRIMARY KEY ("cwk_id03");

-- ----------------------------
-- Indexes structure for table chenwk_course_schedule03    方便快速查询    班级  课程  老师
CREATE INDEX "index_class_table_id" ON "public"."chenwk_course_schedule03" USING btree (
  "cwk_class_id03" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "index_course_table_id" ON "public"."chenwk_course_schedule03" USING btree (
  "cwk_course_id03" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);
CREATE INDEX "index_course_teacher_id" ON "public"."chenwk_course_schedule03" USING btree (
  "cwk_teacher_id03" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- Triggers structure for table chenwk_course_schedule03   
--  触发函数和触发事件  
CREATE TRIGGER "delete_score_trigger" AFTER DELETE ON "public"."chenwk_course_schedule03"
FOR EACH ROW
EXECUTE PROCEDURE "public"."delete_score_record"();
CREATE TRIGGER "generate_score_record_trigger" AFTER INSERT ON "public"."chenwk_course_schedule03"
FOR EACH ROW
EXECUTE PROCEDURE "public"."generate_score_record"();

-- 联合主键    table chenwk_course_schedule03  主键 
ALTER TABLE "public"."chenwk_course_schedule03" ADD CONSTRAINT "chenwk_course_schedule_pkey" PRIMARY KEY ("cwk_course_id03", "cwk_class_id03");

-- Indexes structure for table chenwk_major03
CREATE INDEX "index_major_name" ON "public"."chenwk_major03" USING hash (
  "cwk_name03" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);

ALTER TABLE "public"."chenwk_major03" ADD CONSTRAINT "only_index_major_id" UNIQUE ("cwk_id03");

ALTER TABLE "public"."chenwk_major03" ADD CONSTRAINT "cwk_major_pkey" PRIMARY KEY ("cwk_id03");

-- ----------------------------
-- Indexes structure for table chenwk_score03  快速查询  成绩相关信息
CREATE INDEX "index_course_id" ON "public"."chenwk_score03" USING btree (
  "cwk_course_id03" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
);
CREATE INDEX "index_student_id" ON "public"."chenwk_score03" USING btree (
  "cwk_student_id03" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "index_teacher_id" ON "public"."chenwk_score03" USING btree (
  "cwk_teacher_id03" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "index_term" ON "public"."chenwk_score03" USING hash (
  "cwk_term03" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);

-- ----------------------------
CREATE TRIGGER "update_credit_trigger" AFTER UPDATE ON "public"."chenwk_score03"
FOR EACH ROW
EXECUTE PROCEDURE "public"."update_credit"();

--    限制字段
ALTER TABLE "public"."chenwk_score03" ADD CONSTRAINT "cwk_score" CHECK (((cwk_score03 >= (0)::double precision) AND (cwk_score03 <= (100)::double precision)));

ALTER TABLE "public"."chenwk_score03" ADD CONSTRAINT "chenwk_score_pkey" PRIMARY KEY ("cwk_student_id03", "cwk_course_id03");

--  快速查询学生信息  班级 家乡 。。。。
CREATE INDEX "index_student_class_id" ON "public"."chenwk_student03" USING btree (
  "cwk_class_id03" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "index_student_hometown" ON "public"."chenwk_student03" USING btree (
  "cwk_hometown03" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "index_student_name" ON "public"."chenwk_student03" USING hash (
  "cwk_name03" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);

-- Triggers structure for table chenwk_student03        触发器函数1的调用
CREATE TRIGGER "decrease_class_trigger" AFTER DELETE ON "public"."chenwk_student03"
FOR EACH ROW
EXECUTE PROCEDURE "public"."decrease_student_count"();

CREATE TRIGGER "increment_class_trigger" AFTER INSERT ON "public"."chenwk_student03"
FOR EACH ROW
EXECUTE PROCEDURE "public"."increment_student_count"();

-- Uniques structure for table chenwk_student03
ALTER TABLE "public"."chenwk_student03" ADD CONSTRAINT "only_index_student_id" UNIQUE ("cwk_id03");

-- Checks structure for table chenwk_student03
ALTER TABLE "public"."chenwk_student03" ADD CONSTRAINT "cwk_student_gender" CHECK (((cwk_gender03)::text = ANY ((ARRAY['男'::character varying, '女'::character varying])::text[])));

-- Primary Key structure for table chenwk_student03
ALTER TABLE "public"."chenwk_student03" ADD CONSTRAINT "chenwk_student_pkey" PRIMARY KEY ("cwk_id03");

-- Indexes structure for table chenwk_teacher03
CREATE INDEX "index_teacher_college_id" ON "public"."chenwk_teacher03" USING btree (
  "cwk_college_id03" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "index_teacher_name" ON "public"."chenwk_teacher03" USING hash (
  "cwk_name03" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops"
);

-- Uniques structure for table chenwk_teacher03
ALTER TABLE "public"."chenwk_teacher03" ADD CONSTRAINT "only_index_teacher_id" UNIQUE ("cwk_id03");

-- 属性约束
-- Checks structure for table chenwk_teacher03
ALTER TABLE "public"."chenwk_teacher03" ADD CONSTRAINT "cwk_teacher_title" CHECK (((cwk_title03)::text = ANY ((ARRAY['教授'::character varying, '副教授'::character varying, '讲师'::character varying, '辅导员'::character varying, '院士'::character varying])::text[])));
ALTER TABLE "public"."chenwk_teacher03" ADD CONSTRAINT "cwk_teacher_gender" CHECK (((cwk_gender03)::text = ANY ((ARRAY['男'::character varying, '女'::character varying])::text[])));

-- 主键定义

-- ----------------------------
-- Primary Key structure for table chenwk_teacher03
-- ----------------------------
ALTER TABLE "public"."chenwk_teacher03" ADD CONSTRAINT "chenwk_teacher_pkey" PRIMARY KEY ("cwk_id03");

-- 外键定义

-- chenwk_class03 表的外键结构
-- 父表记录被删除后，将子表对应的外键字段设置为 NULL，避免丢失子表记录，保持数据完整性
ALTER TABLE "public"."chenwk_class03" ADD CONSTRAINT "fk_class_major" FOREIGN KEY ("cwk_major_id03") REFERENCES "public"."chenwk_major03" ("cwk_id03") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "public"."chenwk_class03" ADD CONSTRAINT "fk_class_teacher" FOREIGN KEY ("cwk_head_teacher_id03") REFERENCES "public"."chenwk_teacher03" ("cwk_id03") ON DELETE SET NULL ON UPDATE NO ACTION;

-- chenwk_course03 表的外键结构
-- 父表删除时将子表外键字段置空；更新时级联更新子表外键字段
ALTER TABLE "public"."chenwk_course03" ADD CONSTRAINT "fk_college_course" FOREIGN KEY ("cwk_college_id03") REFERENCES "public"."chenwk_college03" ("cwk_id03") ON DELETE SET NULL ON UPDATE CASCADE;

-- chenwk_course_schedule03 表的外键结构
-- 父表删除时，级联删除子表相关记录；更新时，级联更新子表外键字段
ALTER TABLE "public"."chenwk_course_schedule03" ADD CONSTRAINT "fk_course_table_class" FOREIGN KEY ("cwk_class_id03") REFERENCES "public"."chenwk_class03" ("cwk_id03") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."chenwk_course_schedule03" ADD CONSTRAINT "fk_course_table_course" FOREIGN KEY ("cwk_course_id03") REFERENCES "public"."chenwk_course03" ("cwk_id03") ON DELETE CASCADE ON UPDATE CASCADE;

-- chenwk_major03 表的外键结构
-- 父表删除时将子表外键字段置空；更新时级联更新子表外键字段
ALTER TABLE "public"."chenwk_major03" ADD CONSTRAINT "fk_college_major" FOREIGN KEY ("cwk_college_id03") REFERENCES "public"."chenwk_college03" ("cwk_id03") ON DELETE SET NULL ON UPDATE CASCADE;

-- chenwk_score03 表的外键结构
-- 父表删除时将子表外键字段置空或级联删除子表相关记录；更新时级联更新或置空子表外键字段
ALTER TABLE "public"."chenwk_score03" ADD CONSTRAINT "fk_score_course" FOREIGN KEY ("cwk_course_id03") REFERENCES "public"."chenwk_course03" ("cwk_id03") ON DELETE SET NULL ON UPDATE SET NULL;
ALTER TABLE "public"."chenwk_score03" ADD CONSTRAINT "fk_score_student" FOREIGN KEY ("cwk_student_id03") REFERENCES "public"."chenwk_student03" ("cwk_id03") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "public"."chenwk_score03" ADD CONSTRAINT "fk_score_teacher" FOREIGN KEY ("cwk_teacher_id03") REFERENCES "public"."chenwk_teacher03" ("cwk_id03") ON DELETE SET NULL ON UPDATE SET NULL;

-- chenwk_student03 表的外键结构
-- 父表删除时将子表外键字段置空；更新时禁止更新
ALTER TABLE "public"."chenwk_student03" ADD CONSTRAINT "fk_class_student" FOREIGN KEY ("cwk_class_id03") REFERENCES "public"."chenwk_class03" ("cwk_id03") ON DELETE SET NULL ON UPDATE NO ACTION;

-- chenwk_teacher03 表的外键结构
-- 父表删除时将子表外键字段置空；更新时级联更新子表外键字段
ALTER TABLE "public"."chenwk_teacher03" ADD CONSTRAINT "fk_college_teacher" FOREIGN KEY ("cwk_college_id03") REFERENCES "public"."chenwk_college03" ("cwk_id03") ON DELETE SET NULL ON UPDATE CASCADE;
