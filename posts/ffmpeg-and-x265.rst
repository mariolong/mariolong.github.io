.. title: ffmpeg and x265
.. slug: ffmpeg-and-x265
.. date: 2016-11-21 02:12:28 UTC
.. tags:
.. category:
.. link:
.. description:
.. type: text
.. category: computer

http://forum.doom9.org/showthread.php?t=172458

Suggestion for x265's --tune film
Several days ago we asked the x265's team how could we participate in the discussion, and they left me with e-mail address. When we finished writing the email, we are also glad to post it here so all of you are welcome to discuss about the topic: How to keep the film grain and details at higher quality when using x265?

We take several movie scenes with moderate level of film grain, rich details, and some dark scenes. Then we take out the tests between x264-10bit and x265-10bit:

(NOTE there are --input-depth 10 for both sets of parameters. Do NOT just copy and paste if you are not encoding 10-bit input)

x264: --preset veryslow --tune film --crf 19.0 --qcomp 0.75 --input-depth 10(a fairly trusted setting )

x265: --preset slower --ctu 32 --max-tu-size 16 --crf 20.0 --tu-intra-depth 2 --tu-inter-depth 2 --rdpenalty 2 --me 3 --subme 5 --merange 44 --b-intra --no-amp --ref 5 --weightb --keyint 360 --min-keyint 1 --bframes 8 --aq-mode 1 --aq-strength 1.0 --rd 5 --psy-rd 1.5 --psy-rdoq 5.0 --rdoq-level 1 --no-sao --no-open-gop --rc-lookahead 80 --scenecut 40 --max-merge 4 --qcomp 0.8 --no-strong-intra-smoothing --deblock -2:-2 --qg-size 16 --pbratio 1.2
(We've tested hundreds of parameter combinations and we conclude this set is the best outcome)

We compare the quality with our eyes, NOT psnr/ssim, which favors blurriness over grain keeping.
x264 gives an 118% size compared to x265, with nearly the same visual quality. We can also drop the bit-rate of x264 a bit, but then AVC outcome necessarily looks worse. At this point we believe x265 claims a victory, not at extremely low bit-rate cases where HEVC blurriness looks better than AVC blockiness, but rather a high-quality, near-transparent encoding.

Our test focus on several RC parameters: --ctu, --tu, --crf, --qcomp, --aq-mode, --aq-strength, --psy, --qcomp --qg-size...These parameters can alter RC behavior with minor impact on the speed. We took some iterative method with genetic algorithms to select the possibly best parameter sets out of infinite.

Here are some of our comments:
--ctu, --max-tu-size: This two should be decreased in 1080p @ high-quality encoding. Keeping other parameters constant, tweaking --ctu 64->32, --tu 32->16 gives even better quality with nearly 15% of size-decrease, in crf mode. We assume that adopting larger CU and TU actually wastes the bit-rate by producing over-smoothed block, forcing bit-rate to rise in order to keep a "constant rate-factor". So we'd better just leave them smaller, at least under 1080p

--crf: x265 gives a default value 28. This is way too low to compete against x264's default value 23. Many users believe by tweaking crf they can choose between quality and size without other concerns, but they are wrong; sometimes, tweaking other parameters is more efficient. --crf need to be coupled with other parameters properly tuned.

--qcomp: the lower your crf, the higher the quality, and you should set --qcomp to be higher. This is also true for x264. Our test suggest --qcomp 0.8 is very essential when x265_crf<23.

--aq-mode: keep it at 1. aq-mode=3 gives wired bit-rate for nothing.

--aq-strength: default 1.0 is pretty good.

--psy: the primary weapon to fight blurriness. --psy-rd 1.5 --psy-rdoq 5.0 --rdoq-level 1 works better than --tune grain's settings, trust me.

--deblock -2:-2: This is also a rule of thumb since x264's era: using smaller numbers if you prioritize quality.

--qg-size 16: The larger number you set, the smaller file you get, but much worse quality for trade. Just change it to 16 instead of 64; this is worthy.

--no-sao: SAO smooths everything up. Do NOT use it unless you really want to.

--me_range 44: me_range has minor impact on speed when coupled with low level of me and subme; but that's not true for --me 3 --subme 5. Decrease it a bit in 1080p do you a favor with little sacrifice.

--no-rect --no-amp: They trade time for nothing. Do NOT enable them unless you really have time to waste.

So, here are our suggestions for x265 --tune film:

--ctu 32 --max-tu-size 16 --qcomp 0.8 --aq-mode 1 --aq-strength 1.0 --psy-rd 1.8 --psy-rdoq 5.0 --rdoq-level 1 --deblock -2:-2 --qg-size 16 --no-sao --me_range 44 --no-rect --no-amp

By setting these parameters, you can probably set your crf to be around 22~19, and it gives you considerably good output with small size. if you set crf=21~22, --qcomp 0.75 is recommended.
We don't see any advantage for x265 if you are targeting at x264_crf<=16. At that point x265 requires even more bit-rate to keep the details.

Furthermore, here are some other recommendations:

1. Except for --tune and --preset, add another parameter "--expectation" and let user specify whether he wishes a high, medium or low quality(with respective size). This can also be derived if --crf is specified. Then use the input to change the rc behaviors. For example, if the user is expecting high quality rather than a crf=28 blurriness, increase --qcomp to 0.8.

2. Change RC behaviors and speed options based on resolution. 720p/1080p/1440p/4K don't optimally share a same set of parameters. For example, --max-tu-size --ctu --me_range.

3. Give less bias/more penalty to bigger CUs and TUs, especially at higher quality expectation and lower resolution. --rd-penalty 2 is a very useful parameter, but it only prohibits TU size of 32x32. Let's impose more penalties to similar cases.


Thank you for patiently reading this email, and I'm ready to conclude it:
So far x265 team has done a fantastic job by offering the best encoder (at low bit-rate), but let us greedily urge more. We wish x265 to be best not only at low quality, but also best overall. At the same time, we are willing to help the team with our own effort.

Regards,
LittlePox

2015/08/11
