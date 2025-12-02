-- 3. 删除数据

-- (1) 删除学号为 20100022 的学生记录
DELETE FROM Student WHERE Sno = '20100022';

-- (2) 删除学号为 20100001 学生的 1 号课程选课记录
-- 将选课信息复制到一个临时表 tmpSC 中:
SELECT * INTO tmpSC FROM SC;
-- 在 tmpSC 中执行删除操作.
DELETE FROM tmpSC WHERE Sno = '20100001' AND Cno = '1';

-- (3) 删除临时表中 20100002 学生的全部选课记录
-- 请自己完成该操作.
DELETE FROM tmpSC WHERE Sno = '20100002';

-- (4) 删除计算机科学系所有学生的选课记录
DELETE FROM tmpSC WHERE 'CS' = (SELECT Sdept FROM Student WHERE Student.Sno = tmpSC.Sno);

-- (5) 删除全部选课记录
DELETE FROM tmpSC;

-- (6) 检查数据是否删除
SELECT * FROM Student;
SELECT * FROM SC;
SELECT * FROM tmpSC;
