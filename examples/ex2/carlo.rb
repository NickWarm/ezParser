require 'nokogiri'
require 'open-uri'

books = Nokogiri::HTML(open('http://www.books.com.tw/activity/gold66_day/?loc=activity_BK_001'))

puts "### Search for nodes by css with Bookstore"

books.css('div h1 a').each do |a|
  puts a.content
end



# require 'nokogiri'
# require 'open-uri'
#
# books = Nokogiri::HTML(open('http://www.books.com.tw/activity/gold66_day/?loc=activity_BK_001'))
#
# puts "### Search for nodes by css with Bookstore"
#
# books.xpath("//div[@class='sec_1']/a").each do |a|
#   puts a.content
# end

# require 'nokogiri'
# require 'open-uri'
#
# books = Nokogiri::HTML(open('http://www.books.com.tw/activity/gold66_day/?loc=activity_BK_001'))
#
# puts "### Search for nodes by css with Bookstore"
#
# books.xpath("//div[@class='sec_1']/a").each do |a|
#   puts a.text()
# end

# require 'nokogiri'
# require 'open-uri'
#
# books = Nokogiri::HTML(open('http://www.books.com.tw/activity/gold66_day/?loc=activity_BK_001'))
#
# puts "### Search for nodes by css with Bookstore"
#
# books.css(".sec_1 a").each do |a|
#   puts a.content
# end
