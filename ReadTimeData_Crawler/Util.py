#coding=utf-8
import time
#获取当前格式化时间
def getCurrentTime():
    return time.strftime('%Y-%m-%d %H:%M',time.localtime(time.time()))
#获取当前格时间戳
def getTimeStmp():
    return time.time()
