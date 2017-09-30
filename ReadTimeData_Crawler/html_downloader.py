#coding=utf-8

import urllib2
import time
from selenium import webdriver

from ReadTimeData.model import LunBoTitle, Img


def doParseHtml(data, driver):
    result1=driver.find_element_by_tag_name("img").src
    result=driver.find_element_by_id("articleList").text
    print result1


def doGetNewsData(driver):
    new_datas=[]#数据
    count=1;
    while count<=4:
        # print driver.current_url
        li=driver.find_element_by_xpath("//li[@class=\"m-article-item z-active m-article-item-read\"]")
        new_data_topic=li.find_element_by_tag_name("h4").text
        new_data_imgurl=li.find_element_by_tag_name("img").get_attribute("src")
        new_data_time=li.find_element_by_class_name("muted").text
        new_data_content=driver.find_element_by_xpath('//div[@class="news-content"]/p[2]').get_attribute('innerHTML')
        new_data=LunBoTitle(new_data_topic,new_data_time,new_data_imgurl,new_data_content)
        new_datas.append(new_data)
        a=driver.find_element_by_xpath('//a[@data-original-title="查看原文"]')
        newurl= a.get_attribute("href")
        driver.get(newurl)
        time.sleep(1)
        count+=1
    return new_datas
    #
    # for data in new_datas:
    #     print '-----------------------------------------------------------------------------'
    #     print data.getLunContent()
def doGetImgsData(driver):
    new_datas=set()
    count=10;
    try:
        divs=driver.find_elements_by_class_name("mbpho")
        length=len(divs)
        if(length<=10):
            count=length
        img_url=""
        img_des=""
        while count>0:
            div=divs[count]
            img_url=div.find_element_by_tag_name("img").get_attribute("src")
            img_des=div.find_element_by_tag_name("img").get_attribute("alt")
            set_data=Img(img_url,img_des)
            new_datas.add(set_data)
            count-=1
    except Exception,e:
        print e
    return new_datas

class DownLoader(object):
    #轮播图
    def doDownLoadLun(self,new_url):
        if new_url is None or len(new_url)==0:
            return
        cap=webdriver.DesiredCapabilities.PHANTOMJS
        # cap["phantomjs.page.settings.resourceTimeout"] = 1000
        cap["phantomjs.page.settings.loadImages"] = False
        driver=webdriver.PhantomJS(desired_capabilities=cap)
        driver.get(new_url)
        driver.refresh()
        lun_datas=doGetNewsData(driver)
        driver.quit()
        return lun_datas
    #首页热点
    def doDownLoad(self, new_url):
        if new_url is None or len(new_url)==0:
            return
        else:
            # unstyled m-article-list
            req=urllib2.Request(new_url)
            # req.add_header("Host","dl.reg.163.com")
            # req.add_header("User-Agent","Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11")
            # req.add_header("Accept-Language","zh-CN,zh;q=0.8")
            # req.add_header("Accept","*/*")
            # req.add_header("Accept-Encoding","gzip,deflate,sdch")
            try:
                respone=urllib2.urlopen(req,timeout=10)
                if respone.getcode()==200:
                    return respone.read()
            except Exception,e:
                print e
    #美图
    def doDownLoadImg(self, new_url):
        if new_url is None or len(new_url)==0:
            return
        cap=webdriver.DesiredCapabilities.PHANTOMJS
        cap["phantomjs.page.settings.resourceTimeout"] = 1000
        cap["phantomjs.page.settings.loadImages"] = False
        driver=webdriver.PhantomJS(service_args=['--ignore-ssl-errors=true','--ssl-protocol=any'],desired_capabilities=cap)
        driver.get(new_url)
        # print driver.page_source
        img_datas=doGetImgsData(driver)
        driver.quit()
        return img_datas
    #专题
    def doDownLoadZt(self, new_url):
        if new_url is None or len(new_url)==0:
            return
        else:
            req=urllib2.Request(new_url)
            try:
                respone=urllib2.urlopen(req,timeout=10)
                if respone.getcode()==200:
                    return respone.read()
            except Exception,e:
                print e