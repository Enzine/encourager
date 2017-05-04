class QuoteApi

  def self.fetch_quote
    expires_in_seconds = Time.now.end_of_day - Time.now
    Rails.cache.fetch "quote", expires_in: expires_in_seconds do
      response = HTTParty.get "http://www.quotzzy.co/api/quote"
      Quote.new response
    end
  end
end
