require 'httparty'
require 'json'

class Product
  attr_reader :id, :title, :location, :summary, :url, :price

  LOCATIONS = ['canada', 'england', 'france', 'ireland', 'mexico', 'scotland', 'taiwan', 'us']
  url = 'https://fomotograph-api.udacity.com/products.json'
  DATA = HTTParty.get(url)['photos']

  def initialize(product_data = {})
    @id = product_data['id']
    @title = product_data['title']
    @location = product_data['location']
    @summary = product_data['summary']
    @url = product_data['url']
    @price = product_data['price']
  end

  def self.all
    DATA.map { |product| new(product) }
  end

  def self.sample_locations
    @products = []
    LOCATIONS.each do |location|
      @products.push self.all.select { |product| product.location == location }.sample
    end
    return @products
  end

  def self.find_by_location(location)
    self.all.select { |product| product.location == location }
  end

  def self.find_by_id(id)
    self.all.select { |product| product.id == id.to_i }.first
  end

  def self.find_deals
    self.all.select { |product| product.price < 10 }
  end

end