class PagesController < ApplicationController
  require 'net/http'
  require 'json'

  def seconds_to_hm(sec)
    "%02d:%02d" % [sec / 3600, sec / 60 % 60]

  end
  helper_method :seconds_to_hm
  def get_flightplan
    # Specify the URL you want to make a GET request to
    url = URI.parse('https://www.simbrief.com/api/xml.fetcher.php?username=776979&json=1')

    # Create a new Net::HTTP instance
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https') # Enable SSL if the URL uses HTTPS

    # Create a new Net::HTTP::Get request
    request = Net::HTTP::Get.new(url.request_uri)

    # Make the GET request and store the response
    response = http.request(request)

    # Process the response
    if response.code.to_i == 200
      puts "Success!"
      puts "Response body: #{response.body}"
    else
      puts "Request failed. Response code: #{response.code}"
    end
  end

  def index

  end

  def result

    # Specify the URL you want to make a GET request to
    @computed_url ='https://www.simbrief.com/api/xml.fetcher.php?userid='+params[:query]+'&json=1'

    url = URI.parse(@computed_url)

    # Create a new Net::HTTP instance
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https') # Enable SSL if the URL uses HTTPS

    # Create a new Net::HTTP::Get request
    request = Net::HTTP::Get.new(url.request_uri)

    # Make the GET request and store the response
    response = http.request(request)

    # Process the response
    if response.code.to_i == 200
      simbrief_response ="ok"

      @object_json = JSON.parse(response.body, object_class: OpenStruct)



    else
      simbrief_response = "nok"
    end
  end

end
