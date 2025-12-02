-- 3.2. 数据操作

-- 1. 插入数据
-- 向数据库相应的表中插入数据.

-- (1) 插入到 Student 表
INSERT INTO Student VALUES ('20100001', '李勇', '男', 20, 'CS', '1001');
INSERT INTO Student VALUES ('20100002', '刘晨', '女', 19, 'CS', '1001');
INSERT INTO Student(Sno, Sname, Ssex, Sage, Sdept, Sclass) VALUES ('20100021', '王敏', '女', 18, 'MA', '1002');
INSERT INTO Student(Sno, Sname, Ssex, Sage, Sdept, Sclass) VALUES ('20100031', '张立', '男', 19, 'IS', '1003');
INSERT INTO Student(Sno, Sname, Ssex, Sclass) VALUES ('20100003', '刘洋', '女', '1001');
INSERT INTO Student(Sno, Sname, Ssex, Sage, Sdept, Sclass) VALUES ('20100010', '赵斌', '男', 19, 'IS', '1005');
INSERT INTO Student VALUES ('20100022', '张明明', '男', 19, 'CS', '1002');

-- (2) 插入到 Course 表
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('1', '数据库系统原理', '5', 4);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('2', '高等数学', NULL, 2);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('3', '管理信息系统', '1', 4);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('4', '操作系统原理', '6', 3);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('5', '数据结构', '7', 4);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('6', '数据处理', NULL, 2);
INSERT INTO Course(Cno, Cname, Cpno, Ccredit) VALUES ('7', 'C语言', NULL, 4);

-- (3) 插入到 SC 表
INSERT INTO SC VALUES ('20100001', '1', 92);
INSERT INTO SC VALUES ('20100002', '2', 80);
INSERT INTO SC(Sno, Cno) VALUES ('20100003', '1');
INSERT INTO SC(Sno, Cno, Grade) VALUES ('20100010', '3', NULL);
INSERT INTO SC VALUES ('20100001', '2', 85);
INSERT INTO SC VALUES ('20100001', '3', 88);
INSERT INTO SC VALUES ('20100002', '3', 90);

-- (4) 多行插入到表中
-- 创建存一个表, 保存学生的学号, 姓名和年龄:
CREATE TABLE cs_Student (
    学号 CHAR(8),
    姓名 CHAR(8),
    年龄 SMALLINT
);
-- 插入数据行
INSERT INTO cs_Student
    SELECT Sno, Sname, Sage
    FROM Student WHERE Sdept = 'CS';

-- (5) 检查插入到表中的数据
SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM SC;
