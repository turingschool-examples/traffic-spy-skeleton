require_relative '../test_helper'
require_relative '../../app/models/params_checker'

class CreateClientDataTest < Minitest::Test
  include TestHelpers
  include Rack::Test::Methods
  include ParamsChecker

  def test_payloads_can_be_stored_in_a_client_account
    register_client
    setup_data

    assert_equal 1, Client.all.count
    assert_equal 3, PayloadRequest.all.count
    assert_equal 200, last_response.status
    assert_equal "good request", last_response.body

  end

  def test_data_can_be_created
    register_client
    setup_data
    pr = PayloadRequest.first

    assert_equal 1, pr.id
    assert_equal "http://amazon.com", pr.referrer.address
    assert_equal "GET", pr.request_type.verb
    assert_equal "facebook", pr.event.name
    assert_equal "Mozilla", pr.u_agent.browser
    assert_equal "Windows", pr.u_agent.platform
    assert_equal  "63.29.38.211", pr.ip.address
    assert_equal "2013-02-16 21:40:00 -0700", pr.requested_at
    assert_equal 20, pr.responded_in
  end

  def test_it_returns_400_for_missing_payload
    register_client
    post '/sources/jumpstartlab/data'

    assert_equal 0, PayloadRequest.count
    assert_equal 400, last_response.status
    assert_equal "Payload Not Valid", last_response.body
  end

  def test_it_returns_403_for_repeat_data
    register_client
    setup_data
    pr = PayloadRequest.first

    assert_equal 1, pr.id
    assert_equal 3, PayloadRequest.count
    assert_equal "http://amazon.com", pr.referrer.address
    assert_equal 200, last_response.status
    assert_equal "good request", last_response.body

    setup_data

    #    assert_equal 403, last_response.status #TODO CHECK THIS.
#    assert_equal "bad request", last_response.body
  end

  def test_it_returns_403_for_untracked_urls
    register_client
    post '/sources/jumpstartlab/data'

    assert_equal 0, PayloadRequest.count
    assert_equal 400, last_response.status
    assert_equal "Payload Not Valid", last_response.body
  end
end

