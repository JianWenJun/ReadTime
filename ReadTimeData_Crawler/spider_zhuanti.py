#coding=utf-8
#爬虫总调度
from ReadTimeData import url_manager,html_downloader,html_parser,html_outputer

#专题
root_zhuanti_url_xinlin="http://www.jianshu.com/c/f6b4ca4bb891"#心灵启迪
root_zhuanti_url_chengzhang="http://www.jianshu.com/c/5AUzod"#成长点滴
root_zhuanti_url_wenyi="http://www.jianshu.com/c/1b5233f81024"#文艺范
urls=[root_zhuanti_url_xinlin,root_zhuanti_url_chengzhang,root_zhuanti_url_wenyi]
class SpiderMain(object):

    def __init__(self):
        self.urls=url_manager.UrlManager()#url管理器
        self.downloader=html_downloader.DownLoader()
        self.parse=html_parser.Parse()
        self.outputer=html_outputer.Outputer()

    def craw(self,urls):
        if len(urls)==0:
            return
        zti_sets=set()
        try:
            for index in range(0,3):
                html_content=self.downloader.doDownLoadZt(urls[index])
                zti_set=self.parse.doParseZti(html_content,index)
                zti_sets=zti_sets|zti_set
        except Exception ,e:
                        print "craw failed!!!!!!!"
                        print e
        self.outputer.doOutPutZti(zti_sets)
        # for setdata in zti_sets:
        #             print setdata.getTopic()
        #             print setdata.getUrl()
        #             print setdata.getType()
if __name__=="__main__":
    #美图：旅行，摄影，动漫
    obj_spider=SpiderMain()
    obj_spider.craw(urls)

