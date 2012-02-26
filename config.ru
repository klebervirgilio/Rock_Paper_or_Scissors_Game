require 'rubygems'
require 'sinatra'
 
Sinatra::Application.default_options.merge!(
  :run => false,
  :env => :production
)
 
require 'game'
run Sinatra.application
