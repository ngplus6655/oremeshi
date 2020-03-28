class CreateNotification
  include HTTParty

  API_URI = 'https://onesignal.com/api/v1/notifications'.freeze

  def self.call(*args)
    new(*args).call
  end

  def initialize(contents:, type:)
    @contents = contents
    @type     = type
  end

  def call
    HTTParty.post(API_URI, headers: headers, body: body)
  end

  private

  attr_reader :contents, :type

  def headers
    {
      'Authorization' => 'NGJhZDU1Y2YtYjkzNS00YTZiLWJmMjQtYmNjMzJkOWY3MmVh',
      'Content-Type'  => 'application/json'
    }
  end

  def body
    {
      'app_id' => 'oremeshi',
      'url'    => 'localhost:3000',
      'data'   => { 'type': type },
      'included_segments' => ['All'],
      'contents' => contents
    }.to_json
  end
end