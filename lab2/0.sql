/* 实验二  SQL 高级查询 */

-- 3.1. 数据定义

-- 1. 基本表的创建, 修改及删除

-- (1) 创建 Student 表
CREATE TABLE Student (
    Sno CHAR(8) PRIMARY KEY,
    Sname CHAR(8),
    Ssex CHAR(2) NOT NULL,
    Sage INT,
    Sdept CHAR(20)
);

-- (2) 创建 Course 表
CREATE TABLE Course (
    Cno CHAR(4) PRIMARY KEY,
    Cname CHAR(40) NOT NULL,
    Cpno CHAR(4),
    Ccredit SMALLINT
);

-- (3) 创建 SC 表
CREATE TABLE SC (
    Sno CHAR(8),
    Cno CHAR(4),
    Grade SMALLINT,
    PRIMARY KEY (Sno, Cno),
    FOREIGN KEY (Sno) REFERENCES Student(Sno),
    FOREIGN KEY (Cno) REFERENCES Course(Cno)
);

-- (4) 创建员工表 Employee
CREATE TABLE Employee (
    编号 CHAR(8) PRIMARY KEY,
    姓名 VARCHAR(8) NOT NULL,
    部门 CHAR(40),
    工资 NUMERIC(8, 2),
    生日 DATE, -- PostgreSQL 只支持 DATE 类型, 所以不用 DATETIME 类型.
    职称 CHAR(20)
);

-- (5) 检查表是否创建成功
SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM SC;
SELECT * FROM Employee;

-- (6) 修改表结构及约束

-- 增加班级列
ALTER TABLE Student ADD Sclass CHAR(4);

-- 修改年龄列
ALTER TABLE Student ALTER COLUMN Sage TYPE SMALLINT;

-- 增加约束
ALTER TABLE Course ADD UNIQUE (Cname);

-- (7) 删除表
DROP TABLE Employee;
