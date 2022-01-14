class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    # Do something later
    # if I changed the time from 3pm to 9am this checks if it was published before
    # so the previous job at 3pm will do nothing
    return if tweet.published?

    # if i changed it from 9am to 3pm this will check that is not time to published it yet
    # and do nothing
    return if tweet.publish_at > Time.current

    # if the tweet hasn't been published and the scheduled time passed try to published it
    tweet.publish_to_twitter!
  end
end
