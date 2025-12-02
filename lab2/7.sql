-- 3.4. 视图操作
-- 建立视图并基于视图进行查询

-- 1. 创建视图

-- (1) 建立学生基本信息视图
CREATE VIEW Student_VIEW(学号, 姓名, 性别, 年龄, 系, 班级) AS
  SELECT Sno, Sname, Ssex, Sage, Sdept, Sclass FROM Student;

-- (2) 建立学生均分视图
CREATE VIEW S_G(Sno, Gavg) AS
  SELECT Sno, AVG(Grade) FROM SC GROUP BY Sno;

-- (3) 建立选课信息视图
CREATE VIEW XK_VIEW AS
  SELECT Student.*, Course.*, Grade
  FROM Student, SC, Course
  WHERE Student.Sno = SC.Sno AND SC.Cno = Course.Cno;

-- 2. 视图查询

-- (1) 查询学生基本信息
SELECT * FROM Student_VIEW;

-- (2) 找出每个学生超过他选修课程平均成绩的课程号
SELECT SC.Sno, Cno, Grade
  FROM SC, S_G
  WHERE SC.Sno = S_G.Sno AND Grade > S_G.Gavg;

-- (3) 查询每个学生的学号, 姓名, 选修的课程名及成绩
SELECT Sno, Sname, Cname, Grade FROM XK_VIEW;

-- (4) 比较使用视图查询和直接从基表查询的优点
-- 略

