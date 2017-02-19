namespace :scrape do
  task zillow: :environment do
    Home.all.each do |home|
      zillow_data = ZillowCrawler.search(address: home.address, zip: home.zip)
      home.populate_from_zillow(zillow_data) if zillow_data.present?
    end
  end
end