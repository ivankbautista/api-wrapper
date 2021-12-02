class HomeController < ApplicationController

  def main
    client = CoingeckoAPI::V3::Client.new
    @exchanges = client.get_exchanges
  end
end
