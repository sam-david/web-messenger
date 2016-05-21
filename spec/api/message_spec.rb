require 'rails_helper'

describe Api::MessagesController do
  let (:valid_message) {
    params = {
      body: 'This is a sample message #hashtag #secondhashtag #hashtag #thirdtag'
    }

    post '/api/messages', params
    expect(response.code).to eq('200')
    Message.find(response.body)
  }

  it 'should parse correct amount of hashtags from message body' do
    expect(valid_message.hashtags.length).to eq(3)
  end

  it 'should track occurences of hashtags in message body' do
    top_hashtag_occurence = valid_message.hashtag_occurences.order(quantity: :desc).first
    expect(top_hashtag_occurence.hashtag.body).to eq('hashtag')
    expect(top_hashtag_occurence.quantity).to eq(2)
  end

  it 'is invalid with message body length > 141 characters' do
    params = {
        body: 'This is a sample message This is a sample message This is a sample message This is a sample message This is a sample message This is a sample message #hashtag #secondhashtag #hashtag #thirdtag'
      }

    post '/api/messages', params

    expect(response.body).to include('Body is too long (maximum is 141 characters)')
    expect(response.code).to eq('400')
  end
end
