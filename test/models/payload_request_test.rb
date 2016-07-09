require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_that_it_creates_a_payload_request
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 40,
                            url_id: 1,
                            referral_id: 1,
                            request_type_id: 1,
                            user_agent_device_id: 1,
                            resolution_id: 1,
                            ip_id: 1,
                            sha: 1)

    assert pr.valid?
    assert pr.respond_to?(:requested_at)
    assert pr.respond_to?(:responded_in)
    assert pr.respond_to?(:url_id)
    assert pr.respond_to?(:referral_id)
    assert pr.respond_to?(:request_type_id)
    assert pr.respond_to?(:user_agent_device_id)
    assert pr.respond_to?(:resolution_id)
    assert pr.respond_to?(:ip_id)
    assert pr.respond_to?(:sha)
    #can do individually for each validation,
    #payload_request.url -- that will test the connection b/w pr and url and get a certain url
    #want to make sure we can use pr.url and can use method respond_to?(:url)
    #pr.respond_to?(:url) wont' pass until it belongs to (sets up the relationship)
  end

  def test_it_needs_a_requested_at
    pr = PayloadRequest.new(requested_at: nil,
                            responded_in: 40,
                            url_id: 1,
                            referral_id: 1,
                            request_type_id: 1,
                            user_agent_device_id: 1,
                            resolution_id: 1,
                            ip_id: 1,
                            sha: 1)
    refute pr.valid?
  end

  def test_it_needs_a_responded_in
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: nil,
                            url_id: 1,
                            referral_id: 1,
                            request_type_id: 1,
                            user_agent_device_id: 1,
                            resolution_id: 1,
                            ip_id: 1,
                            sha: 1)
    refute pr.valid?
  end

  def test_it_needs_a_url_id
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 40,
                            url_id: nil,
                            referral_id: 1,
                            request_type_id: 1,
                            user_agent_device_id: 1,
                            resolution_id: 1,
                            ip_id: 1,
                            sha: 1)
    refute pr.valid?
  end

  def test_it_needs_a_referral_id
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 40,
                            url_id: 1,
                            referral_id: nil,
                            request_type_id: 1,
                            user_agent_device_id: 1,
                            resolution_id: 1,
                            ip_id: 1,
                            sha: 1)
    refute pr.valid?
  end

  def test_it_needs_a_request_type_id
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 40,
                            url_id: 1,
                            referral_id: 1,
                            request_type_id: nil,
                            user_agent_device_id: 1,
                            resolution_id: 1,
                            ip_id: 1,
                            sha: 1)
    refute pr.valid?
  end

  def test_it_needs_a_user_agent_id
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 40,
                            url_id: 1,
                            referral_id: 1,
                            request_type_id: 1,
                            user_agent_device_id: nil,
                            resolution_id: 1,
                            ip_id: 1,
                            sha: 1)
    refute pr.valid?
  end

  def test_it_needs_a_resolution_id
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 40,
                            url_id: 1,
                            referral_id: 1,
                            request_type_id: 1,
                            user_agent_device_id: 1,
                            resolution_id: nil,
                            ip_id: 1,
                            sha: 1)
    refute pr.valid?
  end

  def test_it_needs_an_ip_address
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 40,
                            url_id: 1,
                            referral_id: 1,
                            request_type_id: 1,
                            user_agent_device_id: 1,
                            resolution_id: 1,
                            ip_id: nil,
                            sha: '1')
    refute pr.valid?
  end

  def test_it_needs_a_sha
    pr = PayloadRequest.new(requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 40,
                            url_id: 1,
                            referral_id: 1,
                            request_type_id: 1,
                            user_agent_device_id: 1,
                            resolution_id: 1,
                            ip_id: nil,
                            sha: '1')
    refute pr.valid?
  end

  def test_it_can_find_the_average
    create_multiple_payloads(5)

    assert_equal 15, PayloadRequest.average_response_time
  end

  def test_it_can_find_the_minimum_reponse_time
    create_multiple_payloads(5)

    assert_equal 5, PayloadRequest.min_response_time
  end

  def test_it_can_find_the_maximum_response_time
    create_multiple_payloads(5)

    assert_equal 25, PayloadRequest.max_response_time
  end
end
