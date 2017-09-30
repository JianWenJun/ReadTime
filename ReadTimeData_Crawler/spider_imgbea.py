#coding=utf-8
#爬虫总调度
from ReadTimeData import url_manager,html_downloader,html_parser,html_outputer

root_beaimg_url_travel="https://www.duitang.com/category/?cat=travel"#旅行
root_beaimg_url_photography="https://www.duitang.com/category/?cat=photography"#摄影
root_beaimg_url_comic="https://www.duitang.com/category/?cat=comic"#动漫
urls=[root_beaimg_url_travel,root_beaimg_url_photography,root_beaimg_url_comic]
class SpiderMain(object):

    def __init__(self):
        self.urls=url_manager.UrlManager()#url管理器
        self.downloader=html_downloader.DownLoader()
        self.parse=html_parser.Parse()
        self.outputer=html_outputer.Outputer()

    def craw(self,urls):
        if len(urls)==0:
            return
        imgs_sets=set()
        try:
            for url in urls:
                sets=self.downloader.doDownLoadImg(url)
                imgs_sets=imgs_sets|sets
        except Exception ,e:
                        print "craw failed!!!!!!!"
                        print e
        self.outputer.doOutPutImg(imgs_sets)
        # for setdata in imgs_sets:
        #             print setdata.getImgUrl()
        #             print setdata.getImgdes()
if __name__=="__main__":
    #美图：旅行，摄影，动漫
    obj_spider=SpiderMain()
    obj_spider.craw(urls)

