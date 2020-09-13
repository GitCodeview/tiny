
## MySQL 安装
### Ubuntu
1、更新高级软件包工具（最近更新过可忽略）
```
sudo apt-get update
```
2、安装MySQL服务器
```
sudo apt-get install mysql-server
```
3、安装MySQL客户端（不用到客户端可以忽略）
```
sudo apt-get install mysql-client
```
4、安装MySQL依赖库（未知有什么用，装了再说）
```
sudo apt-get install libmysqlclient-dev
```
5、查询MySQL状态
```
sudo netstat -tap | grep mysql
```
等待一会儿，会出现监听（LISTEN）信息。
```
tcp6       0      0 [::]:mysql              [::]:*                  LISTEN      14539/mysqld
```

6、重看MySQL版本
```
sudo mysql -V
```
```
mysql  Ver 14.14 Distrib 5.7.29, for Linux (x86_64) using  EditLine wrapper
```
## MySQL 添加新用户、创建数据库、为新用户分配权限
### 登录Mysql

```
mysql -u root -p
```

```
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 19
Server version: 5.7.29-0ubuntu0.18.04.1 (Ubuntu)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

### 添加新的用户

允许本地 IP访问localhost的Mysql数据库
```
mysql> create user 'test'@'localhost' identified by 'testpassword';
Query OK, 0 rows affected (0.06 sec)
```
允许外网IP访问数据库test，本命令包含上面的命令，是所有的IP都可以访问该数据库
```
mysql> create user 'test'@'%' identified by 'testpassword';
Query OK, 0 rows affected (0.00 sec)
```
用户创建完成后，刷新授权
```
mysql> flush privileges;
Query OK, 0 rows affected (0.00 sec)
```
### 创建一个新的数据库，并使用show databases命令查看数据库是否创建OK
```
mysql> create database test DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
Query OK, 1 row affected (0.01 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| confluence         |
| test               |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.00 sec)
```
### 将改用户test赋权给数据库test
```
mysql> grant all privileges on `test`.* to 'test'@'localhost' identified by 'test123456' with grant option;
Query OK, 0 rows affected, 1 warning (0.00 sec)
```
```
mysql> grant all privileges on `test`.* to 'test'@'%' identified by 'test123456' with grant option;
Query OK, 0 rows affected, 1 warning (0.01 sec)
``` 
### 刷新授权
```
mysql> flush privileges;
Query OK, 0 rows affected (0.00 sec)
```
### 退出 root 重新登录，使用test登录检查本地登录是否正常，输入密码后，正常登录，并使用show databases命令查看数据库赋权是否正常。
```
mysql -u test -p
```
```
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 7
Server version: 5.7.22 MySQL Community Server (GPL)
 
Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.
 
Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.
 
Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
 
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| test          |
+--------------------+
2 rows in set (0.00 sec)
```