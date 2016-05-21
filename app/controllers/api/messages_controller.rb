module Api
  class MessagesController < ApiController
    def create
      message = Message.create(
        body: params['body']
      )

      if message.save
        # parse hashtags with regex
        hashtags = get_hashtags(message.body)

        # count hashtags to a hash (tag:count)
        hashtag_count = count_hashtags(hashtags)

        # create hashtag occurences for has_many :through association
        create_hashtag_occurences(message, hashtag_count)

        render json: message.id
      else
        render json: message.errors.full_messages, :status => 400
      end
    end

    private

    def get_hashtags(string)
      string.scan(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/).flatten
    end

    def count_hashtags(array)
      count = Hash.new(0)
      array.each do |hashtag|
        if count[hashtag] != 0
          count[hashtag] += 1
        else
          count[hashtag] = 1
        end
      end
      count
    end

    def create_hashtag_occurences(message, hashtag_count)
      hashtag_count.each do |tag,count|
        current_hashtag = Hashtag.find_or_create_by(body: tag)
        hashtag_occurence = HashtagOccurence.create(quantity: count)
        hashtag_occurence.message = message
        hashtag_occurence.hashtag = current_hashtag
        hashtag_occurence.save
      end
    end
  end
end
