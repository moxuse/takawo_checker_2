require "net/http"
require "uri"

class YahooAPI
  attr_reader :api_id, :query, :response

  def initialize(api_id, query)
    @api_id = api_id
    @query = URI.encode(query)
    @response
  end

  def send
    uri = URI.parse("http://jlp.yahooapis.jp/KeyphraseService/V1/extract?appid=#{api_id}&sentence=#{query}&output=json")
    @response = Net::HTTP.get uri
    return self
  end

  def parse_json
    begin
      JSON.parse(response)      
    rescue => e
      return false
    end
  end

end