.. title: 在 Archlinux 安裝 nginx
.. slug: an-zhuang-nginx
.. date: 2014/02/07 11:13:56
.. tags: nikola, nginx
.. category: computer
.. link:
.. description:
.. type: text

用 nikola 寫了些 blog，裝上 nginx 只是為了能在 localhost 看看這些文章。
很大材小用吧。

安裝
====

.. code::

    yaourt -S nginx

配置
====

.. code::

    sudo nano /etc/nginx/nginx.conf

預設的 nginx.conf 的結構很單純。``$ grep -v '#' /etc/nginx/nginx.conf``

.. code::

    worker_processes  1;

    events {
        worker_connections  1024;
    }


    http {
        include       mime.types;
        default_type  application/octet-stream;

        sendfile        on;

        keepalive_timeout  65;

        server {
            listen       80;
            server_name  localhost;

            location / {
                root   /usr/share/nginx/html;
                index  index.html index.htm;
            }

            error_page   500 502 503 504  /50x.html;
            location = /50x.html {
                root   /usr/share/nginx/html;
            }
        }
    }


以下是我的設定

.. code::

    worker_processes  1;

    events {
        worker_connections  1024;
    }

    http {
        include       mime.types;
        default_type  application/octet-stream;

        sendfile        on;
        keepalive_timeout  65;

        server {
            listen       8000;
            server_name  localhost;
            location / {
                root   /home/mariolong/Programing/wen-de-www/www/output;
                index  index.html index.htm;
            }
            error_page   500 502 503 504  /50x.html;
            location = /50x.html {
                root   /usr/share/nginx/html;
            }
        }

        server {
            listen       8088;
            server_name  localhost;

            location / {
                root /home/mariolong/Documents/myBlog/output;
                index  index.html index.htm;
            }
        }
    }

如此配置好，文章寫好後，只要 ``nikola build`` 即可，不必再 ``nikola serve``。

回到 browser 中，直接訪問文章就好，方便多了。

啟動
====

以下分別為啟動、重啟、停止、開機啟動

.. code::

    sudo systemctl start nginx
    sudo systemctl restart nginx
    sudo systemctl stop nginx
    sudo systemctl enable nginx

結論
====

在 archlinux 中用 nginx 真是容易。
當然，這個只是我玩玩而已，可不能當成生產環境。

下一個要處理的是 bottle 和 nginx 合作的網頁程式。
