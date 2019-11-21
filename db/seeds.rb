# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


beers = [] 

def populate_beers(arr)
    23.times do |n|
    
    url = "https://sandbox-api.brewerydb.com/v2/beers/?withBreweries=y&key=b3510c02858f3794bb10a7fc12466882&p=#{n+=1}"
    encoded_url = URI.encode(url)
    response = RestClient.get(encoded_url)
    JSON.parse(response)["data"].each { |b| arr << b}
    end
end
puts "fetching data..."

populate_beers(beers)
puts "fetched!"
beers = beers.select{|b| b.key?("style")}.select{|b| b.key?("description")}
brews = beers.map{|b| b["breweries"][0]}.uniq
no_img = beers.select{|b| !b.key?("labels") }
with_img = beers.select{|b| b.key?("labels") }
binding.pry

 



puts " End of rb file"
binding.pry
binding.pry



style = Style.find_by(name: b["style"]["name"]).id
brew = Brewery.find_by(name: b["breweries"][0]["name"]).id