#coding=utf-8
#爬虫总调度
from ReadTimeData import url_manager,html_downloader,html_parser,html_outputer
class SpiderMain(object):

    def __init__(self):
        self.urls=url_manager.UrlManager()#url管理器
        self.downloader=html_downloader.DownLoader()
        self.parse=html_parser.Parse()
        self.outputer=html_outputer.Outputer()

    def craw(self,root_url):
        try:
            lun_datas=self.downloader.doDownLoadLun(root_url)
            # print lun_datas
            self.outputer.doOutPutLun(lun_datas)
        except Exception ,e:
            print "craw failed!!!!!!!"
            print e


            # self.outputer.doOut()
if __name__=="__main__":
    #美图：旅行，摄影，动漫
    root_beaimg_url_travel="https://www.duitang.com/category/?cat=travel"#旅行
    root_beaimg_url_photography="https://www.duitang.com/category/?cat=photography"#摄影
    root_beaimg_url_comic="https://www.duitang.com/category/?cat=comic"#动漫
    #首页热点
    root_home_url="https://moment.douban.com/app/"#首页热门
    #首页轮播图
    root_home_url_lunbotu="http://yuedu.163.com/news_reader/#/~/source?id=16f9a42d-7385-4ea4-b3ac-05041fe40ffc_1"
    #专题
    root_zhuanti_url_xinlin="http://www.jianshu.com/c/f6b4ca4bb891"#心灵启迪
    root_zhuanti_url_chengzhang="http://www.jianshu.com/c/5AUzod"#成长点滴
    root_zhuanti_url_wenyi="http://www.jianshu.com/c/1b5233f81024"#文艺范
    obj_spider=SpiderMain()
    obj_spider.craw(root_home_url_lunbotu)
