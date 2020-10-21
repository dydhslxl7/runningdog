# -*- coding: utf-8 -*-
import sys
# sys.path.append("D:\\devtools\\python-3.8.5\\Lib\\site-packages")
sys.path.append("C:\\Users\\true0\\anaconda3\\envs\\py27\\lib\\site-packages")
import requests
import re
import json
from bs4 import BeautifulSoup

headers = {"User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36"}
partners = ['animalandhuman', 'petzzi', 'notepet', 'koreadognews', 'bemypet']
# partners = ['animalandhuman', 'petzzi']

# 발행순
def issueListLatest():
    print("issueListLatest run...")

    list = []

    for partner in partners : 
        url = "http://1boon.kakao.com/{partner}".format(partner=partner)
        
        print(url)
        requests.packages.urllib3.disable_warnings()
        res = requests.get(url, headers=headers, verify=False)
        res.raise_for_status()

        soup = BeautifulSoup(res.text)

        # 파트너 정보 추출
        # 파트너 대표 이미지 : class = img_default, 대표 이름 : class = tit_name
        partnerName = soup.find("strong", attrs={"class" : "tit_name"}).get_text().strip()
        partnerImg = soup.find("img", attrs={"class" : "img_default"})['src']


        # 컨텐츠 부분 //*[@id="timelinesView"]
        uls = soup.select('#timelinesView')[0]
        ul = uls.find_all('li')

        for li in ul :
            title = li.find("strong", attrs={"class":"tit_thumb"}).get_text().strip()
            thumbnail = li.find("img", attrs={"class":re.compile("^lazyimg")})['data-src']

            link = 'https://1boon.kakao.com' + li.find("a")["href"]

            res2 = requests.get(link, headers=headers, verify=False)
            res2.raise_for_status()
            soup2 = BeautifulSoup(res2.text)
            date = soup2.find("span", attrs={"class":"txt_date"}).get_text().strip()

            dict = {'partnerName' : partnerName, 'partnerImg' : partnerImg, 'title' : title,'date' : date, 'thumbnail' : thumbnail, 'link' : link}

            list.append(dict)

    # 최신 순으로 정렬
    data = sorted(list, key=lambda  k: k['date'], reverse=True)

    jsonData = json.dumps({"totalCount" : len(list), "list" : data})

    return jsonData



# 인기순
def issueListPopular():
    print("issueListPopular run...")

    # list생성
    list= []

    for partner in partners : 
        url = "https://1boon.kakao.com/{partner}?order=view".format(partner=partner)

        print(url)
        requests.packages.urllib3.disable_warnings()
        res = requests.get(url, headers=headers, verify=False)
        res.raise_for_status()

        soup = BeautifulSoup(res.text)

        # 파트너 정보 추출
        # 파트너 대표 이미지 : class = img_default, 대표 이름 : class = tit_name
        partnerName = soup.find("strong", attrs={"class" : "tit_name"}).get_text().strip()
        partnerImg = soup.find("img", attrs={"class" : "img_default"})['src']


        # 컨텐츠 부분 //*[@id="timelinesView"]
        uls = soup.select('#timelinesView')[0]
        ul = uls.find_all('li')

        for li in ul :
            title = li.find("strong", attrs={"class":"tit_thumb"}).get_text().strip()
            thumbnail = li.find("img", attrs={"class":re.compile("^lazyimg")})['data-src']

            readcount = int(li.find("em", attrs={"class":"emph_number"}).get_text().strip().replace(',',''))

            link = 'https://1boon.kakao.com' + li.find("a")["href"]

            # dictionary 생성
            dict = {'partnerName' : partnerName, 'partnerImg' : partnerImg, 'title' : title,'readcount' : readcount, 'thumbnail' : thumbnail, 'link' : link}
            
            # list 에 담기
            list.append(dict)

    # 조회수 순으로 정렬
    data = sorted(list, key=lambda  k: k['readcount'], reverse=True)

    # json에 담기
    jsonData = json.dumps({"totalCount" : len(list), "list" : data})

    return jsonData
