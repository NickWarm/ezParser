## 資源

臨摹：[[Nokogiri 教學、簡介 | 艾瑞克王](http://wwssllabcd.github.io/blog/2012/10/25/how-to-use-nokogiri/)

路徑： `ezparser/examples/ex1`


### 使用Nokogiri

create `example/ex1/noko.rb`

```
gem install nokogiri
require 'nokogiri'
require 'open-uri'
```
在irb下指令`gem --help`，查看可以用哪些指令

透過`gem list`看看是否安裝

也不過就算你已經裝了再下一次`gem install nokogiri`，其實也沒差

`open-uri`是ruby的一個module，直接require即可
  + [Unable to bundle install 'open-uri'](http://stackoverflow.com/questions/20544662/unable-to-bundle-install-open-uri) )
  + [我抓網頁資料的方法(使用 Ruby)](http://blog.ericsk.org/archives/732)  

### 範例1：取回目標的Document

開始爬網紙前，先實作最簡單的。

##### 爬自定義好的HTML結構，全部印出

add to `example/ex1/noko.rb`

完整的code
```
require 'nokogiri'
require 'open-uri'

htmlData = "
<html>
	<title> This is a simple html </title>
	<body id='story_body'>
		<h2> this is h2 in story_body </h2>
	</body>
	<h1> test h1-1 </h1>
	<h1> test h1-2 </h1>
	<h3>
		<img src = 'goodPic-1.jpg' >
		<a href = 'www.google.com'> google web site </a>
		<img src = 'goodPic-2.jpg' >
		<a href = 'www.yahoo.com'> yahoo web site </a>
	</h3>
	<div class= 'div_1'>
		<h2> this is h1 in div_1 </h2>
	</div>
</html>
"
doc = Nokogiri::HTML( htmlData )

print doc
```

然後我們去irb下指令，就能看到剛剛自定義的HTML結構了。
```
ezparser/examples/ex1

ruby noko.rb
```

##### 找出所有 < h1 > 標籤的值

fix `example/ex1/noko.rb`
```
...
...
...

doc = Nokogiri::HTML( htmlData )

puts  doc.xpath("//h1")   
```

一樣irb下指令，就能看到兩行`h1` tag
```
ezparser/examples/ex1

ruby noko.rb
```

其中 `//` 線代表"全部"的意思，使用 `//` 回傳的是一個**集合體**，所以可以用陣列的方式取值

fix `example/ex1/noko.rb`
```
...
...
...

doc = Nokogiri::HTML( htmlData )

print  doc.xpath("//h1")[1]   
```

然後irb下指令，應該就能看到`<h1> test h1-2 </h1>`。

##### 取出所有 < H3 > 標籤下面的 < img >

fix `example/ex1/noko.rb`，然後irb下指令
```
...
...
...

doc = Nokogiri::HTML( htmlData )

puts  doc.xpath("//h3/img")
```


##### 取出所有 < H3 > 標籤下面 < a > 的文字

fix `example/ex1/noko.rb`，然後irb下指令
```
...
...
...

doc = Nokogiri::HTML( htmlData )

puts  doc.xpath("//h3/a").text
```


##### 指定 item [1] 的 text

fix `example/ex1/noko.rb`，然後irb下指令
```
puts  doc.xpath("//h3/a")[1].text
```
##### to_html

老實說我不知這有什麼差別

fix `example/ex1/noko.rb`

from

```
puts  doc.xpath("//h3/a")[1]
```

to

```
puts  doc.xpath("//h3/a")[1]to_html
```

但是跑出來的結果一樣

無聊測試了一下這篇的寫法
```
p  doc.xpath("//h3/a")[1].to_html
```

會印出
```
"<a href=\"www.yahoo.com\"> yahoo web site </a>"
```
跟以往相比，多了`" "`

若是寫
```
p  doc.xpath("//h3/a")[1]
```

則會印出
```
#<Nokogiri::XML::Element:0x3fe884a43e98 name="a"
attributes=[#<Nokogiri::XML::Attr:0x3fe884a43e0c name="href" value="www.yahoo.com">]
children=[#<Nokogiri::XML::Text:0x3fe884a43984 " yahoo web site ">]>
```

看來用`p`可以得到非常完整的資訊，估狗一下原來在Ruby用`p`會得到完整的資訊
  + [p vs puts in Ruby](http://stackoverflow.com/questions/1255324/p-vs-puts-in-ruby)

##### 取出 Tag 的屬性

fix `example/ex1/noko.rb`
```
p doc.xpath("//h3/img")[1]['src']
p doc.xpath("//h3/a")[0]['href']
```

##### 使用`//`來找出某種特定屬性

fix `example/ex1/noko.rb`
```
p doc.xpath("//@class")
puts doc.xpath("//@src")
```

fix `example/ex1/noko.rb`
```
require 'nokogiri'
require 'open-uri'

htmlData = "
<html>
	<title id= 'title'> This is a simple html </title>
	<body id='story_body'>
  ...
  ...
  ...
</html>

puts doc.xpath("//@id")
```

這個寫法是找整個HTML結構，有該屬性的就印出來，用`p`寫會印出很完整的資訊，想看少一點就用`print`或`puts`

##### 找出特定 id or class 的 tag

div 標籤通常會有 id 或 class 屬性，我們可以取出**擁有特定屬性的tag**

ex： 取出擁有`class="div_1"`的`div`

fix `example/ex1/noko.rb`
```
puts doc.xpath("//div[@class='div_1']")

p doc.xpath("//div[@class='div_1']")

puts doc.xpath("//body[@id='story_body']")
```

實際測試後，我較偏好用`puts`而非`p`，`p`的資訊太完整了，閱讀較困難
