cd girequire 'nokogiri'   
require 'open-uri'

url = "https://en.wikipedia.org/wiki/HTML"

def scrapping_css(url)
  page = Nokogiri::HTML(open(url))
  scrap = page.css('li a')
  scrap.each do |node| puts node.text end
end

def scrapping_xpath(url)
  page = Nokogiri::HTML(open(url))
  scrap = page.xpath('//div[1]/table[1]/tr/th')
  scrap.each do |node| puts node.text end
end
