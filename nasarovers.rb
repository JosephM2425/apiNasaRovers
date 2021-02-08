#url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"
#TOKEN = "b0mZGNk49RQdL2RULbRzvj43QWK6n9HdKcWd4KW4"
require "uri"
require "net/http"
require "json"

def request(url, token)

    url = URI("#{url}?sol=1000&api_key=#{token}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    return JSON.parse(response.read_body)
end

def build_web_page(photos)
    File.open("examen.html", "w") do |file|
        file.puts "<html>"
        file.puts "<head>"
        file.puts "</head>"
        file.puts "<body>"
        file.puts "<ul>"
        photos["photos"].each do |photo|
            file.puts "<li><img src='#{photo["img_src"]}' width='700px'></li>"
        end
        file.puts "</ul>"
        file.puts "</body>"
        file.puts "</html>"
    end
end

def photos_count(photos)
    newHASH = Hash.new(0)

    photos["photos"].each do |hash|
        newHASH[hash["camera"]["name"]] += 1
    end

    newHASH.each do |key, value|
        puts "#{key} cantidad de fotos: #{value}"
    end
end


nasa = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos", "b0mZGNk49RQdL2RULbRzvj43QWK6n9HdKcWd4KW4")
build_web_page(nasa)
photos_count(nasa)