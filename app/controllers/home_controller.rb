class HomeController < ApplicationController

  def index
    client = CoingeckoApi::V3::Client.new
    @exchanges = client.get_exchanges
    @globaldata = client.get_globaldata
    @trending = client.search_trending
    @companybtc = client.company_btcholdings
  end
end
