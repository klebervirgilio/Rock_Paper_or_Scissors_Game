require 'sinatra'

# TODO
# Layout c/ dicuss
# Forma de dois users jogarem ao mesmo tempo
# login via Facebook, Github e Twitter
# Criar um middleware para descobrir a origim do jogar e setar o locale.
# Convidar alguém para jogar


configure do
  set :views, File.dirname(__FILE__) + '/assets/views'
  set :session_secret, 'klebervirgilio.com'
  enable :sessions
end


before do
  @defeat = {rock: :scissors, paper: :rock, scissors: :paper}
  @throws = @defeat.keys
end

before(/\/(throw|me|about)/) do
  content_type :txt
end

before(/\/(console)?/) do
  headers 'Content-Type' => 'text/html;charset=utf-8'
end

get '/' do
  erb :console
end

get '/console' do
  erb :console
end

get '/throw/:type' do
  
  player_throw = params[:type].to_sym
  halt 403, "You must throw one of the following: #{@throws}" unless @throws.include?(player_throw)
  
  computer_throw = @throws.sample
  tied    = "You tied with the computer. Try again!"
  winner  = "Nicely done; #{player_throw} beats #{computer_throw}!"
  loser   = "Ouch; #{computer_throw} beats #{player_throw}. Better luck next time!"
  
  return_ = if player_throw == computer_throw
    tied
  elsif computer_throw == @defeat[player_throw]
    winner
  else
    loser
  end
  
  session[:counter].nil? ? session[:counter] = 1 : session[:counter] = (session[:counter] + 1)
   
  etag return_
  return_
end

get '/reset' do
  session.clear
  redirect '/'
end

# Last counter
get '/load_counter' do
  session[:counter] = request.cookies['counter'].nil?  ? 0 : request.cookies['counter'].to_i
  "Loaded"
end

post '/save_counter' do
  response.set_cookie "last_counter", session[:counter]
  "Saved!"
end

delete '/destroy_counter' do
  response.delete_cookie "last_counter"
end

get %r{\/(about|me)} do
  pass if request.path =~ /\/me/
  "Check out my short bio: http://twitter.com/klebercorreia"
end

get '/me' do
  "It's me!"
end

not_found do
  ":("
end

error do
  ":'("
end