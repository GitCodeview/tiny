#coding=utf-8
import requests
from bs4 import BeautifulSoup
import os

all_url = 'https://www.mzitu.com'


#http请求头
Hostreferer = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36',
    'Referer':'https://www.mzitu.com'
               }
Picreferer = {
    'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36',
    'Referer':'https://i.meizitu.net'
}
#此请求头破解盗链
start_html = requests.get(all_url,headers = Hostreferer)

#保存地址
path = './mzitu/'

#找寻最大页数
soup = BeautifulSoup(start_html.text,"html.parser")
page = soup.find_all('a',class_='page-numbers')
max_page = page[-2].text

# max_page = 100
same_url = 'https://www.mzitu.com/page/'
for n in range(12,int(max_page)+1):
    ul = same_url+str(n)
    start_html = requests.get(ul, headers = Hostreferer)
    soup = BeautifulSoup(start_html.text,"html.parser")
    all_a = soup.find('div',class_='postlist').find_all('a',target='_blank')
    for a in all_a:
        title = a.get_text() #提取文本
        if(title != ''):
            print("准备扒取："+title)
            #win不能创建带？的目录
            if(os.path.exists(path+title.strip().replace('?','').replace(' ',''))):
                    #print('目录已存在')
                    flag=1
            else:
                os.makedirs(path+title.strip().replace('?','').replace(' ',''))
                flag=0
            #os.chdir(path + title.strip().replace('?',''))
            href = a['href']
            html = requests.get(href,headers = Hostreferer)
            mess = BeautifulSoup(html.text,"html.parser")
            pic_max = mess.find_all('span')
            print(len(pic_max))
            pic_max = pic_max[9].text #最大页数
            if(flag == 1 and len(os.listdir(path+title.strip().replace('?','').replace(' ',''))) >= int(pic_max)):
                print('已经保存完毕，跳过')
                continue
            for num in range(1,int(pic_max)+1):
                pic = href+'/'+str(num)
                html = requests.get(pic,headers = Hostreferer)
                mess = BeautifulSoup(html.text,"html.parser")
                pic_url = mess.find('img',alt = title)
                print(pic_url['src'])
                #exit(0)
                html = requests.get(pic_url['src'],headers = Picreferer)
                file_name = pic_url['src'].split(r'/')[-1]
                file_name = path + title.strip().replace('?','').replace(' ','')+'/'+file_name
                f = open(file_name,'wb')
                f.write(html.content)
                f.close()
            print('完成')
    print('第',n,'页完成')