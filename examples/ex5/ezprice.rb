require 'nokogiri'
require 'rest-client'
require 'pry'
require 'nokogiri'
require 'awesome_print'

class SimpleGetCrawler
  def self.go!
    response = RestClient.get("http://ezprice.com.tw/s/%E5%A4%A7%E5%90%8C%E9%9B%BB%E9%8D%8B/price/")
    doc = Nokogiri::HTML(response.body)
    list = []
    doc.css(".pd-list li").each_with_index do |pd, index|
      hash = {}
      hash[:title] = pd.css(".srch_pdname").text().strip
      hash[:price] = pd.css(".srch_c_r [itemprop='price']").first["content"]

      list << hash if hash[:title] != ""
    end
    ap list
  end
end

SimpleGetCrawler.go!

# if pd.css(".srch_c_r [itemprop='price']").first
