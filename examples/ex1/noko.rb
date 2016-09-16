# require 'nokogiri'
# require 'open-uri'
#
# htmlData = "
# <html>
# 	<title id= 'title'> This is a simple html </title>
# 	<body id='story_body'>
# 		<h2> this is h2 in story_body </h2>
# 	</body>
# 	<h1> test h1-1 </h1>
# 	<h1> test h1-2 </h1>
# 	<h3>
# 		<img src = 'goodPic-1.jpg' >
# 		<a href = 'www.google.com'> google web site </a>
# 		<img src = 'goodPic-2.jpg' >
# 		<a href = 'www.yahoo.com'> yahoo web site </a>
# 	</h3>
# 	<div class= 'div_1'>
# 		<h2> this is h1 in div_1 </h2>
# 	</div>
# </html>
# "
# doc = Nokogiri::HTML( htmlData )
#
# puts doc.xpath("//div[@class='div_1']")

require 'nokogiri'
require 'open-uri'

htmlData = "
<html>
	<title id= 'title'> This is a simple html </title>
	<body id='story_body'>
		<h2> this is h2 in story_body </h2>
	</body>
	<h1 class='first h1'> test h1-1 </h1>
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

puts doc.css("h1").first
