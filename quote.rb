require 'nokogiri'
require 'open-uri'
require 'resolv-replace'

#Defines Function for word wraping
def wrap_text(txt, col = 80)
  txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/, "\\1\\3\n") 
end

def ping( ping_count = 1, server = "www.google.com" )
  comand = "ping -q -c #{ping_count} #{server} >> /dev/null"
  system comand
end

def wan?
  ping
end

if wan?
  #Obtain rss feed of randome quote
  source = "http://www.quotesdaddy.com/feed" # url or local file
	doc = Nokogiri::HTML(open(source))
	quote_data = doc.css('description').children.first.content
	quote_data = quote_data.split("-")
	author = " - " + quote_data.last
	quote_data.pop # Remove author
	quote = quote_data.join("")

  #Print the lines
	puts
  puts wrap_text( quote, 50 )
  puts wrap_text( author, 50 )
	puts
else
  puts "No network connection aborting ruby quote"
end
