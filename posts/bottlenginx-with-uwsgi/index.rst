.. title: bottle+nginx with uwsgi
.. slug: bottlenginx-with-uwsgi
.. date: 2014/02/08 13:35:29
.. tags:
.. link:
.. description:
.. type: text

安裝 uwsgi

.. code::

    sudo pip uwsgi

先寫一個小小的程式，測試一下。

.. code:: python

    #!/usr/bin/env python
    # -*- coding: utf-8 -*-

    from bottle import route, app

    @route('/')
    def a():
        return( "Hello world" )

    application = app()

啟動 uwsgi

.. code::

    uwsgi --http :8001 --wsgi-file wsgi-test.py --chdir /path/to/wsgi-test.py

進 browser 看看成功否？目前成功。

接下來試 nginx 中啟動 uwsgi。
