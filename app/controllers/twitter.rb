require 'twitter' #cant put this in env

get "/random" do
  response = Unirest.post "https://andruxnet-random-famous-quotes.p.mashape.com/?cat=movies&count=1",
  headers:{
    "X-Mashape-Key" => "KD90PxVMaJmshre4tJKZg0Ria1y4p1eyd0zjsn9FlOkqgOl9Ti",
    "Content-Type" => "application/x-www-form-urlencoded",
    "Accept" => "application/json"
  }
  quote = response.body
  @full = {quote: quote["quote"], author: quote["author"]}
 erb :index
end

post '/tweet' do
  actual =params[:quote]
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["CONSUMER_KEY"]
    config.consumer_secret     = ENV["CONSUMER_SECRET"]
    config.access_token        = session[:access_token]
    config.access_token_secret = session[:secret_token]
  end

  client.update(actual)
  redirect "/random"
end

get '/getTweets' do
  user = client.user(params[:username])
  p user
  redirect "/"
end




