class User < ActiveRecord::Base
  has_many :tweets
  validates_uniqueness_of :username
  validates_presence_of :username

  def fetch_tweets
    self.tweets
  end  

  def tweets_fresh?
    return false if self.tweets.last.nil?
    (Time.now  - self.tweets.last.updated_at) < 900
  end
end
