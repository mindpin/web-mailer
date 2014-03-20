require "bundler"
Bundler.setup(:default)
require "sinatra"
require "sinatra/reloader"
require 'sinatra/assetpack'
require "pry"
require "sinatra"
require 'haml'
require 'sass'
require 'coffee_script'
require 'yui/compressor'
require 'sinatra/json'
require 'mongoid'

Mongoid.load!("./config/mongoid.yml")

require 'action_mailer'
require 'haml/template'
# require 'haml/template/plugin'
ActionMailer::Base.view_paths = File.expand_path('../../templates',__FILE__)
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  # :address              => address,
  # :user_name            => user_name,
  # :password             => password,
  :port                 => 25,
  :authentication       => 'plain',
  :enable_starttls_auto => true
}


require File.expand_path("../../lib/mailer",__FILE__)