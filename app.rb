require 'sinatra'
require 'httparty'
require 'json'
require_relative 'models/product.rb'

get '/' do
  @page_title = "Home"
  erb :index
end

get '/team' do
  @page_title = "The Team"
  erb :team
end

## ALL PRODUCTS
get '/products' do
  @products = Product.all
  erb "<!DOCTYPE html>
  <html>
  <head>
  <title>Fomotograph | All Products </title>
  <link rel='stylesheet' type='text/css' href='<%= url('/style.css') %>'>
  <link href='https://fonts.googleapis.com/css?family=Work+Sans:400,500,600' rel='stylesheet' type='text/css'>
  </head>

  <body>

    <div id='container'>

      <div id='header'>
        <a href='/'><img src='/logo-black-text.png' alt='logo image' class='logo'/></a>
        <a href='/team' class='nav'>Team</a>
        <a href='/products' class='nav'>Products</a>
      </div>

      <div id='main'>
        <h1> All Products </h1>
        <div id='wrapper'>

          <% @products.each do |product| %>
          <a href='/products/location/<%= product['location'] %>'>
          <div class='product'>
            <div class='thumb'>
              <img src='<%= product['url'] %>' />
            </div>
            <div class='caption'>
              <%= product['location'] != 'us' ? product['location'].capitalize : product['location'].upcase %>
            </div>
          </div>
          </a>
          <% end %>

        </div>
      </div>

      <div id='footer'>
        © Fomotograph
      </div>

    </div>

  </body>
  </html>"
end

## PAGE DISPLAYING ALL PHOTOS FROM ONE LOCATION
get '/products/location/:location' do
  @products = Product.find_by_location( params[:location] )
  erb "<!DOCTYPE html>
  <html>
  <head>
    <title>Fomotograph | <%= params[:location] != 'us' ? params[:location].capitalize : params[:location].upcase %> </title>
    <link rel='stylesheet' type='text/css' href='<%= url('/style.css') %>'>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:400,500,600' rel='stylesheet' type='text/css'>
  </head>

  <body>

    <div id='container'>

      <div id='header'>
        <a href='/'><img src='/logo-black-text.png' alt='logo image' class='logo'/></a>
        <a href='/team' class='nav'>Team</a>
        <a href='/products' class='nav'>Products</a>
      </div>

      <div id='main'>

        <h1> <%= params[:location] != 'us' ? params[:location].capitalize : params[:location].upcase %> </h1>
        <div id='wrapper'>

        <% @products.each do |product| %>
          <a href='/products/<%= product['id'] %>'>
          <div class='product'>
            <div class='thumb'>
              <img src='<%= product['url'] %>' />
            </div>
            <div class='caption'>
              <%= product['title'] %>
            </div>
          </div>
          </a>
        <% end %>

        </div>
        <a class='small-button' href='/products'> View All Products </a>
      </div>

      <div id='footer'>
        © Fomotograph
      </div>

    </div>

  </body>
  </html>"
end

## PRODUCT BY ID
get '/products/:id' do
  @product = Product.find_by_id( params[:id] )
  erb "<!DOCTYPE html>
  <html>
  <head>
    <title>Fomotograph | <%= @product['title'] %> </title>
    <link rel='stylesheet' type='text/css' href='<%= url('/style.css') %>'>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:400,500,600' rel='stylesheet' type='text/css'>
  </head>

  <body>

    <div id='container'>

      <div id='header'>
        <a href='/'><img src='/logo-black-text.png' alt='logo image' class='logo'/></a>
        <a href='/team' class='nav'>Team</a>
        <a href='/products' class='nav'>Products</a>
      </div>

      <div id='main'>
        <h1><%= @product['title'] %></h1>
        <a class='small-button' href='#'>Fomotograph Me!</a>
        <p class='summary'> <%= @product['summary'] %> </p>
        <p class='summary'>Order your prints today for $<%= @product['price'] %></p>
        <img class='full' src='<%= @product['url'] %>'/>
        <a class='small-button' href='/products/location/<%= @product['location'] %>'>
          View All <%= @product['location'] != 'us' ? @product['location'].capitalize : @product['location'].upcase %> Products </a>
      </div>

      <div id='footer'>
        © Fomotograph
      </div>

    </div>

  </body>
  </html>"
end
