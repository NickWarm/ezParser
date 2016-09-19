# RailsFun 2016/9/7 爬蟲學習筆記

當天meetup筆記：[Railsfun 0907 - hackpad.com](https://hackpad.com/Railsfun-0907-fzkwOww6RXq)

感謝9/7當天三位講者的分享。

先前完全沒碰過爬蟲，會的Ruby也只有rails初學者堪用的程度，當天完全跟不上進度。


<br>
以下是我為了學習爬蟲，依序臨摹的範例，程式碼在`examples`，筆記在`wiki`。

1. [Nokogiri 教學、簡介 | 艾瑞克王](http://wwssllabcd.github.io/blog/2012/10/25/how-to-use-nokogiri/)

2. [爬蟲系列文 - Ruby爬蟲初探 « Carlos' notes](http://carlos-blog.logdown.com/posts/2016/06/10/reptile-series-approach)

3. [第十一篇 - 第一次自幹爬蟲就上手 - 使用 Ruby  (Yukai Huang)](https://yukaii.tw/blog/2015/05/03/how-to-write-web-crawler-for-the-first-time-using-ruby/)

  + [crawler-template: 一個爬蟲範本 ](https://github.com/Yukaii/crawler-template) (這個用看的就好了)

4. [用 Ruby 做網頁爬蟲](http://mgleon08.github.io/blog/2016/02/07/ruby-crawler/)

5. [Steven教的最初範例：爬ezprice](https://hackpad.com/Railsfun-0907-fzkwOww6RXq#:h=ezprice)

一樣[GitHub的wiki]()有教學。

# 你可以從這專案得到

這學習筆記完整記錄，我學習爬蟲過程中遇到**所有問題與掙扎**。

讓我自己教會自己
* 用Nokogiri爬蟲的基本語法，從最初學習使用`xpath`，到現在使用`css`。
* 從把網址存到本地端，使用`File.read`讀，進步到使用`open-uri`讀網址，到現在使用`rest-client`。
* 學會如何使用Pry來設中斷點debug
* 體會臨摹帖子時，只學**最少必要的知識量**是什麼感覺。

這些之中，最有價值的應該是學會用Pry吧。

1. 我學會查[Ruby Core](http://ruby-doc.org/core-2.3.1/)時先看**Example code**，然後把這程式碼用到Pry裡去。
  * 這樣的好處是「我先看到程式執行的結果，腦中已經有了畫面，再去看文字的解釋，會讓我學習時更快速理解」

2. 透過`binding.pry if ....`給一個判斷式來判斷**程式哪裡出錯**


# ToDo

* 爬大同大學選課系統
 + 原本是打算把[Steven的教材：爬大同大學的課表](https://hackpad.com/Railsfun-0907-fzkwOww6RXq)這個範例臨摹完，串好rails才上GitHub，誰知道2016/9/19爬個三次後，大同選課系統的網站就連不上去了...。`ex6`是未完成的屍體，只有等大同的網站弄好後，再來半夜人少時練爬蟲了

* 串rails

* 學習Regex

* 我自己精選，準備臨摹的專案 (把這些練完我應該也轉職成大大了XD)
  + [Yukaii/DonHuaBooks: 東華出版的爬蟲](https://github.com/Yukaii/DonHuaBooks)
  + [Yukaii/cgu-courses-spider: 寫給長庚的課程爬蟲](https://github.com/Yukaii/cgu-courses-spider)
  + [Yukaii/ntnu-courses-spider: 寫給師大的課程爬蟲](https://github.com/Yukaii/ntnu-courses-spider)
  + [Yukaii/ttu-courses-spider  大同大學的爬蟲](https://github.com/Yukaii/ttu-courses-spider)
  + [Yukaii/ntust-courses-spider: 寫給 118 的課程爬蟲](https://github.com/Yukaii/ntust-courses-spider)
  + [Yukaii/ntu-courses-spider: 寫給112](https://github.com/Yukaii/ntu-courses-spider)
  + [ntust-news-parser : 台科大網站 - 新聞專區的 ruby 爬蟲範例](https://github.com/Yukaii/ntust-news-parser/blob/master/parser.rb)
  + [Yukaii/GaoLiBooks: 高立出版社的爬蟲](https://github.com/Yukaii/GaoLiBooks)
  + [Yukaii/Fakpy: 目標成為愛情公寓界的新聞小幫手](https://github.com/Yukaii/Fakpy)
