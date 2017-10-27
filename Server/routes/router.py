#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os.path
import tornado.web
import bugs


class test(tornado.web.RequestHandler):
	def get(self):
		self.render("test.html")


application = tornado.web.Application(
        handlers=[(r'/bug/add',bugs.AddBugHandler),
        	(r'/bug/get/one', bugs.GetOneBugHandler),
        	(r'/bug/get/several', bugs.GetBugsHandler),
        	(r'/bug/modify', bugs.ModifyBugHandler),
        	(r'/bug/upload/pic', bugs.UploadBugPicHandler),
        	(r'/bug/del/one', bugs.DelOneBugHandler),
        	(r'/test', test)],
        template_path=os.path.join(os.path.dirname(__file__), "../views"),
        static_path=os.path.join(os.path.dirname(__file__), "../public"),
        debug=True
        )
