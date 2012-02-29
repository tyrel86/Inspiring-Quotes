require 'rss/1.0'
require 'rss/2.0'
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
  source = "http://www.quotedb.com/quote/quote.php?action=random_quote_rss&=&=&" # url or local file
  content = "" # raw content of rss feed will be loaded here
  open(source) do |s| content = s.read end
  rss = RSS::Parser.parse(content, false)

  #Extract Data fromat and output...Any questions
  quote = wrap_text(rss.channel.item.description, 50)
  author = wrap_text("\n\t\t-#{rss.channel.item.title}", 50)

  #Print the lines
  puts quote
  puts author
else
  puts "No network connection aborting ruby quote"
end
