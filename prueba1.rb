require 'uri'
require 'net/http'
require 'openssl'
require 'json'

def get_data(endpoint)

    url = URI(endpoint)
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(request)

    return JSON.parse(response.read_body)
    get_data("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=bTsg6AhHD0oLqNhZurmkdv1S84UDpSDloeeWkwpk")
end 




def build_web_page(get_data)
    photos = get_data.map{|x| x['img_src']}

    pagina = "<html>\n
    <head>\n
    </head>\n
    <body>\n
    <ul>\n"
    photos.each do |photo| 
         pagina += "<li><img src=\"#{photo}\"> </li>\n"
    end 
            
    pagina +="</ul>\n
    </body>\n
    </html>\n"

 

    File.write('index1.html', pagina)
end 
 

build_web_page(get_data("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=bTsg6AhHD0oLqNhZurmkdv1S84UDpSDloeeWkwpk")['photos'])


