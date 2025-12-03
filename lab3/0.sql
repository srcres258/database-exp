-- 3.2 使用 SQL 语句创建用户并授权

-- 1. 创建登录名

-- (1) 分别创建两个登录名 王明 和 李刚:
-- 注: 在 PostgreSQL 下, 用 CREATE USER 来创建用户.
CREATE USER wangming WITH PASSWORD '123456';
CREATE USER ligang WITH PASSWORD '123456';

-- (2) 检查登录名是否创建成功:
SELECT rolname
  FROM pg_roles
  WHERE rolcanlogin
  ORDER BY rolname;

-- 3. 授权

-- (1) 授予王明权限
GRANT SELECT ON Student TO wangming;

-- (2) 授予李刚权限
GRANT SELECT ON Student TO ligang;
GRANT INSERT, UPDATE, DELETE ON Student TO ligang;
GRANT SELECT ON Course TO ligang;

