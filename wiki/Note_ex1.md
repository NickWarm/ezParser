## 資源

臨摹：[[Nokogiri 教學、簡介 | 艾瑞克王](http://wwssllabcd.github.io/blog/2012/10/25/how-to-use-nokogiri/)

路徑： `ezparser/examples/ex1`


### Step.1

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

出處：
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
