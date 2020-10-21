# -*- coding: utf-8 -*-
import sys
sys.path.append("C:\\Users\\true0\\anaconda3\\envs\\py27\\lib\\site-packages")
# sys.path.append("D:\\devtools\\python-3.8.5\\Lib\\site-packages")
import requests
import re
import json
from bs4 import BeautifulSoup
reload(sys)
sys.setdefaultencoding('utf-8')



headers = {"User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36"}

def knowledgeList(animal, page, keyfield, keyword) :

    # 자바에서 온 값(unicode) 변환
    keyword = keyword.encode('utf-8')
    keyword = keyword.decode('unicode_escape')
    
    print("knowledgeList run..." + animal + str(page) + keyword)


    listcount_url = "http://www.zooseyo.or.kr/Yu_board/know.html?gubun=f&page=1&animal={animal}&keyfield={keyfield}&key={key}".format(animal=animal, keyfield=keyfield, key=keyword)
    listcount_res = requests.get(listcount_url, headers=headers)
    listcount_res.raise_for_status()

    listcount_soup = BeautifulSoup(listcount_res.text)

    if(listcount_soup.find_all('a', href=re.compile('^know_view.html'))) :
        listcount_tr = hrefs = listcount_soup.find_all('a', href=re.compile('^know_view.html'))[0].parent.parent.parent
    

        listcount = listcount_tr('td')[0].text.strip()

        url = "http://www.zooseyo.or.kr/Yu_board/know.html?gubun=f&page={page}&animal={animal}&keyfield={keyfield}&key={key}".format(page=page, animal=animal, keyfield=keyfield, key=keyword)
        res = requests.get(url, headers=headers)
        res.raise_for_status()

        # soup = BeautifulSoup(res.text, "lxml")
        soup = BeautifulSoup(res.text)

        hrefs = soup.find_all('a', href=re.compile('^know_view.html'))

        list = []

        for href in hrefs:
            title = href.get_text()
            link = "http://www.zooseyo.or.kr/Yu_board/" + href.attrs['href']
            tr = href.parent.parent.parent
            no = tr('td')[0].text.strip()
            readcount = tr('td')[4].text.strip()

            # dictionary 생성
            dict = {'no' : no, 'title' : title, 'readcount' : readcount, 'link' : link}
            # list에 담기
            list.append(dict)

        # json에 담기
        jsonData = json.dumps({"totalCount" : listcount, "url" : url, "list" : list})
    
    else :
        print("no list")
        jsonData = json.dumps({"totalCount" : 0, "url" : listcount_url})
    
    return jsonData





