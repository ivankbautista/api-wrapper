module CoingeckoApi
    # CoinGecko API Docs: https://www.coingecko.com/en/api/documentation
    module V3
        class Client
        include HttpStatusCodes
        include ApiExceptions
            
        BASE_URL = 'https://api.coingecko.com/api/v3/'.freeze

        #?per_page=10 - 10 results per page
        def get_exchanges
            request(
                http_method: :get,
                endpoint: "exchanges?per_page=10",
            )
        end

        def get_globaldata
            request(
                http_method: :get,
                endpoint: "global",
            )
        end

        def get_indexes
            request(
                http_method: :get,
                endpoint: "indexes",
            )
        end

        def search_trending
            request(
                http_method: :get,
                endpoint: "search/trending"
            )
        end

        def company_btcholdings
            request(
                http_method: :get,
                endpoint: "companies/public_treasury/bitcoin"
            )
        end

        private
        def request(http_method:, endpoint:, params: {})
            @response = connection.public_send(http_method, endpoint, params)
            return JSON.parse(@response.body) if @response.status == HTTP_OK_CODE
        end

        def connection
            @connection ||= Faraday.new(
                url: BASE_URL,
            )
        end

        def error_class
            case @response.status
            when HTTP_NOT_FOUND_CODE
                NotFoundError
            when HTTP_UNAUTHORIZED_CODE
                UnauthorizedError
            else
                ApiError
            end
        end
    end
end
end
        