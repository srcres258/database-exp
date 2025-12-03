-- 3.3 检查权限控制

-- 1. 检查王明的权限
-- 以用户 "王明" 登录, 执行如下的操作, 检查能否正确地运行:
SELECT * FROM Student;
INSERT INTO Student(Sno, Sname, Sclass) VALUES ('20101101', '高志', '1008');
UPDATE Student SET Sage = Sage + 1;
DELETE FROM Student WHERE Sno = '20101010';
SELECT * FROM Course;
SELECT * FROM SC;

-- 2. 检查李刚的权限
-- 以用户 "李刚" 登录, 执行如下的操作, 检查能否正确地运行:
SELECT * FROM Student;
INSERT INTO Student(Sno, Sname, Sclass) VALUES ('20101101', '高志', '1008');
UPDATE Student SET Sage = Sage + 1;
DELETE FROM Student WHERE Sno = '20101010';
SELECT * FROM Course;
INSERT INTO Course VALUES ('20', 'FORTRAN语言', NULL, 2);
UPDATE Course SET Ccredit = 3 WHERE Cno = '2';
DELETE FROM Course WHERE Cno = '6';

-- 3. 增加李刚的权限
-- 以用户 "李刚" 登录, 执行如下的操作:

-- (1) 检查李刚能否对 SC 表执行查询, 插入, 修改, 删除操作
SELECT * FROM SC;
INSERT INTO SC VALUES ('20100010', '1', '85');
UPDATE SC SET Grade = 90 WHERE Sno = '20100010' AND Cno = '1';
DELETE FROM SC WHERE Sno = '20100010' AND Cno = '1';

-- (2) 使用管理员账号给李刚授予对 SC 表的查询, 插入, 修改, 删除权限
GRANT SELECT, INSERT, UPDATE, DELETE ON SC TO ligang;

-- (3) 再次检查李刚能否对 SC 表执行查询, 插入, 修改, 删除操作
SELECT * FROM SC;
INSERT INTO SC VALUES ('20100010', '1', '85');
UPDATE SC SET Grade = 90 WHERE Sno = '20100010' AND Cno = '1';
DELETE FROM SC WHERE Sno = '20100010' AND Cno = '1';

