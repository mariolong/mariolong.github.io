.. title: pip: python library
.. slug: pip-python-library
.. date: 2015-01-26 12:51:50 UTC
.. tags: python
.. category: computer
.. link:
.. description:
.. type: text


全部重新安裝已安裝的 python 程式
::

   $ pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs sudo pip install -U


安裝特定版本的套件
::

   $ sudo pip install "pep8==1.5.7"
