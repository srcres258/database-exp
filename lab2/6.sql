-- 3.3. 数据查询操作
-- 完成如下查询操作:

-- 1. 单表查询

-- (1) 按指定目标列查询
-- 查询学生的详细记录
SELECT * FROM Student;
-- 查询学生的学号, 姓名和年龄
SELECT Sno, Sname, Sage FROM Student;

-- (2) 目标列包含表达式的查询
-- 查询全体学生的姓名, 出生年份和所有系, 要求用小写字母表示所有系名.
SELECT Sname, 'Year of Birth:' as BIRTH, 2000-Sage BIRTHDAY, LOWER(Sdept) FROM Student;

-- (3) 查询结果集中修改列名称
-- 查询全体学生的姓名, 出生年份和所有系, 要求用小写字母表示所有系名.
SELECT Sname, 'Year of Birth:' as BIRTH, 2000-Sage BIRTHDAY, LOWER(Sdept) as DEPARTMENT FROM Student;

-- (4) 取消重复行
-- 查询选修了课程的学生学号: 比较 ALL 和 DISTINCT 的区别
SELECT Sno FROM SC;
SELECT DISTINCT Sno FROM SC;

-- (5) 简单条件查询
-- 查询计算机科学系全体学生的名单
SELECT Sname FROM Student WHERE Sdept = 'CS';

-- (6) 按范围查询
-- 查询年龄在 20 ~ 23 岁之间的学生的姓名, 系别和年龄
SELECT Sname, Sdept, Sage FROM Student WHERE Sage BETWEEN 20 AND 23;

-- (7) 查询属性值属于指定集合的行
-- 查询信息系 (IS), 数学系 (MA) 和计算机科学系 (CS) 学生的姓名和性别
SELECT Sname, Ssex FROM Student WHERE Sdept IN ('IS', 'MA', 'CS');

-- (8) 模糊查询
-- 查询所有姓刘学生的姓名, 学号和性别
SELECT Sname, Sno, Ssex FROM Student WHERE Sname LIKE '刘%';

-- (9) 查询空值
-- 查询缺少成绩的学生的学号和相应的课程号
SELECT Sno, Cno FROM SC WHERE Grade IS NULL;

-- (10) 多重条件查询
-- 查询计算机科学系年龄在 20 岁以下的学生姓名
SELECT Sname FROM Student WHERE Sdept = 'CS' AND Sage < 20;

-- (11) 结果集排序
-- 查询全体学生情况, 查询结果按所在系的系号升序排列, 同一系中的学生按年龄降序排列
SELECT * FROM Student ORDER BY Sdept, Sage DESC;

-- (12) 完成下列查询
-- 查询学生基本信息, 结果集属性名使用汉字
SELECT Sno AS 学号, Sname AS 姓名, Ssex AS 性别, Sage AS 年龄, Sdept AS 系别 FROM Student;
-- 查询信息系且年龄大于 23 岁同学的学号和姓名
SELECT Sno, Sname FROM Student WHERE Sdept = 'IS' AND Sage > 23;
-- 查询年龄是 17, 18, 20, 23 岁的同学的学号, 姓名, 年龄和所在系
SELECT Sno, Sname, Sage, Sdept FROM Student WHERE Sage IN (17, 18, 20, 23);
-- 查询年龄不在 21 ~ 24 岁之间的学生的姓名, 系别和年龄
SELECT Sname, Sdept, Sage FROM Student WHERE Sage NOT BETWEEN 21 AND 24;

-- 2. 分组统计

-- (1) 聚集函数的使用
-- 查询学生总人数
SELECT COUNT(*) FROM Student;
-- 查询选修了课程的学生人数
SELECT COUNT(DISTINCT Sno) FROM SC;
-- 查询最高分
SELECT MAX(Grade) FROM SC;

-- (2) 聚集函数作用于部分行
-- 统计 2 号课程的总分, 均分和最高分
SELECT SUM(Grade) 总分, AVG(Grade) 均分, MAX(Grade) 最高分 FROM SC WHERE Cno = '2';

-- (3) 分组统计
-- 统计各门课程的选课人数, 均分和最高分
SELECT Cno 课程号, COUNT(*) 人数, AVG(Grade) 均分, MAX(Grade) 最高分 FROM SC GROUP BY Cno;
-- 统计均分大于 90 的课程
SELECT Cno 课程号, COUNT(*) 人数, AVG(Grade) 均分, MAX(Grade) 最高分 FROM SC GROUP BY Cno HAVING AVG(Grade) > 90;

-- (4) 完成下面的查询
-- 统计每个同学的学号, 选课数, 平均成绩和最高成绩
SELECT Sno 学号, COUNT(*) 选课数, AVG(Grade) 平均成绩, MAX(Grade) 最高成绩 FROM SC GROUP BY Sno;
-- 统计每个班的每门课的选课人数, 平均成绩和最高成绩
SELECT Cno 课程号, COUNT(*) 选课人数, AVG(Grade) 平均成绩, MAX(Grade) 最高成绩 FROM SC GROUP BY Cno, Sno;

-- 3. 连接查询

-- (1) 在 WHERE 中指定连接条件
-- 查询每个参加选课的学生信息及其选修课程的情况
SELECT Student.Sno, Sname, Ssex, Sage, Sdept, Cno, Grade
    FROM Student, SC WHERE Student.Sno = SC.Sno;
-- 查询每一门课的间接选修课
SELECT * FROM Course first, Course second
    WHERE first.Cpno = second.Cno;
SELECT first.Cno, second.Cpno FROM Course first, Course second
    WHERE first.Cpno = second.Cno;

-- (2) 在 FROM 中指定连接条件
-- 查询每个参加选课的学生信息及其选秀课程的情况
SELECT Student.Sno, Sname, Ssex, Sage, Sdept, Cno, Grade
    FROM Student JOIN SC ON (Student.Sno = SC.Sno);

-- (3) 使用外连接查询
-- 查询每个学生信息及其选修课程的情况
SELECT Student.Sno, Sname, Ssex, Sage, Sdept, Cno, Grade
    FROM Student LEFT OUTER JOIN SC ON (Student.Sno = SC.Sno);

-- (4) 复合条件连接查询
-- 查询选修 2 号课程且成绩在 90 分以上的所有学生
SELECT Student.Sno, Sname
    FROM Student JOIN SC ON (Student.Sno = SC.Sno) -- 连接条件
    WHERE SC.Cno = '2' AND SC.Grade > 90; -- 过滤条件

-- (5) 多表查询
-- 查询每个学生的学号, 姓名, 选修的课程名及成绩
SELECT Student.Sno, Sname, Cname, Grade
    FROM Student, SC, Course
    WHERE Student.Sno = SC.Sno AND SC.Cno = Course.Cno;

-- (6) 完成下列查询
-- 查询选修了 2 号课程的学号, 姓名, 选修的课程名及成绩
SELECT Student.Sno, Sname, Cname, Grade
    FROM Student, SC, Course
    WHERE Student.Sno = SC.Sno AND SC.Cno = Course.Cno AND SC.Cno = '2';
-- 查询各门课程的课程号, 课程名称以及选课学生的学号
SELECT Course.Cno, Course.Cname, SC.Sno FROM Course, SC;
-- 查询选修了数据库系统原理课程的同学的学号和姓名和成绩
SELECT SC.Sno, Student.Sname, SC.Grade
    FROM SC, Student
    WHERE SC.Sno = Student.Sno AND SC.Cno = (SELECT Cno FROM Course WHERE Cname = '数据库系统原理');

-- 4. 嵌套查询

-- (1) 由 In 引出的子查询
-- 查询与 "刘晨" 在同一个系学习的学生
SELECT Sno, Sname, Sdept FROM Student
    WHERE Sdept IN (SELECT Sdept FROM Student WHERE Sname = '刘晨');

-- (2) 由比较运算符引出的子查询
-- 找出每个学生超过他选修课程平均成绩的课程号.
SELECT Sno, Cno FROM SC x
    WHERE Grade >= (SELECT AVG(Grade) FROM SC y
        WHERE x.Sno = y.Sno);

-- (3) 带修饰符的比较运算符引出的子查询
-- 查询其他系中比计算机科学系所有学生年龄都小的学生姓名及年龄.
SELECT Sname, Sage FROM Student
    WHERE Sage < ALL (SELECT Sage FROM Student WHERE Sdept = 'CS')
        AND Sdept <> 'CS';

-- (4) 由 EXISTS 引出的子查询
-- 查询所有选修了1号课程的学生姓名
SELECT Sname FROM Student
    WHERE EXISTS (SELECT * FROM SC WHERE Sno = Student.Sno AND Cno = '1');

-- 5. 集合查询

-- (1) 集合并
-- 查询计算机科学系的学生及年龄不大于19岁的学生
SELECT * FROM Student WHERE Sdept = 'CS' UNION
    SELECT * FROM Student WHERE Sage <= 19;

-- (2) 集合交
-- 查询计算机科学系且年龄不大于19岁的学生
SELECT * FROM Student WHERE Sdept = 'CS' INTERSECT
    SELECT * FROM Student WHERE Sage <= 19;

-- (3) 集合差
-- 查询计算机科学系且年龄大于19岁的学生
SELECT * FROM Student WHERE Sdept = 'CS' EXCEPT
    SELECT * FROM Student WHERE Sage <= 19;

-- TODO
