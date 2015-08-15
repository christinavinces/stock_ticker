require 'sinatra'

puts "What stock?"
ticker = gets.chomp.downcase

require 'httparty'
response = HTTParty.get('http://finance.yahoo.com/q?s='+ticker)

require 'nokogiri'
dom = Nokogiri::HTML(response.body)
my_span = dom.xpath("//span[@id='yfs_l84_"+ ticker +"']").first
prev_close = dom.xpath("//td[@class='yfnc_tabledata1']").first

get '/' do
	["Stock: #{ticker.upcase}", "Current Price: $#{my_span.content}", "Previous Close: $#{prev_close.content}"].join("<br>")
end