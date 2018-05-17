.. description: 
.. date: 2013/10/24 12:57:19
.. tags: 
.. slug: gnomean-zhuang-ji-lu
.. title: gnome 安裝記錄
.. link: 

安裝了 GNOME 3.10，使用的感覺很不錯，特別記錄一下安裝時碰到的困難，以利未來查詢可用。

安裝
========================================================================
::

	$ yaourt -S gnome gnome-extra ibus-rime ibus-chewing

配置
========================================================================

選擇字型
------------------------------------------------------------

個人喜好，我選擇的是 DejaVu 系列。字型要設好，不然，gnome-terminal 的字會擠在一起。
要不然就要再設定：*編輯->設定編輯組合偏好設定->一般->字型*

調整 ibus 字型大小
-------------------------------------------------------------

我目前覺得 gnome 3.10 和 IBus 整合的不錯，使用上沒有什麼問題。
但是，預設的字型實在是太小了，不改不行。
目前只能直接改 gnome-shell 的 css 檔：

.. code::

	$ sudo nano /usr/share/gnome-shell/theme/gnome-shell.css

找到

.. code::

	/* default text style */
	stage {
	font-family: sans-serif;
	font-size: 11pt;
	color: white;
	}

和

.. code::

	/* IBus Candidate Popup */

	.candidate-popup-content {
	padding: 0.2em;
	spacing: 0.2em;
	}

	.candidate-popup-text {
	font-size: 18pt;
	}

	.candidate-index {
	font-size: 14pt;
	padding: 0 0.5em 0 0;
	color: #cccccc;
	}

	.candidate-label {
	font-size:22px;
	letter-spacing: 1px;
	}

	.candidate-box {
	padding: 0.2em 0.5em 0.2em 0.5em;
	}

	.candidate-box:selected {
	border-radius: 4px;
	background-color: rgba(255,255,255,0.2);
	}

	.candidate-box:hover {
	border-radius: 4px;
	background-color: rgba(255,255,255,0.1);
	}
	.candidate-page-button-box {
	height: 2em;
	width: 80px;
	}

	.vertical .candidate-page-button-box {
	padding-top: 0.5em;
	}

	.horizontal .candidate-page-button-box {
	padding-left: 0.5em;
	}

	.candidate-page-button-previous {
	border-radius: 4px 0px 0px 4px;
	}

	.candidate-page-button-next {
	border-radius: 0px 4px 4px 0px;
	}

	.candidate-page-button-icon {
	icon-size: 1em;
	}

重啟 gnome shell，OK。

聲音
-------------------------------------------------------------	

gnome 的聲音也不好搞，預設用的是 PulseAudio，理論上是不用配置。
但它和 ALSA 配合不好，會找不到 sound device，當然就無法發聲。

參考 `[1]`_ 和 `[2]`_ ，節錄解決步驟如下：
::

	$ sudo gedit /etc/pulse/default.pa
	
找到 ``#load-module module-alsa-sink``，改成 ``load-module module-alsa-sink device=dmix``。

找到 ``load-module module-suspend-on-idle``，改成 ``#load-module module-suspend-on-idle``

找到 ``load-module module-hal-detect``，改成 ``#load-module module-hal-detect``

.. _[1]: http://nelson.pixnet.net/blog/post/22615924-%5B%E7%AD%86%E8%A8%98%5D-%E8%AE%93-alsa-%E8%B7%9F-pulseaudio-%E5%AE%8C%E7%BE%8E%E5%85%B1%E5%AD%98
.. _[2]: http://www.ubuntu-tw.org/modules/newbb/viewtopic.php?viewmode=compact&type=&topic_id=10102&forum=10
