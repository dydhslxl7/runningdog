# -*- coding: utf-8 -*-
import sys
sys.path.append("C:\\Users\\true0\\anaconda3\\envs\\py27\\lib\\site-packages")
# sys.path.append("D:\\devtools\\python-3.8.5\\Lib\\site-packages")
import requests
import re
import json
from bs4 import BeautifulSoup

headers = {"User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36"}

def knowledgeList(animal) :
    print("knowledgeList run..." + animal)

    url = "http://www.zooseyo.or.kr/Yu_board/know.html?gubun=f&page=1&animal={animal}&keyfield=subject&key=".format(animal=animal)
    res = requests.get(url, headers=headers)
    res.raise_for_status()

    # soup = BeautifulSoup(res.text, "lxml")
    soup = BeautifulSoup(res.text)

    arrowback = soup.find('img', src=re.compile('arrow-back'))

    # list생성
    list = []

    # lastpage = int(arrowback.find_previous_sibling("a").text.strip()) #자기 페이지 일때는 a링크가 아니라 오류뜸
    # 다음가기 화살표가 있을 시 페이지 수 구하기
    if arrowback :
        print("on list")
        lastpage = int(arrowback.previous_sibling.previous_sibling.get_text().strip()) #페이지 수 추출

        # 페이지 수 가지고 전체 정보 가지고 오기
        for i in range(1, lastpage + 1) :
            url = "http://www.zooseyo.or.kr/Yu_board/know.html?gubun=f&page={page}&animal={animal}&keyfield=subject&key=".format(page=i, animal=animal)
            res = requests.get(url, headers=headers)
            res.raise_for_status()

            # soup = BeautifulSoup(res.text, "lxml")
            soup = BeautifulSoup(res.text)
            
            hrefs = soup.find_all('a', href=re.compile('^know_view.html'))

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

    else : 
        print("no list")
    
    # json에 담기
    jsonData = json.dumps({"totalCount" : len(list), "url" : url, "list" : list})
    
    return jsonData

