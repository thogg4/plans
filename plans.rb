require 'rubygems'
require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection({
  adapter: 'postgresql',
  host: ENV['DATABASE_URL'],
  database: 'plans'
})

Dir.glob('./models/*.rb').each {|file| require_relative file }

get '/' do
  @plans = Plan.search(params[:s])
  erb :index
end

get '/p/:permalink' do |permalink|
  @plan = Plan.where(:link => permalink).first
  erb :plan
end
