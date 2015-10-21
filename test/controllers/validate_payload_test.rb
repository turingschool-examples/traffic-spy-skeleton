require './test/test_helper'
module TrafficSpy
  class ValidatePayloadTest < Minitest::Test
    def test_doesnt_validate_a_payload_for_an_unregistered_user
      post '/sources', {identifier: "jumpstartlab",
                        rootUrl: "http://jumpstartlab.com"
                       }

      post '/sources/whatever/data', 'payload={"url":"http://whatever.com/blog",
                                                   "requestedAt":"2013-02-16 21:38:28 -0700",
                                                   "respondedIn":37,"referredBy":"http://whatever.com",
                                                   "requestType":"GET",
                                                   "parameters":[],
                                                   "eventName": "socialLogin",
                                                   "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                                   "resolutionWidth":"1920",
                                                   "resolutionHeight":"1280",
                                                   "ip":"63.29.38.211"}'

      assert_equal 0, Payload.count
      assert_equal 403, last_response.status
      assert_equal "App Not Registered!", last_response.body
    end

    def test_doesnt_validate_a_payload_with_no_data
      post '/sources', {identifier: "jumpstartlab",
                        rootUrl: "http://jumpstartlab.com"
                       }

      post '/sources/jumpstartlab/data', 'payload={}'

      assert_equal 0, Payload.count
      assert_equal 400, last_response.status
      assert_equal "Payload Missing", last_response.body
    end
  end
end
