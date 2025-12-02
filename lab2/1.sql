-- 2. 创建索引

-- (1) 为 Course 表按课程名称创建索引
CREATE INDEX iCname ON Course(Cname);

-- (2) 为 Student 表按学生姓名创建唯一索引
CREATE UNIQUE INDEX iSname ON Student(Sname);

-- (3) 为 SC 表按学号和课程号创建聚集索引
--CREATE CLUSTERED INDEX iSnoCno ON SC(Sno, Cno DESC);
-- 注: 此处 PostgreSQL 与 SQL Server 的语法完全不同,
-- 在 PostgreSQL 中需如下操作.
-- 首先创建普通索引 (非聚集)
CREATE INDEX iSnoCno ON SC(Sno, Cno DESC);
-- 然后使用 CLUSTER 命令, 基于该索引重新组织表数据
CLUSTER SC USING iSnoCno;
-- 最后设置默认聚集索引 (optional, 但是建议设置)
ALTER TABLE SC CLUSTER ON iSnoCno;

-- (4) 为 Course 表按课程号创建唯一索引
CREATE UNIQUE INDEX iCno ON Course(Cno);
