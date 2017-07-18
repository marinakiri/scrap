require 'gmail'
require 'dotenv/load'

username = ENV["GMAIL_ADDRESS"]
password = ENV["GMAIL_PASSWORD"]

gmail = Gmail.connect(username, password)

email = gmail.compose do
  to "achille.xavier@yahoo.com"
  subject "Having fun in Los Angeles!"
  body "Spent the day on the road..."
end
email.deliver! # or: gmail.deliver(email)

gmail.logout