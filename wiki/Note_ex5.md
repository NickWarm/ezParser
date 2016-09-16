# 資源

臨摹：[Steven教的最初範例：爬ezprice](https://hackpad.com/Railsfun-0907-fzkwOww6RXq#:h=ezprice)

路徑： `ezparser/examples/ex5`

<br>
# 範例5：

為了練這範例，東找西找找了前面四個範例臨摹，現在終於可以著手開始了。

若是沒安裝過RestClient，請先用irb安裝。
```
gem install rest-client
```



### 引用需要的檔案

create `examples/ex5/ezprice.rb`

```
require 'nokogiri'
require 'rest-client'
require 'pry'
require 'nokogiri'
require 'awesome_print'
```

### 寫好run程式碼的架構

fix `examples/ex5/ezprice.rb`

```
require 'nokogiri'
require 'rest-client'
require 'pry'
require 'nokogiri'
require 'awesome_print'

class SimpleGetCrawler
  def self.go!

  end
end

SimpleGetCrawler.go!

```
###### self
>對於**self**可以看[self | 邁向 Rails 高級新手](https://airsonwayne.gitbooks.io/rocodev-practice-series/content/chapter3-ruby/self.html)。一樣，我們直接操Pry這example code，就很清楚瞭解了。實際打過這範例後，再看[Self in Ruby | Jimmy Cuadra]()這篇，就很清楚了。

```
ezParser/examples/ex5 on master*
$ pry
[1] pry(main)> class Foo
[1] pry(main)*   def self.foo
[1] pry(main)*     "class method"
[1] pry(main)*   end
[1] pry(main)*   def foo
[1] pry(main)*     "instance method"
[1] pry(main)*   end
[1] pry(main)*   def foobar
[1] pry(main)*     self.foo
[1] pry(main)*   end
[1] pry(main)* end
=> :foobar
[2] pry(main)> Foo.foo
=> "class method"
[3] pry(main)> Foo.foobar
NoMethodError: undefined method `foobar' for Foo:Class
from (pry):13:in `__pry__'
[4] pry(main)> f = Foo.new
=> #<Foo:0x007f8ec2be8338>
[5] pry(main)> f.foobar
=> "instance method"
```

###### !
>印象中`!`在Ruby是永久改變某東西，辜狗看到[Why are exclamation marks used in Ruby methods?](http://stackoverflow.com/questions/612189/why-are-exclamation-marks-used-in-ruby-methods)這篇，跟我想得一樣

### 目標：爬出商品的「名稱、價錢」

我們的目標是爬出商品的「名稱、價錢」，一開始一樣要先研究我們要怎麼爬。這個範例我們去[EZprice比價網](http://ezprice.com.tw/)搜尋[大同電鍋](http://ezprice.com.tw/s/%E5%A4%A7%E5%90%8C%E9%9B%BB%E9%8D%8B/price/)，我們看到**符合 大同電鍋 比價結果的推薦商品**這邊，從上往下拉有一整排商品，我點選第一個**TATUNG大同電鍋10人份(TAC-10A)** 然後用chrome工具查看。

![1](../examples/ex5/images/1.png)

我們可以看到搜尋出來的商品，從上而下他的HTML結構是
```
div.pd-list > ul > li.pd-li.ad-ez + div.goto_market + li.pd-li + li.pd-li + li.pd-li + ...
```

![2](../examples/ex5/images/2.png)

而我們點選的**TATUNG大同電鍋10人份(TAC-10A)** 它的結構是
```
li.pd-li > div.pdimg + div.srch_content + a.link-block
```

`div.srch_content`的子結構
```
div.srch_content > div.srch_c_l + div.srch_c_r
```

而各自裡面又有
```
div.srch_content > div.srch_c_l > div.srch_pdname > a[title="TATUNG大同電鍋10人份(TAC-10A)"]
```

![3](../examples/ex5/images/3.png)

與
```
div.srch_content > div.srch_c_r > div.price_range + div.shop_count + link + a
```

![4](../examples/ex5/images/4.png)

知道結構後我們就很愉快啦

我們先抓到一整排商品`div.pd-list > li`。

接著我們從`li.pd-li > div.srch_content > div.srch_c_l > div.srch_pdname > a > h3{TATUNG大同電鍋10人份(TAC-10A)}`取出商品名稱


![5](../examples/ex5/images/5.png)

從`li.pd-li > div.srch_content > div.price_range > span[itemprop="price" content="1990"]`取出商品價格數字

![6](../examples/ex5/images/6.png)

### 從網頁讀資料

fix `examples/ex5/ezprice.rb`

在這次的範例，我們用`rest-client`來讀網址，過去我們用`open-uri`把讀到的網址全部拿去給Nokogiri爬，但這次我們用`rest-client`可以把讀到的網址只取HTML結構中的`body`拿去給Nokogiri爬。

```
class SimpleGetCrawler
  def self.go!
    response = RestClient.get("http://ezprice.com.tw/s/%E5%A4%A7%E5%90%8C%E9%9B%BB%E9%8D%8B/price/")
    doc = Nokogiri::HTML(response.body)
  end
end
```

在此我們先來看一下剛剛裝的`awesome_print`的效果
```
class SimpleGetCrawler
  def self.go!
    response = RestClient.get("http://ezprice.com.tw/s/%E5%A4%A7%E5%90%8C%E9%9B%BB%E9%8D%8B/price/")
    doc = Nokogiri::HTML(response.body)

    ap doc
  end
end
```

然後去`iTerm`，在`zParser/examples/ex5`下
```
ruby ezprice.rb
```

可以看到，比用傳統的`print doc`畫面精美許多

###### RestClient
>比`open-uri`功能更強大的`rest-client`。

>一開始我是先看ihower的[Ruby HTTP clients](https://ihower.tw/blog/archives/2941)這篇文章，知道RestClient是透過 HTTP 抓取資料的工具。

>初學[rest-client的GitHub](https://github.com/rest-client/rest-client)看該專案的`README.md`就有像我這種新手需要的知識。我們先看[Usage: Raw URL](https://github.com/rest-client/rest-client#usage-raw-url)的**Basic usage**這節，知道RestClient的`post`與`get`就是HTML Verb的POST、GET，實例可以看[REST Client Example in Ruby](https://webdevsurya.wordpress.com/2014/03/18/rest-client-example-in-ruby/)這篇。

>再來看**More detailed examples:** 這節，就知道怎麼用了。不過只是看example code沒感覺，所以我們一樣操Pry吧。這次我拿ihower的[Ruby on Rails實戰聖經](https://ihower.tw/rails4/)來玩玩

```
ezParser/examples/ex5 on master*

$ pry
[1] pry(main)> require 'rest-client'
=> true
[2] pry(main)> RestClient.get 'https://ihower.tw/rails4/'
=> <RestClient::Response 200 "<!DOCTYPE h...">
[3] pry(main)> response = RestClient.get 'https://ihower.tw/rails4/'
=> <RestClient::Response 200 "<!DOCTYPE h...">
[4] pry(main)> response.code
=> 200
[5] pry(main)> response.cookies
=> {}
[6] pry(main)> response.headers
=> {:server=>"nginx",
 :date=>"Thu, 15 Sep 2016 06:31:06 GMT",
 :content_type=>"text/html",
 :last_modified=>"Thu, 07 Jul 2016 05:00:58 GMT",
 :transfer_encoding=>"chunked",
 :connection=>"keep-alive",
 :vary=>"Accept-Encoding",
 :etag=>"W/\"577de20a-2dc6\"",
 :strict_transport_security=>"max-age=31536000",
 :x_content_type_options=>"nosniff",
 :x_xss_protection=>"1; mode=block",
 :content_encoding=>"gzip"}
[7] pry(main)> response.body
=>..... (一大串，要退出請按q)
```

###### Awesome print
>可以先瀏覽[試用 awesome_print Gem](http://sikaplayground.blogspot.tw/2014/08/awesomeprint-gem.html)這篇，然後再去[awesome_print的GitHub](https://github.com/awesome-print/awesome_print)看[Examples](https://github.com/awesome-print/awesome_print#examples)直接操Pry

```
ezParser/examples/ex5 on master*
$ pry
[1] pry(main)> require "awesome_print"
=> true
[2] pry(main)> data = [ false, 42, %w(forty two), { :now => Time.now, :class => Time.now.class, :distance => 42e42 } ]
=> [false, 42, ["forty", "two"], {:now=>2016-09-16 21:04:14 +0800, :class=>Time, :distance=>4.2e+43}]
[3] pry(main)> ap data
[
    [0] false,
    [1] 42,
    [2] [
        [0] "forty",
        [1] "two"
    ],
    [3] {
             :now => 2016-09-16 21:04:14 +0800,
           :class => Time < Object,
        :distance => 4.2e+43
    }
]
=> nil
```
可以看到畫面整個變得非常精美，結構清楚。

###

fix `examples/ex5/ezprice.rb`

```
class SimpleGetCrawler
  def self.go!
    response = RestClient.get("http://ezprice.com.tw/s/%E5%A4%A7%E5%90%8C%E9%9B%BB%E9%8D%8B/price/")
    doc = Nokogiri::HTML(response.body)
    list = []
    doc.css(".pd-list li").each_with_index do |pd, index|
      hash = {}

      list << hash
    end
    ap list
  end
end
```

寫到這邊，有沒有感覺很像我們`ex3`的架構。

###### each_with_index
>[Enumerable#each_with_index](http://ruby-doc.org/core-2.3.1/Enumerable.html#method-i-each_with_index)，一樣看到**example code**。如果你跟我一樣第一次看時不是很懂，可以看[Arrays: map & eachwithindex](https://blog.hothero.org/2015/05/29/ruby-on-rails-cool-stuff-tip/)這篇，不過第一個範例的寫法是錯的。

錯的，哪有`{}`與`do`連用，應該是只有`{}`或只有`do...end`。

```
['a', 'b', 'c'].each_with_index do { |item, index|
  puts "#{index}-#{item}"
}
```

對的

```
['a', 'b', 'c'].each_with_index  { |item, index|
  puts "#{index}-#{item}"
}
```

或寫成

```
['a', 'b', 'c'].each_with_index do  |item, index|
  puts "#{index}-#{item}"
end
```

於是我們操Pry
```
ezParser/examples/ex5 on master*
$ pry

[1] pry(main)> ['a', 'b', 'c'].each_with_index  { |item, index|
[1] pry(main)*  puts "#{index}-#{item}"
[1] pry(main)* }
0-a
1-b
2-c
=> ["a", "b", "c"]

[2] pry(main)> {"Jane Doe" => 10, "Jim Doe" => 6}.each_with_index do |item, index|
[2] pry(main)*   puts "#{index}-#{item}"
[2] pry(main)* end
0-["Jane Doe", 10]
1-["Jim Doe", 6]
=> {"Jane Doe"=>10, "Jim Doe"=>6}
```

###

fix `examples/ex5/ezprice.rb`

```

```


###### text
>用來取HTML tag裡的文字，跟Nokogiri的`content`一樣的用法，詳情幾見`ex2`的筆記`wiki/Note_ex2.md`

###### strip
>一個去掉**空格、換行字元**的方法，請看[String#strip](https://ruby-doc.org/core-2.2.0/String.html#method-i-strip)，一樣操Pry就很有感了。
