class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: {minimum: 1, maximum: 280}
  validates :publish_at, presence: true

  after_initialize do
    # this is so my form starts by default 1 day from now
    self.publish_at ||= 24.hours.from_now
  end

  def published?
    tweet_id?
  end

  def publish_to_twitter!
    # client method defined in the model
    tweet = twitter_account.client.update(body)
    update(tweet_id: tweet.id)
  end
end