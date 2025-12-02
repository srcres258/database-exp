-- 3. 创建视图
-- 建立信息系学生的视图:
CREATE VIEW IS_Student
AS
    SELECT Sno, Sname, Sage FROM Student
    WHERE Sdept = 'IS';

