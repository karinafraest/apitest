require 'twitter_oauth'
before "/*" do
 @client = TwitterOAuth::Client.new(
    :consumer_key => ENV["CONSUMER_KEY"],
    :consumer_secret => ENV["CONSUMER_SECRET"])
end

get '/' do
  erb :index2
end

get '/login' do
  request_token = @client.request_token(:oauth_callback => "#{ENV['CURRENT_PATH']}/auth")
  session[:request_token] = request_token.token
  session[:request_token_secret] = request_token.secret
  redirect request_token.authorize_url
end


get '/auth' do
  @access_token = @client.authorize(
    session[:request_token],
    session[:request_token_secret],
    :oauth_verifier => params[:oauth_verifier]
  )

  if @client.authorized?
    logged_in=true
    session[:access_token] = @access_token.token
    session[:secret_token] = @access_token.secret
    session[:user] = true
    redirect '/random'
  else
    redirect '/'
  end

end

get '/logout' do
  session = {}
  redirect '/'
end
