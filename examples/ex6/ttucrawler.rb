require 'pry'
require 'nokogiri'
require 'rest-client'
require 'awesome_print'

class TTuCrawler
  def self.go!
    response = get_course_by_class("UB2B")
    doc = Nokogiri::HTML(response)
    list = []
    doc.css(".cistab").first.css("tr").each_with_index do |tr, index|
    binding.pry
    puts "-----tr_#{index}-----"
    tr.css("td").each_with_index do |td, y|
      puts "----td_#{y} -----"
      puts td.text()
    end
    # binding.pry
    puts reg = tr.text().match(/(\w\d{4})([^\w]+)(.+)/)

  end

    # ap doc
  end


  def self.get_course_by_class( school_class )
    response = RestClient.post "http://selquery.ttu.edu.tw/Main/ViewClass.php", {
      SelTh:"99X99",
      SelBd:"A1",
      SelRm: "",
      SelDy:1,
      SelSn:1,
      SelDp:05,
      SelCl: school_class
    }
    return response.body
  end
end

TTuCrawler.go!
