require 'rubygems'
require 'bundler'
Bundler.require

config = ENV['RACK_ENV'] == 'production' ? ENV['DATABASE_URL'] : {adapter: 'postgresql', host: 'localhost', database: 'plans'}
ActiveRecord::Base.establish_connection(config)

Dir.glob('./models/*.rb').each {|file| require_relative file }

get '/' do
  @plans = Plan.search(params[:s])
  erb :index
end

get '/p/:permalink' do |permalink|
  @plan = Plan.where(:link => permalink).first
  erb :plan
end
