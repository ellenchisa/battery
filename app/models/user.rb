class User < ActiveRecord::Base
    has_many :batteries
    has_one :battery, order: 'created_at DESC'
end
