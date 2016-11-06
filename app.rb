require 'sinatra'
require 'httparty'
require 'json'
require_relative 'models/product.rb'

helpers do
  def titlecase(title)
    title != 'us' ? title.capitalize : title.upcase
  end
end

get '/' do
  @page_title = "Home"
  erb :index
end

get '/team' do
  @page_title = "The Team"
  erb :team
end

get '/products' do
  @products = Product.sample_locations
  @page_title = "Locations"
  erb :products
end

get '/products/location/:location' do
  @products = Product.find_by_location( params[:location] )
  @page_title = params[:location]
  erb :category
end

get '/products/:id' do
  @product = Product.find_by_id( params[:id] )
  @page_title = @product.location
  erb :single
end
