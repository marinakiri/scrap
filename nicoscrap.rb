require "nokogiri"
require "open-uri"

=begin
# this method takes too long to compute...
def get_the_price_of_a_currency_from_its_name(url)
  page = Nokogiri::HTML(open(url))
  scrap = page.xpath('//*[@id="quote_price"]')
  scrap.each do |node| return node.text end
end
=end

def get_all_the_currency_names(url)
  h = {}
  page = Nokogiri::HTML(open(url))
  #scrap = page.css('td.currency-name a')
  scrap = page.xpath('//td[2]/a')
  scrap.each do |node|
    currency = node.text
    url = 'https://coinmarketcap.com' + node['href']
    #price = get_the_price_of_a_currency_from_its_name(url)
    #h.store(currency, price)
  end
  puts h
end

get_all_the_currency_names 'https://coinmarketcap.com/all/views/all/'