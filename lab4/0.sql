-- 一. 声明完整性约束
-- 创建学生选课数据库 TEST, 包括三个基本表,
-- 其中 Student 表保存学生基本信息, Course 表保存课程信息,
-- SC 表保存学生选课信息.
CREATE DATABASE TEST;

-- 1. 创建基本表及约束

-- (1) 创建 Student 表
CREATE TABLE Student (
  Sno CHAR(8) PRIMARY KEY,
  Sname CHAR(8) NOT NULL,
  Ssex CHAR(2) CHECK(Ssex IN ('男', '女')),
  Sage SMALLINT,
  Sdept CHAR(20),
  Sclass CHAR(4) NOT NULL,
  Stotal SMALLINT DEFAULT 0
);

-- (2) 创建 Course 表
CREATE TABLE Course (
  Cno CHAR(4) CONSTRAINT FK_Course PRIMARY KEY,
  Cname CHAR(40),
  Cpno CHAR(4),
  Ccredit SMALLINT
);

-- (3) 创建 SC 表
CREATE TABLE SC (
  Sno CHAR(8),
  Cno CHAR(4),
  Grade SMALLINT CONSTRAINT SC_CHECK CHECK (Grade > 0 AND Grade < 100),
  PRIMARY KEY (Sno, Cno),
  FOREIGN KEY (Sno) REFERENCES Student(Sno),
  CONSTRAINT FK_SC FOREIGN KEY (Cno) REFERENCES Course(Cno)
);

-- 2. 插入数据

-- (1) 插入学生信息到 Student 表
INSERT INTO Student VALUES ('20100001', '李勇', '男', 20, 'CS', '1001', 0);
INSERT INTO Student VALUES ('20100002', '刘晨', '女', 19, 'CS', '1001', 0);
INSERT INTO Student VALUES ('20100021', '王敏', '女', 18, 'MA', '1002', 0);
INSERT INTO Student VALUES ('20100031', '张立', '男', 19, 'IS', '1003', 0);
INSERT INTO Student(Sno, Sname, Ssex, Sclass, Stotal)
  VALUES ('20100003', '刘洋', '女', '1001', 0);
INSERT INTO Student VALUES ('20100010', '赵斌', '男', 19, 'IS', '1005', 0);
INSERT INTO Student VALUES ('20100022', '张明明', '男', 19, 'CS', '1002', 0);

-- (2) 插入课程信息到 Course 表
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('1', '数据库系统原理', '5', 4);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('2', '高等数学', NULL, 2);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('3', '管理信息系统', '1', 4);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('6', '数据处理', NULL, 2);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('7', 'C语言', NULL, 4);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('4', '操作系统原理', '6', 3);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('5', '数据结构', '7', 4);

-- (3) 插入到 SC 表
INSERT INTO SC VALUES ('20100001', '1', 92);
INSERT INTO SC VALUES ('20100002', '2', 82);
INSERT INTO SC VALUES ('20100002', '1', 90);
INSERT INTO SC VALUES ('20100001', '2', 85);
INSERT INTO SC VALUES ('20100001', '3', 88);
INSERT INTO SC VALUES ('20100003', '1', NULL);
INSERT INTO SC VALUES ('20100010', '3', NULL);

-- (4) 检查插入到表中的数据
SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM SC;

-- 3. 修改约束

-- (1) 添加约束
ALTER TABLE Course ADD UNIQUE (Cname);
ALTER TABLE Course ADD FOREIGN KEY (Cpno) REFERENCES Course(Cno);

-- (2) 修改约束
ALTER TABLE SC DROP CONSTRAINT SC_CHECK;
ALTER TABLE SC ADD CONSTRAINT SC_CHECK CHECK (Grade >= 0 AND Grade <= 100);

