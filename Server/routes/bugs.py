#!/usr/bin/env python
# -*- coding: utf-8 -*-


import tornado.web
from models.bugs import Bug
import json

class AddBugHandler(tornado.web.RequestHandler):
	def post(self):
		try:
			newBug = json.loads(self.request.body)
		except ValueError:
			self.write("非json格式参数，添加失败")
			return
		bid = Bug.add_one_bug(newBug)
		self.write("添加成功！该不该id序列为"+str(bid))

class GetOneBugHandler(tornado.web.RequestHandler):
	def get(self):
		bid = self.get_argument("bid", None)
		bug = Bug.get_one_bug(bid)
		if bug:
			self.write(bug.toJson())
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
			self.write(bugsJson)
			return
		else:
			self.write("获取失败")
			return



