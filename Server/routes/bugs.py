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
			self.write("非json格式参数")
			return
		Bug.add_one_bug(newBug)
		self.write("add successful!")
		




