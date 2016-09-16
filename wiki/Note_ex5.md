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

###

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

###### text
>用來取HTML tag裡的文字，跟Nokogiri的`content`一樣的用法，詳情幾見`ex2`的筆記`wiki/Note_ex2.md`

###### strip
>一個去掉**空格、換行字元**的方法，請看[String#strip](https://ruby-doc.org/core-2.2.0/String.html#method-i-strip)，一樣操Pry就很有感了。
