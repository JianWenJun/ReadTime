#coding= utf-8
import urllib2
import json

App_Id="xmWyNOsRP081U8MQgi1Kyhm2-gzGzoHsz"
App_Key="usbkl4Qjjei1l0T68JieGICD"
Master_Key="JQ9cnuds29i43g8GRQOtvXW6"
BaseURL="https://api.leancloud.cn/1.1/"

def getReqByURL(objectUrl):
    req=urllib2.Request(BaseURL+objectUrl)
    req.add_header("Content-Type","application/json")
    req.add_header("X-LC-Id",App_Id)
    req.add_header("X-LC-Key",App_Key)
    return req


class Outputer(object):
    #post请求
    def doCollectData(self, datas):
        if len(datas)==0:
            return
        dataLists=[]#n个请求的列表
        #批量请求
        for title in datas:
            values ={}#单个请求的数据
            body={}#单个请求的body
            values["method"]="POST"
            values["path"]="/1.1/classes/Article"
            body["articleHeader"]=title.getTopic()
            title_type=title.getType()
            body["typeID"]=title_type
            body["articleUrl"]=title.getUrl()
            if title_type==2:
                #全文字
                body["articleContent"]=title.getIntro()
            elif title_type==3:
                #图片
                imgs=title.getIntro();
                imgs.append(title.getUrl())
                body["articleContent"]=str(imgs)
            values["body"]=body
            dataLists.append(values)
        data={"requests":dataLists}
        jdata=json.dumps(data)
        req=getReqByURL("batch")
        try:
             respone=urllib2.urlopen(req,jdata,timeout=5)
             print respone.getcode()
        except Exception,e:
            print e
        # print data
        # artReq=getReqByURL("classes/ArtType")
        #
        # jdata = json.dumps(values) # 对数据进行JSON格式化编码
        # print jdata
        # respone=urllib2.urlopen(artReq,jdata)
        # print respone.read()


    def doOut(self):

        pass

    def doOutPutLun(self,datas):
        if len(datas)==0:
            return
        dataLists=[]#n个请求的列表
        #批量请求
        for luntitle in datas:
            values ={}#单个请求的数据
            body={}#单个请求的body
            values["method"]="POST"
            values["path"]="/1.1/classes/LArticle"
            body["imgUrl"]=luntitle.getLunImgUrl()
            body["imgDes"]=luntitle.getLunContent()+"-"+luntitle.getLunTime()
            body["imgTitle"]=luntitle.getLunTopic()
            values["body"]=body
            dataLists.append(values)
        data={"requests":dataLists}
        jdata=json.dumps(data)
        req=getReqByURL("batch")
        try:
             respone=urllib2.urlopen(req,jdata,timeout=5)
             print respone.getcode()
        except Exception,e:
            print e

    def doOutPutImg(self,datas):
        if len(datas)==0:
            return
        dataLists=[]#n个请求的列表
        #批量请求
        for img in datas:
            values ={}#单个请求的数据
            body={}#单个请求的body
            values["method"]="POST"
            values["path"]="/1.1/classes/ImgArt"
            body["imgUrl"]=img.getImgUrl()
            body["imgDes"]=img.getImgdes()
            body["typeID"]=5
            values["body"]=body
            dataLists.append(values)
        data={"requests":dataLists}
        jdata=json.dumps(data)
        req=getReqByURL("batch")
        try:
             respone=urllib2.urlopen(req,jdata,timeout=5)
             print respone.getcode()
        except Exception,e:
            print e

    def doOutPutZti(self, zti_sets):
        if len(zti_sets)==0:
            return
        dataLists=[]#n个请求的列表
        #批量请求
        for title in zti_sets:
            values ={}#单个请求的数据
            body={}#单个请求的body
            values["method"]="POST"
            values["path"]="/1.1/classes/Article"
            body["articleHeader"]=title.getTopic()
            body["typeID"]=title.getType()
            body["articleUrl"]=title.getUrl()
            body["articleContent"]=title.getIntro()
            values["body"]=body
            dataLists.append(values)
        data={"requests":dataLists}
        jdata=json.dumps(data)
        req=getReqByURL("batch")
        try:
             respone=urllib2.urlopen(req,jdata,timeout=5)
             print respone.getcode()
        except Exception,e:
            print e