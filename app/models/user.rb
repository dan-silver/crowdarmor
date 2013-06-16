require 'json'

class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :Twitter_Handle
  validates_presence_of :name
  has_many :tweets
  has_many :alerts

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.Twitter_Handle = auth['info']['nickname'] || ""
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

end
