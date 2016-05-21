require 'rails_helper'

describe Message do
  let(:message) { Message.create(body: 'sample message body #hashtag')}

  it 'is valid with message under 141 chars' do
    expect(message).to be_valid
  end

  it { should ensure_length_of(:body).is_at_most(141)}

  it { should validate_presence_of(:body) }
end
