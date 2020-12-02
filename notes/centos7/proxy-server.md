# CentOS 代理服务器搭建

## TinyProxy 简单代理服务器搭建

1. 安装TinyProxy<br>
   ```sh
    sudo yum install tinyproxy
   ```

2. 配置TinyProxy<br>
   编辑配置文件：`sudo vim /etc/tinyproxy/tinyproxy.conf`<br>
   ```sh
    # ...
    Port 801 //修改代理端口
    # ...
    # 修改Allow 127.0.0.1为自己IP，只允许自己使用，或者在Allow前面打#注释，允许任何IP都可以连接到Proxy
    #  Allow 127.0.0.1  ## 注释
    # ...
    # 去除端口限制
    # ConnectPort 443  ## 注释
    # ConnectPort 563  ## 注释
   ```

3. 启动Tinyproxy服务，并设置开机自启<br>
   ```sh
    sudo service tinyproxy restart
    sudo chkconfig --level 345 tinyproxy on
   ```


## Squid 代理服务器搭建

1. 安装 Squid<br>
   ```sh
    sudo yum install squid httpd-tools -y
   ```

2. 生成密码文件<br>
   ```sh
    sudo mkdir /etc/squid3/
    sudo htpasswd -cd /etc/squid3/passwords <user_name>
    # 此步后会提示输入密码，注意密码不要超过8位
   ```

3. 测试密码文件<br>
   ```sh
    sudo /usr/lib64/squid/basic_ncsa_auth /etc/squid3/passwords
    # 输入 用户名 密码
    <user_name> <password>
    # 提示OK说明成功，ERR是有问题，请检查一下之前步骤
    OK
   ```

4. 配置细节<br>
   编辑配置文件：`sudo vim /etc/squid/squid.conf`<br>
   ```sh
    # 在最后添加
    auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid3/passwords
    auth_param basic realm proxy
    acl authenticated proxy_auth REQUIRED
    http_access allow authenticated

    # 这里是端口号，可以按需修改
    # http_port 8982 这样写会同时监听ipv6和ipv4的端口，推荐适应下面的配置方法。
    http_port 0.0.0.0:8982
    # 注意此端口要能允许外部连接访问
   ```

5. 启动服务<br>
   ```sh
    # 启动
    sudo systemctl start squid.service
    # 停止
    sudo systemctl stop squid.service
    # 重启
    sudo systemctl restart squid.service
    # 查看状态
    sudo systemctl status squid.service
   ```

6. 查看日志<br>
   ```sh
    # 查看全部日志内容
    sudo cat /var/log/squid/access.log
    # 查看新添加的日志内容
    sudo tail /var/log/squid/access.log
   ```