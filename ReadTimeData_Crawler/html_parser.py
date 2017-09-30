#coding=utf-8
from bs4 import BeautifulSoup
import re
from ReadTimeData.model import Title
from ReadTimeData.model import LunBoTitle

base_url="https://moment.douban.com/post/"
base_zti_url="http://www.jianshu.com"
#获取文章
def getDataTopic(soup):
    links=soup.find_all('a',href=re.compile(base_url))
    titles=set()
    for link in links:
         #属性用["href"] ，标签有.
        title_topic=link.h3.text#获取文章标题
        title_url=link["href"]#获取文章URL
        title_intro=None #获取文章介绍
        title_type=2#文字
        try:
            className=link.p["class"][0] #文章展示类型
            if className=="pics":
                imgs=link.p.find_all('img')#图片
                imgLists=[]
                for img in imgs:
                    imgLists.append(img["src"].encode("utf-8"))
                title_intro=imgLists
                title_type=3#图片
            if className=="abstract":
                title_intro=link.p.text

        except:
             print "class 类型错误"

        title=Title(title_topic,title_url,title_intro,title_type)
        titles.add(title)
    return titles

def getDataZti(soup,index):
    datas=set()
    ul=soup.find("ul",class_="note-list")
    lis=ul.find_all('li')
    zti_type=index+6
    for li in lis:
        zti_img_url=""
        if(li["class"][0]=="have-img"):
            zti_img_url="http:"+li.a.img["src"]
        div=li.find("div",class_="content")
        zti_title_url= base_zti_url+div.a["href"]
        zti_topic= div.find("a",class_="title").text
        zti_intro=div.p.text+"-"+zti_img_url
        zti_data=Title(zti_topic,zti_title_url,zti_intro,zti_type)
        datas.add(zti_data)
    return datas

class Parse(object):
    #解析首页列表
    def doParse(self, html_content):
        if  html_content is None:
            return
        soup=BeautifulSoup(html_content,"html.parser",from_encoding="utf-8")
        data_titles=getDataTopic(soup)
        return data_titles
    #解析专题
    def doParseZti(self,html_content,index):
        if  html_content is None:
            return
        soup=BeautifulSoup(html_content,"html.parser",from_encoding="utf-8")
        ztis=getDataZti(soup,index)
        return ztis
