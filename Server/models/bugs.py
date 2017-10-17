#!/usr/bin/env python
# -*- coding: utf-8 -*-

from db import connect
import datetime
from bson.objectid import ObjectId

class Bug(object):
    def __init__(self, bid, title, description, answer, url, category, errorCode, correctedCode, picture, createTime):
        self._bid = str(bid)
        self._title = title
        self._description = description
        self._answer = answer
        self._url = url
        self._category = category
        self._errorCode = errorCode
        self._correctedCode = correctedCode
        self._picture = picture
        self._createTime = datetime.datetime.strptime(createTime, '%Y-%m-%d %H:%M:%S')

    @property
    def bid(self):
        return self._bid

    @property
    def title(self):
        return self._title

    @property
    def description(self):
        return self._description

    @property
    def answer(self):
        return self._answer

    @property
    def url(self):
        return self._url

    @property
    def category(self):
        return self._category

    @property
    def errorCode(self):
        return self._errorCode

    @property
    def cortectedCode(self):
        return self._correctedCode

    @property
    def picture(self):
        return self._picture

    @property
    def createTime(self):
        return self._createTime

    @staticmethod
    def del_one_bug(bid):
        bid = ObjectId(bid)
        connect().bug.remove({"_id": bid})

    @staticmethod
    def modify_one_bug(bid, modified_dic):
        bid = ObjectId(bid)
        connect().bug.update({"_id":bid}, {"$set": modified_dic})

    @staticmethod
    def add_one_bug(bug_dic):
        newBug = {"title":"",
            "description":"",
            "answer":"",
            "url":"",
            "category":"",
            "errorCode":"",
            "correctedCode":"",
            "picture":"",
            "createTime":""}
        for k in bug_dic:
            newBug[k] = bug_dic[k]
        createTime = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        newBug["createTime"] = createTime
        return connect().bug.insert_one(newBug).inserted_id

    @staticmethod
    def get_one_bug(bid=""):
        bid = ObjectId(bid)
        bug = connect().bug.find_one({"_id": bid})
        return Bug(bug["_id"], bug["title"], bug["description"], bug["answer"], bug["url"], bug["category"], bug["errorCode"], bug["correctedCode"], bug["picture"], bug["createTime"])

    @staticmethod
    def get_bugs(start=0, count=20):
        bugs = []
        for bug in connect().bug.find()[start:count+start]:
            bugs.append(Bug(bug["_id"], bug["title"], bug["description"], bug["answer"], bug["url"], bug["category"], bug["errorCode"], bug["correctedCode"], bug["picture"], bug["createTime"]))
        return bugs





