require 'gmail'
username = GMAIL_USERNAME
password = GMAIL_PASSWORD

gmail = Gmail.connect(username, password)

email = gmail.compose do
  to "email@example.com"
  subject "Having fun in Puerto Rico!"
  body "Spent the day on the road..."
end
email.deliver! # or: gmail.deliver(email)


=begin 

gmail.deliver do
  to "email@example.com"
  subject "Having fun in Puerto Rico!"
  text_part do
    body "Text of plaintext message."
  end
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "<p>Text of <em>html</em> message.</p>"
  end
  add_file "/path/to/some_image.jpg"
end

=end

gmail.logout