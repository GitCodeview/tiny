# python scritpt tiny notes

## python pip 更换国内安装源（windows）
1. 点击此电脑，在最上面的的文件夹窗口输入 ： %APPDATA%

2. 按回车跳转到以下目录，新建pip文件夹

3. 创建pip.ini文件

4. 打开文件夹，输入以下内容，关闭即可（注意：源镜像可替换）
    ```sh
    [global]
    timeout = 6000
    index-url = https://pypi.tuna.tsinghua.edu.cn/simple
    trusted-host = pypi.tuna.tsinghua.edu.cn
    ```
5. 国内源镜像有：
- V2EX：http://pypi.v2ex.com/simple
- 豆瓣：http://pypi.douban.com/simple
- 中国科学技术大学：http://pypi.mirrors.ustc.edu.cn/simple
- 清华：https://pypi.tuna.tsinghua.edu.cn/simple
- 阿里云 http://mirrors.aliyun.com/pypi/simple/ 