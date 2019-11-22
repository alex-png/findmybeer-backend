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
puts " End of rb file"
wine = with_img.partition{|b| b["style"]["name"].downcase.include?("wine") || b["name"].downcase.include?("wine") }
wine[0].each do |w|

    Beer.create(name: w["name"], description: w["description"], abv: w["abv"].to_i, brewery_id: Brewery.find_by(name:w["breweries"][0]["name"]).id, style_id: Style.find_by(name:w["style"]["name"]).id, img_url: w["labels"]["large"])

end



second = wine[1]
second = second.partition{|b| b["style"]["name"].downcase.include?("saison") || b["name"].downcase.include?("saison") }
second[0].each {|s| s["style"]["name"] = "Saison" }

second[0].each do |s|

    Beer.create(name: s["name"], description: s["description"], abv: s["abv"].to_i, brewery_id: Brewery.find_by(name:s["breweries"][0]["name"]).id, style_id: Style.find_by(name:s["style"]["name"]).id, img_url: s["labels"]["large"])

end
third = second[1]
third = third.partition{|b| b["style"]["name"].downcase.include?("wheat") || b["name"].downcase.include?("wheat") }
third[0].each {|s| s["style"]["name"] = "Wheat" }

third[0].each do |s|

    Beer.create(name: s["name"], description: s["description"], abv: s["abv"].to_i, brewery_id: Brewery.find_by(name:s["breweries"][0]["name"]).id, style_id: Style.find_by(name:s["style"]["name"]).id, img_url: s["labels"]["large"])

end


fourth = third[1]
fourth = fourth.partition{|b| b["style"]["name"].downcase.include?("india") || b["style"]["name"].downcase.include?("indian") ||b["style"]["name"].downcase.include?("ipa") || b["name"].downcase.include?("ipa") }
fourth[0].each {|f| f["style"]["name"] = "IPA" }

fourth[0].each do |s|

    Beer.create(name: s["name"], description: s["description"], abv: s["abv"].to_i, brewery_id: Brewery.find_by(name:s["breweries"][0]["name"]).id, style_id: Style.find_by(name:s["style"]["name"]).id, img_url: s["labels"]["large"])

end



fifth = fourth[1]
fifth = fifth.partition{|b| b["style"]["name"].downcase.include?("stout") || b["style"]["name"].downcase.include?("porter") || b["name"].downcase.include?("coffee") || b["name"].downcase.include?("chocolate") }
fifth[0].each {|f| f["style"]["name"] = "Stout" }

fifth[0].each do |s|

    Beer.create(name: s["name"], description: s["description"], abv: s["abv"].to_i, brewery_id: Brewery.find_by(name:s["breweries"][0]["name"]).id, style_id: Style.find_by(name:s["style"]["name"]).id, img_url: s["labels"]["large"])

end

sixth = fifth[1]

sixth = sixth.partition{|b| b["style"]["name"].downcase.include?("pilsener") ||  b["name"].downcase.include?("pilsener")  }

sixth[0].each {|f| f["style"]["name"] = "Pilsener" }

sixth[0].each do |s|

    Beer.create(name: s["name"], description: s["description"], abv: s["abv"].to_i, brewery_id: Brewery.find_by(name:s["breweries"][0]["name"]).id, style_id: Style.find_by(name:s["style"]["name"]).id, img_url: s["labels"]["large"])

end

seventh = sixth[1]

seventh = seventh.partition{|b| b["style"]["name"].downcase.include?("lager") ||  b["name"].downcase.include?("lager")  }

seventh[0].each {|f| f["style"]["name"] = "Lager" }

seventh[0].each do |s|

    Beer.create(name: s["name"], description: s["description"], abv: s["abv"].to_i, brewery_id: Brewery.find_by(name:s["breweries"][0]["name"]).id, style_id: Style.find_by(name:s["style"]["name"]).id, img_url: s["labels"]["large"])

end

eigth = seventh[1]

eigth = eigth.partition{|b| b["style"]["name"].downcase.include?("ale") ||  b["name"].downcase.include?("ale")  }

eigth[0].each {|f| f["style"]["name"] = "Ale" }

eigth[0].each do |s|

    Beer.create(name: s["name"], description: s["description"], abv: s["abv"].to_i, brewery_id: Brewery.find_by(name:s["breweries"][0]["name"]).id, style_id: Style.find_by(name:s["style"]["name"]).id, img_url: s["labels"]["large"])

end


#OTHERS == eigth[1]




binding.pry

styles = ["IPA", "Stout", "Pilsener", "Lager", "Ale", "Other"]


