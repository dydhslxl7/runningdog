# -*- coding: utf-8 -*-
import sys
sys.path.append("C:\\Users\\true0\\anaconda3\\envs\\py27\\lib\\site-packages")
# sys.path.append("D:\\devtools\\python-3.8.5\\Lib\\site-packages")
import requests
import re
import json
from bs4 import BeautifulSoup

def knowledgeDetail(url) :
    print("knowledgeDetail run..." + url)

    # url = "http://www.zooseyo.or.kr/Yu_board/know_view.html?gubun=f&animal=dog&no=170&page=1"
    headers = {"User-Agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36"}
    res = requests.get(url, headers=headers)
    res.raise_for_status()

    soup = BeautifulSoup(res.text)

    # <p style="line-height:13pt;"></p>
    content = soup.find_all('p', style=re.compile('line-height:13pt'))[1].get_text()

    # json에 담기
    jsonData = json.dumps({"content" : content})

    return jsonData

