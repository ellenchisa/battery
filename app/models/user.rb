class User < ActiveRecord::Base
    has_many :batteries
    has_one :battery, order: 'created_at DESC'
    validates_presence_of :facebookid, :name, :phone, :notification_hour
end
