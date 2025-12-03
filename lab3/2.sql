-- 3.4. 撤销权限

-- (1) 撤销权限
-- 以系统管理员账号登录, 撤销 "李刚" 对 Student 表的权限:
REVOKE SELECT ON Student FROM ligang;
REVOKE INSERT, UPDATE, DELETE ON Student FROM ligang;

-- (2) 检查权限
-- 以 "李刚" 账号登录, 检查如下的命令能否正确地运行:
SELECT * FROM Student;
INSERT INTO Student(Sno, Sname, Sclass) VALUES ('20101501', '赵光', '1008');
UPDATE Student SET Sage = Sage + 1;
DELETE FROM Student WHERE Sno = '20101501';

