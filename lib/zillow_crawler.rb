class ZillowCrawler
  include HTTParty

  base_uri 'www.zillow.com/webservice/'

  class << self
    def search(address:, zip:)
      begin
        res = get("/GetDeepSearchResults.htm", query: options.merge(address: address, citystatezip: zip))

        if error?(res)
          puts "Error finding address '#{address}' in zip '#{zip}': #{res["searchresults"]["message"]}"
          return nil
        end

        res["searchresults"]["response"]["results"]["result"]
      rescue
        binding.pry
        raise
      end
    end

    private

    def error?(res)
      res["searchresults"]["message"]["code"] =~ /^50.$/
    end

    def options
      { "zws-id": token }
    end

    def token
      ENV['ZWSID']
    end
  end
end