## 資源

臨摹：[第十一篇 - 第一次自幹爬蟲就上手 - 使用 Ruby  (Yukai Huang)](https://yukaii.tw/blog/2015/05/03/how-to-write-web-crawler-for-the-first-time-using-ruby/)

路徑： `ezparser/examples/ex3`

<br>
## 範例3：爬中正大學課程網站

為了要實作跟教學一樣的步驟，去[中正大學課程網站](https://kiki.ccu.edu.tw/%7Eccmisp06/Course/index.html)最下面的，[其他學期(檔案名稱是學年學期)](https://kiki.ccu.edu.tw/%7Eccmisp06/Course/zipfiles/)，點進去後下載**1031.tgz**

解壓縮後的`1031`資料夾，拉到我們的專案底下

add `1031` to `ezparser/examples/ex3`

PS：果然有[中原爬蟲](https://github.com/colorgy/crawler-CYCU-course) XD，不過會用到Angular現在等級不夠暫時先別碰。

### 建檔案

create `ezparser/examples/ex3/crawler.rb`

create `ezparser/examples/ex3/Gemfile`

### 設定Gemfile

add to `ezparser/examples/ex3/Gemfile`

```
source 'https://rubygems.org'

gem 'nokogiri'
gem 'pry'
```

然後去專案下`bundle`

### 玩Pry

我們隨便開一個`1031`資料夾底下的檔案來看，可以看到他的網頁結構真的非常清楚簡單。現在我們用Pry來玩。

開啟irb，到專案底下打`pry`
```
ezparser/examples/ex3 on master
$ pry
[1] pry(main)>
```

Pry自己帶就有很美觀的畫面，先來讀一個檔案
```
pry(main)> str = File.read("1031/1016.html")
```

我們先下結尾不加`;`的，可以看到，讀到網頁的HTML結構，若是加`;`則不會印出
```
pry(main)> str = File.read("1031/1016.html");
```

然後我們來用前幾個範例學的，用`Nokogiri::HTML`來看HTML結構
```
pry(main)> doc = Nokogiri::HTML(str)
```

一樣先用沒有`;`的寫法來看，一直按空白鍵，看到END要跳出時按`q`就能跳出

我們可以看到很多`Nokogiri`自帶的東西，這實在有點閱讀困難，所以我們一樣用先前學過的`print doc`來看看吧
```
[6] pry(main)> doc = Nokogiri::HTML(str);
[7] pry(main)> print doc
```

若要跳出pry，只要下`exit`即可



我們看到了我們熟悉的，簡單清楚的HTML結構

### 動工

這篇講Nokogiri的`css`由於前兩個範例已經碰過，在此就不贅述了，直接開始上code

add to  `ezparser/examples/ex3/crawler.rb`


完整code
```

```

#####  設定要用到的gem

我們用`nokogiri`來爬，`pry`來抓蟲，把爬出的結果存成`json`存到`course.json`

```
require 'Nokogiri'
require 'pry'
require 'json'
```

##### 讀取1031資料夾下全部的html檔

fix `ezparser/examples/ex3/crawler.rb`

```
course = []
```

接著我們用`Dir.glob`獲得`1031`資料夾下的所有`.html`檔吧
```
Dir.glob('1031/*.html').each do |filename|
  str = File.read(filename)
  doc = Nokogiri::HTML(str.encode("utf-8", invalid: :replace, undef: :replace))

end
```

下面這段是原作者把檔案讀出的編碼去掉不合法和未定義的部分，不然存入json會出錯
```
doc = Nokogiri::HTML(str.encode("utf-8", invalid: :replace, undef: :replace))
```

###### Dir.glob
> `Dir.glob`就是一個抓取目錄下檔案的工具，對於`Dir.glob`的學習，推薦先簡單瀏覽[File类与Dir类 | ruby简明攻略](https://canon4ever.gitbooks.io/ruby/content/filelei_yu_dir_lei.html)的**Dir.glob**這節，接著去看官方的[Dir::glob](https://ruby-doc.org/core-2.2.2/Dir.html#method-c-glob)，直接拿這節的**Examples**範例code去`pry`來玩玩

> 例如：`Dir.glob("*.[a-z][a-z]") `
>```
ezparser/examples/ex3 on master
$ pry
[1] pry(main)> Dir.glob("*.[a-z][a-z]")
=> ["crawler.rb"]
```

> 例如：`File.join("**", "*.rb")`
```
[7] pry(main)> rbfiles = File.join("**", "*.rb")
=> "**/*.rb"
[8] pry(main)> Dir.glob(rbfiles)
=> ["crawler.rb"]
[9] pry(main)> jsonfiles = File.join("**", "*.json")
=> "**/*.json"
[10] pry(main)> Dir.glob(jsonfiles)
=> ["course.json"]
```

> 玩了幾個比較有感覺後，再去看上面的解說就比較有概念了

> 在我們的`examples/ex3`會用到的是`Dir.glob("*c")`：`Matches all files ending with c`

##### 寫好爬table的每一列

這邊我以`1031/1014.html`為例，為了方便閱讀，我把他稍微排版
```
<TABLE border=1>
  <TR bgcolor=YELLOW>
      <TH><FONT size=3>年級</TH>
      <TH><FONT size=3>編號</TH>
      <TH><FONT size=3>班別</TH>
      <TH><FONT size=3>科目名稱</TH>
      <TH><FONT size=3>任課教授</TH>
      <TH><FONT size=3>上課時數<BR>正課/實驗實習/書報討論</TH>
      <TH><FONT size=3>學分</TH>
      <TH><FONT size=3>選必</TH>
      <TH><FONT size=3>上課時間</TH>
      <TH><FONT size=3>上課地點</TH>
      <TH><FONT size=3>限修人數</TH>

      <TH><FONT size=3>課程大綱</TH>
      <TH><FONT size=3>備註</TH>
  </TR>

<TR>
  <TD bgcolor=#F4B780><FONT size=3>1</TD>
  <TD><FONT size=3>1011111</TD>
  <TD><FONT size=3>01</TD>
  <TD><FONT size=3>漢語語言學<br>Chinese Linguistics<BR> </TD>
  <TD><FONT size=3>黃惠華 </TD>
  <TD align=center><FONT size=3>2<BR>
      2/0/0</TD>
  <TD><FONT size=3>2</TD>
  <TD><FONT size=3>選修</TD>
  <TD><FONT size=3> 四4,5</TD>
  <TD><FONT size=3>文學院118</TD>
  <TD><FONT size=3>45</TD>

  <TD align=CENTER><FONT size=3><A href="http://ecourse.ccu.edu.tw/php/Courses_Admin/guest3.php?PHPSESSID=0466f8e4b492c9294334e34ad49e1de8&courseno=1011111_01&year=103&term=1" target=NEW>連結</A></TD>
  <TD><FONT size=3>本課程列入「華語文教學學分學程」<A href="../cgi-bin/class/Show_All_GRO.cgi"> ,列入華語文教學學程科目</A></TD>        
</TR>

<TR>
  ...
  ...
  ...
</TR>

...
...
...
```

它的結構可以簡化如下
```
<table>
  <tbody>
    <tr>....</tr>
    <tr>
      <td>...</td>
      <td>...</td>
      ...
    </tr>
  </tbody>
</table>
```

`table`下的第一個`tr`是**欄位名稱**，這是固定的，我們要爬的是第二個`tr`底下的`td`，所以我們不要第一個`tr`

fix `ezparser/examples/ex3/crawler.rb`
```
Dir.glob('1031/*.html').each do |filename|
  str = File.read(filename)
  doc = Nokogiri::HTML(str.encode("utf-8", invalid: :replace, undef: :replace))

  doc.css('table tr:not(:first-child)').each do |row|
    datas = row.css('td')


  end
end
```

> Nokogiri的語法很像jQuery，為了方便解釋`:not`與`:first-child`，可以直接去看[jQuery:first-child Selector](https://api.jquery.com/first-child-selector/)與[jQuery:not](https://api.jquery.com/not-selector/)的範例code來幫助理解。

##### 開始爬該列的每一個欄位

fix `ezparser/examples/ex3/crawler.rb`
```
Dir.glob('1031/*.html').each do |filename|
  str = File.read(filename)
  doc = Nokogiri::HTML(str.encode("utf-8", invalid: :replace, undef: :replace))

  doc.css('table tr:not(:first-child)').each do |row|
    datas = row.css('td')

    course << {
      grades: datas[0] && datas[0].text,
      serial: datas[1] && datas[1].text,
      class_type: datas[2] && datas[2].text,
      name: datas[3] && datas[3].text,
      lecturer: datas[4] && datas[4].text,
      credits: datas[6] && datas[6].text,
      required_or_elective: datas[7] && datas[7].text,
      time_location: datas[8] && datas[8].text,
      type: datas[10] && datas[10].text,
      outline: datas[11] && datas[11].css('a')[0] && datas[11].css('a')[0][:href],
      note: datas[12] && datas[12].text
    }

  end
end
```

這樣寫會爬出什麼呢，讓我們再看一次這table的結構
```
<TH><FONT size=3>年級</TH>
<TH><FONT size=3>編號</TH>
<TH><FONT size=3>班別</TH>
<TH><FONT size=3>科目名稱</TH>
<TH><FONT size=3>任課教授</TH>
<TH><FONT size=3>上課時數<BR>正課/實驗實習/書報討論</TH>
<TH><FONT size=3>學分</TH>
<TH><FONT size=3>選必</TH>
<TH><FONT size=3>上課時間</TH>
<TH><FONT size=3>上課地點</TH>
<TH><FONT size=3>限修人數</TH>

<TH><FONT size=3>課程大綱</TH>
<TH><FONT size=3>備註</TH>
```

我們少了`[5]`、`[9]`，也就是說我們沒有爬**上課時數**、**上課地點**

至於**課程大綱**為何要這樣爬
```
outline: datas[11] && datas[11].css('a')[0] && datas[11].css('a')[0][:href],
```

我們只要把課程大綱那列的HTML的`td`結構稍作整理，就一目瞭然了

from

```
  <TD align=CENTER><FONT size=3><A
  href="http://ecourse.ccu.edu.tw/php/Courses_Admin/guest3.php?PHPSESSID=0466f8e4b492c9294334e34ad49e1de8&courseno=1011111_01&year=103&term=1"
  target=NEW>連結</A></TD>
```

to

```
<TD align=CENTER><FONT size=3>
  <A
  href="http://ecourse.ccu.edu.tw/php/Courses_Admin/guest3.php?PHPSESSID=0466f8e4b492c9294334e34ad49e1de8&courseno=1011111_01&year=103&term=1"
target=NEW>連結
  </A>
</TD>
```

###### <<
> `course << { ... }`我是辜狗下`ruby double less`這關鍵字，找到[What does << mean in Ruby?](http://stackoverflow.com/questions/6852072/what-does-mean-in-ruby)這篇，然後查看[Array#<<](http://ruby-doc.org/core-2.3.1/Array.html#method-i-3C-3C)，才知道Ruby的Array有這樣串接的寫法，一樣去複製他的example code去pry跑會比較有感覺。

###### atas[1] && datas[1].text
> 我們在`example/ex1`學過，若要指定 item [1] 的 text，可以寫
```
doc.xpath("//h3/a")[1].text
```
這邊的`datas[1] && datas[1].text`就是這概念

##### 存到json去
