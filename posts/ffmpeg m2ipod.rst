.. slug: ffmpeg-xin-de
.. link:
.. title: ffmpeg 使用心得與整理
.. tags: Linux
.. description:
.. date: 2013/05/02 10:45:30

ffmpeg 使用心得
===============

使用了一陣子的 FFMpeg 處理影片，越用越喜歡這套軟體。

一開始，為了要將影片轉成 ipod touch 3 代可用的格式，特別學習 ffmpeg，試了好幾天，終於找出來滿意的方法，特此記錄下來，免得忘了。

轉檔時的指令
------------

::

    ffmpeg -i $1 -s 720x406 -vpre ipod -ac 2 -sn -vf subtitles=$1.srt $1.mp4

其中

-i $1
    $1 是要轉檔的檔名

-s 720x406
 是設定轉檔後的解析度，406 = 720 * 720 / 1280，（原始檔的解析度為 1280x720）。這個一定要去計算，不然，在電視上看，畫面比例會不對，字幕可能出不來。

-vpre ipod
 是為了 ipod 特別找出來的 preset，設定如後。

--ac 2
 是轉成立體聲，不然 ipod touch 沒辦法播放。

--sn
 不顯示原始檔中的字幕。因為，我要用另外的字幕檔。

--vf subtitles
 為 srt 字幕檔。

preset 設定
-----------

preset 可以放在 ~/.ffmpeg，檔名為 *arg*.ffpreset。
例如，我設定了一個專門轉到 ipod touch 的 preset 檔，命名為 ipod.ffpreset。
::

    strict=-2

    vcodec=libx264
    vprofile=main
    level=30
    maxrate=10000000
    bufsize=10000000

    preset=fast
    #preset=slower

    crf=20
    #bf=0
    #refs=1

    #ab=192k

字幕
====

參考
`How to burn subtitles into the video
<http://ffmpeg.org/trac/ffmpeg/wiki/How%20to%20burn%20subtitles%20into%20the%20video>`_

原檔中已有圖片格式的字幕
------------------------

原檔中已有圖片格式的字幕時，可直接燒錄：
::

    -filter_complex '[0:v][0:s:1]overlay[v]' -map [v] -map 0:a

此處 -map 一定要下，不然會有錯誤訊息。
其中 `-map 0:a` 是指所有的音軌，也可以直接指定音軌 `-map 0:1`

出現的訊息如下：
::

    Stream mapping:
      Stream #0:0 (h264) -> overlay:main (graph 0)
      Stream #0:4 (pgssub) -> overlay:overlay (graph 0)
      overlay (graph 0) -> Stream #0:0 (libx264)

加入外部字幕檔
--------------

1. 自行編輯字幕檔
~~~~~~~~~~~~~~~~~

這個很少用到，在 linux 中，就找到 aegisub 是可用的，那就拿來用了，沒有什麼特別的考慮。

2. 提取 mkv 內 srt 或 ass 字幕
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

提取 mkv 內的文字字幕，用
::

    ffmpeg -i $1.mkv -vn -an -scodec copy $1.ssa

或：
::

    ffmpeg -i $1.mkv -vn -an -scodec copy $1.srt

有時會出現下列的錯誤訊息，內嵌的應該就是圖片格式字幕。
::

    Could not write header for output file #0 (incorrect codec parameters ?): Operation not permitted

爲了能改變字型大小，使用 ass 格式。

3. srt
~~~~~~

先轉成 ssa 檔，
::

    ffmpeg -i s.srt s.ssa

s.ssa 中加上
::

    ; 同步字幕
    Synch Point:0
    ; PlayResX/Y 影片解析度
    PlayResX:720
    PlayResY:480
    ; 調整字幕速度
    Timer:100.0000

作出 ssa 檔後，可以用文字編輯器開啓，修改一下 fontname 和 fontsize，讓字型美一點。
各參數用法見 `ASS 字幕格式 <http://hkgoldenmra.blogspot.tw/2013/01/ass.html>`_

如果不想控制字幕格式，就不須轉成 ass 格式，就用下列指令燒錄到影片。
::

    -vf subtitles=sub.srt

4. 字幕轉成繁體
~~~~~~~~~~~~~~~

可以再用 opencc 把字幕轉成繁體：
::

    opencc -i $1.ssa -o o.ssa

5. ass
~~~~~~

用 -vf 燒錄到影片中。
::

    -vf ass=s.ssa

或直接加入影片中，不是燒錄上去。
::

    ffmpeg -i video.avi -i sub.ass -map 0:0 -map 0:2 -map 1 -c:a copy -c:v copy -c:s copy video.mkv

其中 video.avi 有一個視頻軌、兩個音頻軌，取其中的視頻軌 (mpa 0:0) 和第二個音頻軌 (map 0:2)
加 sub.ass (map 1) 做成 video.mkv 而不重新編碼。

重點注意： -i sub.ass -map 1 -c:s copy。
此處的 sub.ass 也可以是 sub.srt。

影片翻轉
========
::

   -vf transpose=2

transpose=1 順時針 90 度

transpose=2 逆時針 90 度

完整指令
::

   $ ffmpeg -i 20150913145954.m2ts -c:a copy -q:v 0 -c:v libx264 -vf transpose=1 20150913145954.mkv

轉成 mkv 是為了保留原來聲音的品質

合併多個影片
============

參考 `How to concatenate (join, merge) media files
<http://ffmpeg.org/trac/ffmpeg/wiki/How%20to%20concatenate%20%28join,%20merge%29%20media%20files>`_

mpeg::

    ffmpeg -i "concat:input1.mpg|input2.mpg|input3.mpg" -c copy output.mpg

not mpeg::

    This is easiest to explain using an example::

        ffmpeg -i input1.mp4 -i input2.webm \
        -filter_complex '[0:0] [0:1] [1:0] [1:1] concat=n=2:v=1:a=1 [v] [a]' \
        -map '[v]' -map '[a]' <encoding options> output.mkv

    On the -filter_complex line, the following:

    '[0:0] [0:1] [1:0] [1:1]
    tells ffmpeg what streams to send to the concat filter;
    in this case, streams 0 and 1 from input 0 (input1.mp4 in this example),
    and streams 0 and 1 from input 1 (input2.webm).

    concat=n=2:v=1:a=1 [v] [a]'
    This is the concat filter itself. n=2 is telling the filter that there are two input files;
    v=1 is telling it that there will be one video stream;
    a=1 is telling it that there will be one audio stream.
    [v] and [a] are names for the output streams, to allow the rest of the ffmpeg line to use the output of the concat filter.

    Note that the single quotes ' ' around the whole filter section are required.

    -map '[v]' -map '[a]'
    This tells ffmpeg to use the results of the concat filter rather than
    the streams directly from the input files.

catflv
------

寫了個小小的 script，用來合併 flv，並轉成 ipod 可用的 mp4。
::

    #!/bin/bash

    icnt=0

    for file in $@
    do
        filenames="$filenames -i $file "
        scat="$scat[$icnt:0][$icnt:1]"

        #echo $filenames, [$icnt], $scat
        icnt=$(($icnt+1))

    done

    scmd="ffmpeg $filenames -filter_complex '$scat concat=n=$#:v=1:a=1 [v] [a]' -map '[v]' -map '[a]' -vpre ipod -ab 132k out.mp4"
    echo $scmd
    eval $scmd

合併 mp4
--------
::

    fmpeg -i s1.mp4 -c copy -vbsf h264_mp4toannexb out1.ts
    fmpeg -i s2.mp4 -c copy -vbsf h264_mp4toannexb out2.ts
    cat out[12].ts | ffmpeg -i - -c copy -absf aac_adtstoasc ab.mp4

MKV 轉成 mp4
------------

如果要在 ipod 或智慧型手機上看，那就不需要太考慮品質，能用就好。
就用上面轉好的 mkv 檔，再轉一次。
如此，既可以用 mkv 保存高品質的影片，再轉成 mp4 的速度也比較快。

這是要注意字幕是圖片格式或是 srt/ass 文字式。

字幕是圖片格式
~~~~~~~~~~~~~~

用 -filter_complex 直接燒錄：
::

    $ ffmpeg -i a.mkv \
    -filter_complex '[0:v][0:s:1]overlay[v]' -map [v] -map 0:a \
    -vpre ipod -ac 2 -ab 192k \
    -y a.mp4

字幕是 srt 或 ass
~~~~~~~~~~~~~~~~~

1. 先處理字幕檔 (前述)

2. 用 -vf subtiles=a.srt 或 -vf ass=a.ass 把字幕燒進 mp4 中。
::

    $ ffmpeg -i a.mkv \
    -vpre ipod -ac 2 -ab 192k \
    -vf subtitles=a.srt \
    -y a.mp4

metadata
======================================================================

參考 `ffmpeg <http://ffmpeg.org/ffmpeg.html>`_

加入名稱 (title)
----------------

-metadata[:metadata_specifier] key=value (output,per-metadata)
Set a metadata key/value pair.

An optional metadata_specifier may be given to set metadata on streams or chapters.
See -map_metadata documentation for details.

This option overrides metadata set with -map_metadata.
It is also possible to delete metadata by using an empty value.

For example, for setting the title in the output file
::

    ffmpeg -i in.avi -metadata title="my title" out.flv

To set the language of the first audio stream
::

    ffmpeg -i INPUT -metadata:s:a:1 language=eng OUTPUT

例子：
::

    -metadata:s:1 title="日語" -metadata:s:2 title="國語" -metadata:s:3 title="中文"

加入章節
--------

-map_metadata[:metadata_spec_out] infile[:metadata_spec_in] (output,per-metadata)’

Set metadata information of the next output file from infile. Note that those are file indices (zero-based), not filenames. Optional metadata_spec_in/out parameters specify, which metadata to copy. A metadata specifier can have the following forms:

‘g’
    global metadata, i.e. metadata that applies to the whole file

‘s[:stream_spec]’
    per-stream metadata. stream_spec is a stream specifier as described in the Stream specifiers chapter. In an input metadata specifier, the first matching stream is copied from. In an output metadata specifier, all matching streams are copied to.

‘c:chapter_index’
    per-chapter metadata. chapter_index is the zero-based chapter index.

‘p:program_index’
    per-program metadata. program_index is the zero-based program index.

If metadata specifier is omitted, it defaults to global.

By default, global metadata is copied from the first input file,
per-stream and per-chapter metadata is copied along with streams/chapters.
These default mappings are disabled by creating any mapping of the relevant type.
A negative file index can be used to create a dummy mapping that just disables automatic copying.

For example to copy metadata from the first stream of the input file to global metadata of the output file::

    ffmpeg -i in.ogg -map_metadata 0:s:0 out.mp3

To do the reverse, i.e. copy global metadata to all audio streams::

    ffmpeg -i in.mkv -map_metadata:s:a 0:g out.mkv

Note that simple 0 would work as well in this example, since global metadata is assumed by default.

‘-map_chapters input_file_index (output)’
    Copy chapters from input file with index input_file_index to the next output file.
    If no chapter mapping is specified, then chapters are copied from the first input file with at least one chapter.
    Use a negative file index to disable any chapter copying.


convert mp4 to jpg
==================

htc new one 有個連拍的功能，她是存成 mp4 檔，爲了把 mp4 還原爲 jpg，
可以用下列指令
::

    $ ffmpeg -i M4H08111.MP4 -b 2000 -qscale 1 -qcomp 0 -qblur 0 foo-%03d.jpeg
    $ ffmpeg -i 20131112115026.m2ts -an -ss 00:00:18 -t 2 -b 2000 -qscale 1 -qcomp 0 -qblur 0 wuo-shuo-%03d.jpg

jpg 基本擷圖範例::

  ffmpeg -i test.flv -an -ss 00:00:10 -y test.jpg

jpg 進階擷圖範例::

  ffmpeg -i test.flv -an -ss 00:00:42 -r 10 -vframes 70 -y NolanRyan-%d.jpg

-i：影片名稱
-an：把音訊 audio 取消
-ss：00:00:42 從第 42 秒鐘開始擷取
-r：10 每秒抓 10 張圖 (單位是 Hz，所以這個值設得越高，每秒鐘抓出來的圖檔越多)
-vframes：70 總共要抓 70 張圖，與上面的 -r 10 搭配之下，表示要抓長達 70/10 = 7 秒鐘的影像，並轉換成圖檔。
-y %d.jpg：表示抓出來的圖檔副檔名為 jpg，而檔名 %d 表示圖檔檔名會以數字 digit 的型式自動編號。

音量調整
========

改變音量
--------

如果要改變音量，你可以使用 volume filter，用法如下。

0.5 倍音量::

  ffmpeg -i input.wav -af "volume=0.5" output.wav

1.5 倍音量::

  ffmpeg -i input.wav -af "volume=1.5" output.wav

使用分貝單位::

  ffmpeg -i input.wav -af "volume=5dB" output.wav

音量正常化
----------

如果要將一個音訊的音量正常化，可以使用 volumedetect 檢測音量峰值 (max_volume)，
然後使用 volume filter 將音量峰值歸零或接近零即可，如果音量峰值是 -6 dB 則提高 6
dB 就能歸零。

例如要將一個 WAV 音訊轉為 AAC 格式並將音量正常化，
首先，使用 VolumeDetect 檢測音量::

  ffmpeg -i input.wav -af "volumedetect" -f null -

假設 VolumeDetect 輸出訊息為::

  [Parsed_volumedetect_0 @ 0x7f8ba1c121a0] mean_volume: -16.0 dB

  [Parsed_volumedetect_0 @ 0x7f8ba1c121a0] max_volume: -5.0 dB

  [Parsed_volumedetect_0 @ 0x7f8ba1c121a0] histogram_0db: 87861

由上面輸出訊息得知音量峰值 (max_volume) 為 -5 dB，
所以要將音量峰值歸零需要提高 5dB。
::

   ffmpeg -i input.wav -af "volume=5dB" output.aac

Downmixing
----------

如果用了 pan filter 或是 -ac 選項來混合聲道 (Mix channels) ，你會發現輸出的音
訊的音量變小
可以用同樣的參數設定加上 volumedetect filter 來檢測混合聲道後的音量。

將多聲道降混 (downmix) 為雙聲道::

  ffmpeg -i 6ch.mkv -ac 2 2ch.mkv

你可以發現輸出音訊的音量變小，
如果需要正常化音量必須先使用 VolumeDetect filter 檢測 downmix 之後的音量。

使用 VolumeDetect 檢測 downmix 之後的音量::

  ffmpeg -i 6ch.mkv -ac 2 -af "volumedetect" -f null -

注意因為是要檢測 downmix 為雙聲道之後的音量所以 -ac 2 是必要的。

假設 VolumeDetect 輸出訊息為::

  [Parsed_volumedetect_0 @ 00600c60] n_samples: 814080

  [Parsed_volumedetect_0 @ 00600c60] mean_volume: -29.5 dB

  [Parsed_volumedetect_0 @ 00600c60] max_volume: -7.9 dB

由上面輸出訊息得知音量峰值 (max_volume) 為 -7.9 dB，
所以要將音量峰值歸零需要提高 7.9dB。

將多聲道降混 (downmix) 為雙聲道並正常化音量::

  ffmpeg -i 6ch.mkv -ac 2 -af "volume=7.9dB" 2ch.mkv


參考資料
========================================================================

#. `FFmpeg wiki: x264EncodingGuide <https://ffmpeg.org/trac/ffmpeg/wiki/x264EncodingGuide>`_
