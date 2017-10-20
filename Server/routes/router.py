#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os.path
import tornado.web
import bugs


application = tornado.web.Application(
        handlers=[(r'/bug/add',bugs.AddBugHandler), (r'/bug/get/one', bugs.GetOneBugHandler), (r'/bug/get/several', bugs.GetBugsHandler)],
        static_path=os.path.join(os.path.dirname(__file__), "../public"),
        debug=True
        )
