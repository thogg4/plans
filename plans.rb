require 'sinatra'
require 'active_record'
require 'mysql2'
require 'activerecord-mysql2-adapter'
require 'squeel'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: 'localhost',
  username: 'root',
  database: 'plans'
)

Dir.glob('./models/*.rb').each {|file| require_relative file }



get '/' do
  @plans = Plan.search(params[:s])
  erb :index
end

get '/p/:permalink' do |permalink|
  puts 'params!!!!'
  puts permalink
  @plan = Plan.where(:link => permalink).first
  puts 'plan!!!!'
  puts @plan
  erb :plan
end


