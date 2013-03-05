class Tweet < ActiveRecord::Base
  belongs_to :user

  def empty?
    self.length == 0 ? true : false
  end
end


