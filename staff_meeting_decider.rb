require 'httparty'
require 'nokogiri'
require 'sinatra'

get '/' do
  org_page = HTTParty.get("http://www.codeforamerica.org/about/team/")
  parsed_page = Nokogiri::HTML(org_page)
  staff_picture_urls = parsed_page.css(".profile-photo").map do |e|
    "http://www.codeforamerica.org/" + e.attribute("src").value[6..-1]
  end
  @facilitator_image_path = staff_picture_urls.sample
  @note_taker_image_path = staff_picture_urls.reject { |path| path == @facilitator_image_path }.sample
  erb :index
end
