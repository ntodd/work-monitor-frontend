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
  Task.new( :application => application["NSApplicationName"], :timestamp => Time.now, :user_name => params[:user_name] ).save
  # puts application.inspect
end

get '/:user_name' do
  Task.count(:group => :application, :conditions => ['user_name = ?', params[:user_name]]).inspect
end