#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os.path
import tornado.web
import bugs


application = tornado.web.Application(
        handlers=[(r'/bugs/add',bugs.AddBugHandler),],
        static_path=os.path.join(os.path.dirname(__file__), "../public"),
        debug=True
        )
