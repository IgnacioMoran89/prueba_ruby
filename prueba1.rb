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

end 


def build_web_page(request)
    photos = data.map{|x| x['img_src']}

    pagina = "<html>\n
    <head>\n
    </head>\n
    <body>\n
    <ul>\n"
    photos.each do |photo| #itera para acceder a valores del primer hash
         pagina += "<li><img src=\"#{photo}\"> </li>\n"
    end 
            
    pagina +="</ul>\n
    </body>\n
    </html>\n"

    File.write('index.html', pagina)
end 

get_data("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY")