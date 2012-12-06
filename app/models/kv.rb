class Kv < ActiveRecord::Base
  attr_accessible :fields, :values
  validates :fields, :values, presence: true
end
