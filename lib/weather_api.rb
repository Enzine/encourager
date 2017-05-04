class WeatherApi

  def self.fetch_weather_in(city)
    url = "http://api.apixu.com/v1/current.json?key=#{key}&q=#{city}"

    response = HTTParty.get "#{url}"
    return nil if response.parsed_response.has_key? "error"
    weather = {}
    weather[:temperature] = response.parsed_response["current"]["temp_c"]
    weather[:feelslike] = response.parsed_response["current"]["feelslike_c"]
    weather[:text] = response.parsed_response["current"]["condition"]["text"]
    weather[:icon] = response.parsed_response["current"]["condition"]["icon"]
    weather[:wind] = response.parsed_response["current"]["wind_kph"]
    weather[:humidity] = response.parsed_response["current"]["humidity"]
    weather
  end

  def self.key
    raise "WEATHERKEY env variable not defined" if ENV['WEATHERKEY'].nil?
    ENV['WEATHERKEY']
  end
end
