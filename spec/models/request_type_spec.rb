require './spec/spec_helper'
require './app/models/request_type'

RSpec.describe RequestType, type: :model do

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  let(:single_request_type) { RequestType.new("verb" =>"GET")}

  def make_request_types_and_payload_requests
    ["GET", "PUT"].each do |verb|
      RequestType.create("verb" => verb)
    end

    [1,2,1].each do |request_type_id|
      PayloadRequest.create(
        "url_id"                =>  1,
        "requested_at"          =>  "2013-02-16 21:38:28 -0700",
        "responded_in"          =>  35,
        "source_id"             =>  2,
        "request_type_id"       =>  request_type_id,
        "u_agent_id"            =>  5,
        "screen_resolution_id"  =>  4,
        "ip_id"                 =>  6)
    end
  end

  it "takes a request_type and returns a request_type object" do
    expect(single_request_type).to be_an_instance_of RequestType
  end

  it "has a request_type verb" do
    expect(single_request_type.verb).to eq("GET")
  end

  it "will not create a request_type without a request_type" do
    expect(RequestType.new("verb" => "")).to be_invalid
  end

  it "will not allow duplicate verbes" do
    RequestType.create("verb" =>"GET")
    expect(RequestType.new("verb" => "GET")).to be_invalid
  end

  it "knows the most frequent request type" do
    make_request_types_and_payload_requests
    expect(RequestType.most_frequent_request_type).to eq("GET")
  end

  it "lists all HTTP verbs used" do
    make_request_types_and_payload_requests
    expect(RequestType.list_verbs).to eq(["GET", "PUT"])
  end

  it "groups by request type" do
    make_request_types_and_payload_requests
    expect(RequestType.group_by_request_type).to eq({1=>2, 2=>1})
  end

end
