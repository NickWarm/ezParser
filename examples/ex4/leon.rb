require 'nokogiri'
require 'open-uri'

html = open("http://ezprice.com.tw/").read
doc = Nokogiri::HTML(html)
ans = []

doc.css('p[@class=Midget_pic] a img').each do |img|
  ans << img.attr('src')
end

temp_ans = ans.map do
  |url| url.match(/^http/) ? url : "http://ezprice.com.tw/#{url}"
end

temp_ans.each do |full_url|
  `wget #{full_url}`
end
