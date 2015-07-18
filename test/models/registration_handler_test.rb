require_relative '../test_helper'

class RegistrationHandlerTest < Minitest::Test
  attr_reader :raw_input

  def setup
    super
    @raw_input = { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }
  end

  def test_returns_400_when_parameters_missing
    params  = {}
    handler = RegistrationHandler.new(params)

    assert_equal 400, handler.status
    assert_equal "Missing Parameters - 400 Bad Request", handler.body
  end

  def test_returns_400_when_identifier_missing
    params  = { "rootUrl" => "http://facebook.com" }
    handler = RegistrationHandler.new(params)

    assert_equal 400, handler.status
    assert_equal "Missing Parameters - 400 Bad Request", handler.body
  end

  def test_returns_400_when_rootUrl_missing
    params  = { "identifier" => "facebook" }
    handler = RegistrationHandler.new(params)

    assert_equal 400, handler.status
    assert_equal "Missing Parameters - 400 Bad Request", handler.body
  end

  def test_returns_200_when_registration_successful
    handler = RegistrationHandler.new(raw_input)

    assert_equal 200, handler.status
    assert_equal "{'identifier' : 'facebook'}", handler.body
  end

end
