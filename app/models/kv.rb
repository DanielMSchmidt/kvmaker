class Kv < ActiveRecord::Base
  attr_accessible :fields, :values, :input
  validates :fields, :values, presence: true
end
