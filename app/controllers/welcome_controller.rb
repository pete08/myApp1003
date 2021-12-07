class WelcomeController < ApplicationController
  def index
    redis = Redis.new(host:"redis", port:6379)
    redis.incr "page hitz"

    @page_hits = redis.get "page hitz"
  end
end
