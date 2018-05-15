.. title: bottle+beaker session management
.. slug: bottlebeaker-session-management
.. date: 2014/02/22 09:39:50
.. tags: 
.. link: 
.. description: 
.. type: text

直接看程式碼：

.. code:: python

	import beaker.middleware
	from bottle import mako_view as view, mako_template as template
	from bottle import route, hook, static_file, request
	import bottle
	
	## Beaker middleware
	# set up beaker session state middleware
	_session_opts = {'session.type': 'memory',
					 'session.auto': True}

	# wrap the bottle app in a beaker
	_app = beaker.middleware.SessionMiddleware(bottle.app(), _session_opts)

	# hook request to make the beaker session easier to get to
	@hook('before_request')
	def _setup_request():
		request.session = request.environ['beaker.session']

	def _init_root():
		if 'user_session' not in request.session:
			request.session['user_session'] = Something
		return request.session['user_session']
		
	@route('/')
	@view('market.tmpl')
	def market():
		_us = _init_root()
		return dict(name = _us.user_id)

其中 hook 這一段，設定只要有 request，就會先執行下面的程式：
	
.. code:: python

	# hook request to make the beaker session easier to get to
	@hook('before_request')
	def _setup_request():
			request.session = request.environ['beaker.session']

在 route 中可以用下列方法取得 session 資料：

.. code:: python

	# web server start here
	@route('/stk/<sid>')
	@view('stkinfo.tmpl')
	def stkinfo(sid):
		_us = request.session['user_session']
	return dict(name = _us.user_id, sid=sid)

在程式檔的最後加上讓程式可以執行：

.. code:: python

	if __name__ == '__main__':
		bottle.run(app=_app, host='localhost', port=9000, debug=True)
	else:
		application = _app

其中 ``application`` 是 python 和 uwsgi 溝通的物件，和 beaker 沒有關係。
