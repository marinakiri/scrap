require 'nokogiri'   
require 'open-uri'
require 'bundler'
require 'json'
Bundler.require

def get_the_email_of_a_townhall_from_its_webpage(url)
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//html/body/table/tr[3]/td/table/tr[1]/td[1]/table[4]/tr[2]/td/table/tr[4]/td[2]/p')
	scrap.each do |node| return node.text.slice!(1..-1) end # get the contact mail adress without first character (" ")
end

def get_all_the_urls_of_val_doise_townhalls(url)
	data = [] # create array to store data result
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//table/tr[2]/td/table/tr/td/p/a')
	scrap.each do |node| 
		h = {} # create hash to store city name and contact mail
		city = node.text.split.each do |text| text.capitalize! end # transform city name into array of words, and capitalize every word
		city = city * "-" # transform array back into string with '-' separator between words
		url = 'http://annuaire-des-mairies.com' + node['href'].slice!(1..-1) # rebuild city page whole url from scrapped partial url
		mail = get_the_email_of_a_townhall_from_its_webpage(url) # scrap city page for email adress
		h[:'city'] = city
		h[:'mail'] = mail
		data.push(h) # store hash into array "data"
	end
	return data
end

def save_to_json_file(url)
	data = get_all_the_urls_of_val_doise_townhalls(url)
	File.open("mairie.json","wb") do |f|
	  f.write(data.to_json)
	end
	
end

def export_all_contact_emails_to_spreadsheet(url)
	session = GoogleDrive::Session.from_config("config.json")
	spreadsheet = session.spreadsheet_by_title("scrap-mairies") # Get the spreadsheet by its title
	ws = spreadsheet.worksheets.first # Get the first worksheet
	
	ws.insert_rows(1, [["Ville", "Mail de contact"]]) # create table index
	ws.save

	data = get_all_the_urls_of_val_doise_townhalls(url) # call method that creates a 'data'  array with all the city names and contact emails
	
	data.each do |h| # works on each hash included in our 'data' array
	ws.insert_rows(ws.num_rows + 1, [[h[:'city'], h[:'mail']]]) # copy city name and contact mail into spreadsheet on a new line
	ws.save
	end
end

save_to_json_file("http://annuaire-des-mairies.com/val-d-oise.html")
export_all_contact_emails_to_spreadsheet("http://annuaire-des-mairies.com/val-d-oise.html")



