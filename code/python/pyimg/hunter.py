#coding=utf-8
import requests
from bs4 import BeautifulSoup
import os

all_url = 'https://www.jperotica.com'


#http请求头
Hostreferer = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36',
    'Referer':'https://www.jperotica.com'
               }
Picreferer = {
    'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36',
    'Referer':'https://k4b8k3x5.ssl.hwcdn.net/content/'
}
Videoreferer = {
    'User-Agent':'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36',
    'Referer':'https://d4w8c9t4.ssl.hwcdn.net/content/'
}
#此请求头破解盗链
start_html = requests.get(all_url,headers = Hostreferer)

#保存地址
path = './jperotica/'

#找寻最大页数
soup = BeautifulSoup(start_html.text,"html.parser")
page = soup.find_all('a',class_='page-numbers')
# max_page = page[-2].text

max_page = 10
same_url = 'https://www.jperotica.com/archive/page/'
for n in range(1,int(max_page)+1):
    ul = same_url+str(n)
    start_html = requests.get(ul, headers = Hostreferer)
    soup = BeautifulSoup(start_html.text,"html.parser")
    all_a = soup.find('ul', class_="gallery-a").find_all('a')
    for a in all_a:
        title = a.attrs['title'] #提取文本
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
            video = mess.find('video')
            if (video == None):
                fig_b = mess.find('ul', class_="gallery-b").find_all('a')
                for b in fig_b:
                    href_b = b['href']
                    print(href_b)
                    #exit(0)
                    try:
                        html = requests.get(href_b,headers = Picreferer)
                        file_name = href_b.split(r'/')[-1]
                        file_name = path + title.strip().replace('?','').replace(' ','')+'/'+file_name
                        f = open(file_name,'wb')
                        f.write(html.content)
                        f.close()
                        print('抓取成功')
                    except Exception:
                        os.rmdir(path + title.strip().replace('?','').replace(' ',''))
                        print('抓取失败')
                        pass
            else:
                # print('Skip video')
                # os.rmdir(path + title.strip().replace('?','').replace(' ',''))
                # continue
                video_b = video.find('source', type="video/mp4")
                print(video_b['src'])
                try:
                    video_html = requests.get(video_b['src'],headers = Videoreferer)
                    file_name = video_b['src'].split(r'/')[-1]
                    file_name = path + title.strip().replace('?','').replace(' ','')+'/'+file_name
                    f = open(file_name,'wb')
                    f.write(video_html.content)
                    f.close()
                    print('抓取成功')
                except Exception:
                    os.rmdir(path + title.strip().replace('?','').replace(' ',''))
                    print('抓取失败')
                    pass
            print('完成')
    print('第',n,'页完成')