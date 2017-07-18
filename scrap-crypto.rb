require 'nokogiri'   
require 'open-uri'

def get_the_price_of_a_currency_from_its_name(url)
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//*[@id="quote_price"]')
	scrap.each do |node| return node.text end
end

def get_all_the_currency_names(url)
	h = {}
	page = Nokogiri::HTML(open(url))
	# scrap = page.css('td.currency-name a')
	scrap = page.xpath('//td[2]/a')
	scrap.each do |node|
		currency = node.text
	#	url = 'https://coinmarketcap.com' + node['href']
		url = 'https://coinmarketcap.com' + node['@href']
		price = get_the_price_of_a_currency_from_its_name(url)
		h.store(currency, price)
	end
	puts h
end

get_all_the_currency_names("https://coinmarketcap.com/all/views/all/")


# //*[@id="id-bitcoin"]/td[2]/a

=begin
def get_all_the_currency_names
page = Nokogiri::HTML(open("https://coinmarketcap.com/"))
scrap = page.css('td img.currency-logo')
scrap.each do |node| puts node["alt"] end
end

=end



=begin
def scrap_crypto(url)
	scrap = Nokogiri::HTML(open(url))
	scrap.css('td a').each { |x| puts x[0][data-usd] } 
end

scrap_crypto("https://coinmarketcap.com/all/views/all/")

# //*[@id="id-bitcoin"]/td[5]/a
# puts links[0]["href"]

=end