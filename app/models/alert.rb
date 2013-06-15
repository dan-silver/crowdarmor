class Alert < ActiveRecord::Base
  belongs_to :user
  attr_accessible :action_type, :data, :threshold
end
