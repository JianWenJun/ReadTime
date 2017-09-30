#coding=utf-8
#首页文章
class Title(object):
    def __init__(self,title_topic,title_url,title_intro,title_type):
        self.title_topic=title_topic
        self.title_url=title_url
        self.title_intro=title_intro
        self.title_type=title_type
    def getTopic(self):
        return self.title_topic
    def getUrl(self):
        return self.title_url
    def getIntro(self):
        return self.title_intro
    def getType(self):
        return self.title_type
#首页轮播图
class LunBoTitle(object):
    def __init__(self,lunBoTitle_topic,lunBoTitle_time,lunBoTitle_imgUrl,lunBoTitle_content):
        self.lunBoTitle_topic=lunBoTitle_topic
        self.lunBoTitle_time=lunBoTitle_time
        self.lunBoTitle_imgUrl=lunBoTitle_imgUrl
        self.lunBoTitle_content=lunBoTitle_content
    def getLunTopic(self):
        return self.lunBoTitle_topic
    def getLunTime(self):
        return self.lunBoTitle_time
    def getLunImgUrl(self):
        return self.lunBoTitle_imgUrl
    def getLunContent(self):
        return self.lunBoTitle_content
#精美图片
class Img(object):
    def __init__(self,Img_url,Img_des):
        self.Img_url=Img_url
        self.Img_des=Img_des
    def getImgUrl(self):
        return self.Img_url
    def getImgdes(self):
        return self.Img_des