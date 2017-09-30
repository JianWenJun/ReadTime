class UrlManager(object):
    def __init__(self):
        self.new_urls=set()
        self.old_urls=set()
    def addNewUrl(self, root_url):
        if root_url is None:
            return
        if root_url not in self.old_urls and root_url not in self.new_urls:
            self.new_urls.add(root_url)

    def addNewUrls(self, new_urls):
        if new_urls is None or len(new_urls)==0:
            return
        for url in new_urls:
            self.addNewUrl(url)
    def hasNewUrls(self):
        return len(self.new_urls)!=0

    def getNewUrls(self):
        new_url=self.new_urls.pop()
        self.old_urls.add(new_url)
        return new_url

