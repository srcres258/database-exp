-- 2. 修改数据

-- (1) 将学生 20100001 的年龄修改为 22 岁.
UPDATE Student SET Sage = 22 WHERE Sno = '20100001';

-- (2) 将所有学生的年龄增加一岁.
UPDATE Student SET Sage = Sage + 1;

-- (3) 填写赵斌同学的管理信息系统课程的成绩.
UPDATE SC SET Grade = 85
    WHERE Sno = '20100010' AND Cno = '3';

-- (4) 将计算机科学系全体学生的成绩加 5 分.
UPDATE SC SET Grade = Grade + 5
    WHERE 'CS' = (SELECT Sdept FROM Student WHERE Student.Sno = SC.Sno);

-- (5) 请自己完成如下操作
-- 将刘晨同学的 2 号课程成绩修改为 80.
UPDATE SC SET Grade = 80
    WHERE Sno = '20100002' AND Cno = '2';
-- 将 "20100021" 同学的学号修改为 "20100025".
UPDATE Student SET Sno = '20100025'
    WHERE Sno = '20100021';

-- (6) 检查数据是否修改
SELECT * FROM Student;
SELECT * FROM SC;
