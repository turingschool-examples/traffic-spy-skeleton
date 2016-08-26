ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'database_cleaner'
require 'pg'
require './app/models/data_parser'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation

module TestHelpers
  def setup
    @params_client1 = {
      identifier: "jumpstartlab",
      rootUrl: "http://jumpstartlab.com"
    }
    @params_pay1 = {
      payload: {"url":"http://jumpstartlab.com/",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"},
              }
    @params_client2 = {
      identifier: "google",
      rootUrl: "http://google.com"
    }
    @params_pay2 = {
      payload: {"url":"http://google.com",
                "requestedAt":"2013-03-21 21:38:28 -0700",
                "respondedIn":41,
                "referredBy":"http://google.com",
                "requestType":"POST",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"800",
                "resolutionHeight":"600",
                "ip":"34.32.40.211"},
    }
    @params_pay3 = {
      payload: {"url":"http://jumpstartlab.com/",
                "requestedAt":"2015-02-16 21:38:28 -0700",
                "respondedIn":40,
                "referredBy":"http://google.com",
                "requestType":"GET",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"23.20.40.211"},
      identifier: "google",
      rootUrl: "http://google.com"
    }

    DatabaseCleaner.clean
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end
end
