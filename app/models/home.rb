class Home < ActiveRecord::Base
  has_many :purchases
  has_many :listings

  def populate_from_zillow(args)
    street_address = args["address"]["street"]
    zip = args["address"]["zipcode"]

    update_attributes(
      address: street_address,
      zip: zip,
      city: args["address"]["city"],
      state: args["address"]["state"]
    )

    last_sold_date = Date.strptime(args["lastSoldDate"], '%D')
    last_sold_price = Integer(args["lastSoldPrice"]["__content__"])

    if listings.where(listed_at: last_sold_date).empty?
      listings.create!(listed_at: last_sold_date, price: last_sold_price)
    end

    save!
  end
end