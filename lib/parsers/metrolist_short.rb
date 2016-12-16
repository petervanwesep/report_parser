module Parsers
  class MetrolistShort < Base
    def parse
      purchase_dates = text.scan(/ST: +Sold (\d\d\/\d\d\/\d\d)/).map { |e| Date.strptime(e.first, '%D') }
      purchase_prices = text.scan(/\$(\d\d\d,\d\d\d)/).map { |e| e.first.sub(',','').to_i }
      zips = text.scan(/CA (\d\d\d\d\d)\-\d\d\d\d/).map { |e| e.first }
      listing_prices = text.scan(/Listing Price +\$(\d\d\d,\d\d\d)/).map { |e| e.first.sub(',','').to_i }
      beds = text.scan(/Beds \(Possible\): +(\d)/).map { |e| e.first.to_i }
      baths = text.scan(/Baths \(FH\): +(\d)/).map { |e| e.first.to_i }
      lot_sqft = text.scan(/Lot SqFt \(Apprx\): +(\d+)/).map { |e| e.first.sub(',','').to_i }
      area = text.scan(/Area: +(\d+)/).map { |e| e.first.sub(',','').to_i }
      subtype = text.scan(/Subtype: +([\w \+]+)/).map { |e| e.first }
      reo = text.scan(/REO: +(\w+)/).map { |e| e.first }
      short_sale = text.scan(/Short Sale: +(\w+)/).map { |e| e.first }
      hud = text.scan(/HUD +(\w+)/).map { |e| e.first }
      auction = text.scan(/Auction: +(\w+)/).map { |e| e.first }
      days_on_market = text.scan(/DOM: (\d+)/).map { |e| e.first.to_i }

      purchase_dates.each_with_index do |_, i|
        home = Home.create!(
          zip: zips[i],
          beds: beds[i],
          baths: baths[i],
          lot_sqft: lot_sqft[i],
          area: area[i],
          subtype: subtype[i],
          reo: reo[i],
          short_sale: short_sale[i],
          hud: hud[i],
          auction: auction[i]
        )

        Purchase.create!(
          purchased_at: purchase_dates[i],
          price: purchase_prices[i]
        )

        Listing.create!(
          listed_at: purchase_dates[i] - days_on_market[i].days,
          price: listing_prices[i]
        )
      end
    end

    def self.match?(text)
      text[/Client Summary Report - Residential/].present?
    end
  end
end