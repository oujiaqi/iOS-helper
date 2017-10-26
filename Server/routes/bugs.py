#!/usr/bin/env python
# -*- coding: utf-8 -*-


import tornado.web
from models.bugs import Bug
import json

class AddBugHandler(tornado.web.RequestHandler):
    def post(self):
        # try:
        #     newBug = json.loads(self.request.body)
        # except ValueError:
        #     self.write("非json格式参数，添加失败")
        #     return
        print "---------请求----------"
        print self.request
        print "----------------------"
        print ""
        newBug = {}
        newBug["category"] = self.get_argument("category", "")
        newBug["url"] = self.get_argument("url", "")
        newBug["picture"] = self.get_argument("picture", "")
        newBug["description"] = self.get_argument("description", "")
        newBug["title"] = self.get_argument("title", "")
        newBug["errorCode"] = self.get_argument("errorCode", "")
        newBug["answer"] = self.get_argument("answer", "")
        newBug["correctedCode"] = self.get_argument("correctedCode", "")
        bid = Bug.add_one_bug(newBug)
        self.write("添加成功！该不该id序列为"+str(bid))
        print "返回成功"
        return

class GetOneBugHandler(tornado.web.RequestHandler):
    def get(self):
        bid = self.get_argument("bid", None)
        bug = Bug.get_one_bug(bid)
        if bug:
            self.set_header("Content-Type", "application/json; charset=utf-8")
            self.write(json.dumps(bug.toJson()))
            return
        else:
            self.write("获取失败")
            return

class GetBugsHandler(tornado.web.RequestHandler):
    def get(self):
        start = self.get_argument("start", 0)
        count = self.get_argument("count", 20)
        bugs = Bug.get_bugs(start, count)
        bugsJson = {}
        if len(bugs) > 0:
            for one in bugs:
                bugsJson[one.bid] = one.toJson()
            self.set_header("Content-Type", "application/json; charset=utf-8")
            self.write(json.dumps(bugsJson))
            return
        else:
            self.write("获取失败")
            return

# class UploadBugsPicHandler(tornado.web.RequestHandler):
#     def post(self):
#         ext_allowed = ['gif', 'jpg', 'jpeg', 'png']
#         max_size = 2621440
#         bid = self.get_argument("bid", None)
#         save_dir = os.path.join(os.path.dirname(__file__), "../public/pic/bugs/")
#         if not bid:
#             self.self.set_header("Content-Type", "application/json; charset=utf-8")
#             self.write({
#                 "message": "上传失败，未上传bid参数",
#                 "state": "failed"
#                 })
#         file_name = bid
#         if 'image' in self.request.files:
#             pic = self.request.files['image'][0]
#                 ext = pic['filename'].split('.').pop()
#                 if ext not in ext_allowed:
#                     error="图片格式不支持"
#                     self.render("change.html",error=error,user=user)
#                 if len(pic['body'])>max_size:
#                     error="图片太大"
#                     self.render("change.html",error=error,user=user)
#                 hpic = file_name+"."+ext
#                 with open(save_dir+hpic,'wb') as up:
#                     up.write(pic['body'])
#             User.change(user[0].uid,uname,password,profile,hpic,sex)
#             self.redirect("/change")


