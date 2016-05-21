class HashtagOccurence < ActiveRecord::Base
  belongs_to :message
  belongs_to :hashtag
end
