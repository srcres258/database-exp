-- 二. 检查完整性约束
-- 通过修改数据库中的数据检查完整性约束条件的作用.

-- 1. 检查主键约束

-- (1) 执行下面的语句修改 Student 表, 观察语句能否正确运行, 解释为什么?
INSERT INTO Student VALUES ('20100101', '李斌', '男', 20, 'CS', '1001', 0);
INSERT INTO Student VALUES ('20100001', '李斌', '男', 20, 'CS', '1001', 0);
UPDATE Student SET Sno = '20100021' WHERE Sname = '张立';

-- (2) 执行下面的语句修改 SC 表, 观察语句能否正确运行, 解释为什么?
INSERT INTO SC VALUES ('20100001', '1', 78);
INSERT INTO SC VALUES ('20100001', NULL, 78);

-- 2. 检查唯一约束
-- 执行下面的语句修改 Course 表, 观察语句能否正确运行, 解释为什么?
INSERT INTO Course VALUES ('8', 'JAVA', 7, 3);
INSERT INTO Course VALUES ('9', '数据结构', 7, 3);

-- 3. 检查默认值, 允许空值列
-- 运行如下的语句:
INSERT INTO Student(Sno, Sname, Ssex, Sclass) VALUES ('20100102', '张盛', '男', '1008');
-- 观察插入数据行的数值
SELECT * FROM Student WHERE Sno = '20100102';

-- 4. 检查非空约束
-- 下面的语句包含空值, 检查运行结果, 解释为什么?
INSERT INTO Student(Sno, Sname, Ssex, Sclass) VALUES ('20100103', '张盛', '男', NULL);
INSERT INTO Student(Sno, Sname, Ssex) VALUES ('20100104', '张盛', '男');

-- 5. 检查 CHECK 约束
-- 执行下面的语句, 解释其运行结果.
INSERT INTO SC VALUES ('20100001', '4', 95);
INSERT INTO SC VALUES ('20100001', '4', 102);
INSERT INTO Student(Sno, Sname, Ssex, Sclass) VALUES ('20100103', '张盛', '男', '1008');
INSERT INTO Student(Sno, Sname, Ssex, Sclass) VALUES ('20100104', '张盛', '', '1008');

-- 6. 检查外键约束

-- (1) 执行下面的语句检查外键约束的作用
INSERT INTO SC VALUES ('20100301', '1', 95);
INSERT INTO SC VALUES ('20100001', '10', 95);
UPDATE SC SET Cno = '10' WHERE Cno = '1';
UPDATE Course SET Cno = '10' WHERE Cno = '3';

-- (2) 执行下面的语句检查对被引用表的约束
DELETE Student WHERE Sno = '20100021';
DELETE Student WHERE Sno = '20100001';
UPDATE Course SET Cno = '10' WHERE Cname = '数据库系统原理';

-- 三. 触发器的定义及使用

-- 1. 定义触发器

-- (1) 定义一个触发器, 实现有关学分的完整性约束: 当向 SC 表插入一行选课记录时,
-- 自动将该课程的学分累加到该学生的总学分中.

-- 先创建触发函数
CREATE OR REPLACE FUNCTION tr_insert_sc()
RETURNS trigger AS
$$
DECLARE
    credit INT;  -- 声明变量（无需@前缀）
BEGIN
    -- 从Course表提取学分（使用NEW访问插入的行数据，无需inserted表）
    SELECT Ccredit INTO credit
    FROM Course
    WHERE Cno = NEW.Cno;  -- NEW.Cno对应插入行的Cno

    -- 更新Student表的总学分
    UPDATE Student
    SET Stotal = Stotal + credit
    WHERE Sno = NEW.Sno;  -- NEW.Sno对应插入行的Sno

    RETURN NEW;  -- 对于AFTER INSERT，返回NEW表示继续操作
END;
$$
LANGUAGE plpgsql;

-- 然后创建触发器，调用该函数
CREATE TRIGGER tr_INSERT
AFTER INSERT ON SC
FOR EACH ROW
EXECUTE FUNCTION tr_insert_sc();

-- (2) 定义一个触发器, 实现对 SC 表的操作登记: 当用户向 SC 表插入或修改时, 记录该操作到数据库中.

-- 创建日志登记表
CREATE TABLE LOG_TABLE (
  username CHAR(10),
  date TIMESTAMPTZ,
  Sno CHAR(8),
  Cno CHAR(4)
);

-- 创建日志触发器

-- 先创建触发函数
CREATE OR REPLACE FUNCTION tr_log_sc()
RETURNS TRIGGER AS
$$
DECLARE
  new SMALLINT;
BEGIN
  INSERT INTO LOG_TABLE VALUES (CURRENT_USER, CURRENT_TIMESTAMP, NEW.Sno, NEW.Cno);
  RETURN NULL;
END;
$$
LANGUAGE plpgsql;

-- 然后创建触发器, 调用该函数
CREATE TRIGGER tr_UPDATE
AFTER INSERT OR UPDATE ON SC
FOR EACH ROW
EXECUTE FUNCTION tr_log_sc();

-- (3) 执行插入操作, 触发触发器:
INSERT INTO SC VALUES ('20100001', '6', 95);

-- (4) 验证触发器是否触发
SELECT * FROM Student;
SELECT * FROM LOG_TABLE;

