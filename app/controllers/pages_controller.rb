class PagesController < ApplicationController
  require 'net/http'
  require 'json'

  def seconds_to_hm(sec)
    "%02d:%02d" % [sec / 3600, sec / 60 % 60]

  end
  helper_method :seconds_to_hm
  def index

  end

  def result

    # Specify the URL you want to make a GET request to
    puts params[:simbriefID]
    computed_url ='https://www.simbrief.com/api/xml.fetcher.php?userid='+params[:simbriefID]+'&json=1'
    url = URI.parse(computed_url)

    # Create a new Net::HTTP instance
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https') # Enable SSL if the URL uses HTTPS

    # Create a new Net::HTTP::Get request
    request = Net::HTTP::Get.new(url.request_uri)

    # Make the GET request and store the response
    response = http.request(request)

       # Process the response
    if response.code.to_i == 200
      @object_json = JSON.parse(response.body, object_class: OpenStruct)
      if @object_json.status == "Error: No flight plan on file for the specified user"
        puts "ID invalide"
        render error
      else
        puts @object_json.general.icao_airline+@object_json.general.flight_number
      end
    else
      render 'error'
    end
  end
 end
