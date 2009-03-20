require 'rubygems'
require 'sinatra'
require 'active_record'
require 'active_support'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :dbfile =>  'db/development.db'
)

class Task < ActiveRecord::Base
end

post '/' do
  application = ActiveSupport::JSON.decode(params[:application])
  Task.new( :application => application["NSApplicationName"], :timestamp => Time.now ).save
end

get '/' do
  Task.count(:group => :application).inspect
end