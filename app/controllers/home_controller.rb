require 'quote_api'

class HomeController < ApplicationController

  def home
    @todays_quote = QuoteApi.fetch_quote
  end
end
