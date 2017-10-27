#!/usr/bin/env python
# -*- coding: utf-8 -*-


import tornado.web
from models.bugs import Bug
import json
import os

def answerReq(response, message, action, successedFlag, infoDict={}):
    infoDict["method"] = action
    infoDict["message"] = message
    infoDict["status"] = "failed"
    if successedFlag:
        infoDict["status"] = "successed"
    response.set_header("Content-Type", "application/json; charset=utf-8")
    response.write(infoDict)
    print infoDict


class AddBugHandler(tornado.web.RequestHandler):
    def post(self):
        action = "POST AddBug"
        successedFlag = False
        message = ""
        # try:
        #     newBug = json.loads(self.request.body)
        # except ValueError:
        #     self.write("非json格式参数，添加失败")
        #     return
        print "---------请求----------"
        print self.request
        print "---------body---------"
        print self.request.body
        print "----------------------"
        newBug = {}
        newBug["category"] = self.get_argument("category", "")
        newBug["url"] = self.get_argument("url", "")
        newBug["picture"] = self.get_argument("picture", "")
        newBug["description"] = self.get_argument("description", "")
        newBug["title"] = self.get_argument("title", "")
        newBug["errorCode"] = self.get_argument("errorCode", "")
        newBug["answer"] = self.get_argument("answer", "")
        newBug["correctedCode"] = self.get_argument("correctedCode", "")
        print "--------bug-------"
        print newBug
        print "--------end-------"
        try:
            bid = Bug.add_one_bug(newBug)
            message="添加bug成功"
            successedFlag = True
            answerReq(self, message, action, successedFlag, {})
            return
        except Exception, msg:
            message="添加出现错误"
            answerReq(self, message, action, successedFlag, {})
            print msg
            return

class ModifyBugHandler(tornado.web.RequestHandler):
    def post(self):
        action = "POST ModifyBug"
        successedFlag = False
        message = ""
        bid = self.get_argument("bid", None)
        if not bid:
            message="请上传bid"
            answerReq(self, message, action, successedFlag, {})
            return
        try:
            tempBug = Bug.get_one_bug(bid)
            if not tempBug:
                message="请传入正确的bid"
                answerReq(self, message, action, successedFlag, {})
                return
        except Exception, msg:
            message="查询时候出现错误"
            answerReq(self, message, action, successedFlag, {})
            print msg
            return
        mBug = {}
        category = self.get_argument("category", None)
        url = self.get_argument("url", None)
        picture = self.get_argument("picture", None)
        description = self.get_argument("description", None)
        title = self.get_argument("title", None)
        errorCode = self.get_argument("errorCode", None)
        answer = self.get_argument("answer", None)
        correctedCode = self.get_argument("correctedCode", None)
        if category:
            mBug["category"] = category
        if url:
            mBug["url"] = url
        if picture:
            mBug["picture"] = picture
        if description:
            mBug["description"] = description
        if title:
            mBug["title"] = title
        if errorCode:
            mBug["errorCode"] = errorCode
        if answer:
            mBug["answer"] = answer
        if correctedCode:
            mBug["correctedCode"] = correctedCode
        print mBug
        try:
            Bug.modify_one_bug(bid, mBug)
            message="修改成功"
            successedFlag = True
            answerReq(self, message, action, successedFlag, {})
            return
        except Exception, msg:
            message="修改时候出现错误"
            answerReq(self, message, action, successedFlag, {})
            print msg
            return

class DelOneBugHandler(tornado.web.RequestHandler):
    def get(self):
        action = "GET DelOneBug"
        successedFlag = False
        message = ""
        bid = self.get_argument("bid", None)
        if not bid:
            message="请传入bid"
            answerReq(self, message, action, successedFlag, {})
            return
        try:
            result = Bug.del_one_bug(bid)
            if result['n'] > 0:
                message="删除成功"
                successedFlag = True
                answerReq(self, message, action, successedFlag, {})
                return
            else:
                message="删除失败，请检查时候存在该bid"
                answerReq(self, message, action, successedFlag, {})
                return
        except Exception, msg:
            message="删除出现错误"
            answerReq(self, message, action, successedFlag, {})
            print msg
            return




class GetOneBugHandler(tornado.web.RequestHandler):
    def get(self):
        action = "GET GetOneBug"
        successedFlag = False
        message = ""
        bid = self.get_argument("bid", None)
        try:
            bug = Bug.get_one_bug(bid)
            if bug:
                self.set_header("Content-Type", "application/json; charset=utf-8")
                self.write(json.dumps(bug.toJson()))
                return
            else:
                message="获取失败"
                answerReq(self, message, action, successedFlag, {})
                return
        except Exception, msg:
            message="查询出现错误"
            answerReq(self, message, action, successedFlag, {})
            print msg
            return
        

class GetBugsHandler(tornado.web.RequestHandler):
    def get(self):
        action = "GET GetBugs"
        successedFlag = False
        message = ""
        start = self.get_argument("start", 0)
        count = self.get_argument("count", 20)
        try:
            bugs = Bug.get_bugs(start, count)
            bugsJson = {}
            if len(bugs) > 0:
                for one in bugs:
                    bugsJson[one.bid] = one.toJson()
                self.set_header("Content-Type", "application/json; charset=utf-8")
                self.write(json.dumps(bugsJson))
                return
            else:
                message="获取失败"
                answerReq(self, message, action, successedFlag, {})
                return
        except Exception, msg:
            message="查询出现错误"
            answerReq(self, message, action, successedFlag, {})
            print msg
            return


class UploadBugPicHandler(tornado.web.RequestHandler):
    def post(self):
        action = "POST UploadBugPic"
        successedFlag = True
        message = ""
        ext_allowed = ['gif', 'jpg', 'jpeg', 'png']
        max_size = 2621440
        bid = self.get_argument("bid", None)
        save_dir = os.path.join(os.path.dirname(__file__), "../public/pics/bugs/")
        if not bid:
            message = "上传失败，未上传bid参数"
            answerReq(self, message, action, successedFlag, {})
            return
        if 'image' in self.request.files:
            pic = self.request.files['image'][0]
            ext = pic['filename'].split('.').pop()
            if ext not in ext_allowed:
                message="图片格式不支持"
                answerReq(self, message, action, successedFlag, {})
                return
            if len(pic['body'])>max_size:
                message="图片太大"
                answerReq(self, message, action, successedFlag, {})
                return
            file_name = bid+"."+ext
            print "开始上传"
            with open(save_dir+file_name,'wb') as up:
                up.write(pic['body'])
            print "上传成功"
            print "修改图片名ing"
            try:
                Bug.modify_one_bug(bid, {"picture": "/static/pics/bugs/"+file_name})
            except Exception, msg:
                message="更新名字错误"
                answerReq(self, message, action, successedFlag, {})
                print msg
                return
            message="上传成功"
            successedFlag = True
            answerReq(self, message, action, successedFlag, {"pic-path": "/static/pics/bugs/"+file_name})
            return



