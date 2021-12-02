module CoingeckoAPI
    # CoinGecko API Docs: https://www.coingecko.com/en/api/documentation
    module V3
        class Client
        include HttpStatusCodes
        include ApiExceptions
            
        BASE_URL = 'https://api.coingecko.com/api/v3/'.freeze

        def get_exchanges
            request(
                http_method: :get,
                endpoint: "exchanges",
            )
        end

        def get_platforms
            request(
                http_method: :get,
                endpoint: "finance_platforms?per_page=5"
            )
        end

        def get_indexes
            request(
                http_method: :get,
                endpoint: "indexes?per_page=5"
            )
        end

        def search_trending
            request(
                http_method: :get,
                endpoint: "search/trending"
            )
        end

        def btc_holdings
            request(
                http_method: :get,
                endpoint: "companies/public_treasury/bitcoin"
            )
        end

        private
        def request(http_method:, endpoint:, params: {})
            @response = connection.public_send(http_method, endpoint, params)
            JSON.parse(@response.body)
        end

        def connection
            @connection ||= Faraday.new(
                url: BASE_URL,
            )
        end
    end