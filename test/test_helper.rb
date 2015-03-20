#test/test_helper.rb
require_relative '../lib/chargeover_ruby'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = File.dirname(__FILE__) + "/fixtures"
  c.hook_into :webmock

  # Removes all private data (Basic Auth, Set-Cookie headers...)
  c.before_record do |i|
    i.response.headers.delete('Set-Cookie')
    i.request.headers.delete('Authorization')

    u = URI.parse(i.request.uri)
    i.request.uri.sub!(/:\/\/.*#{Regexp.escape(u.host)}/, "://#{u.host}" )
  end

  # Matches authenticated requests regardless of their Basic auth string (https://user:pass@domain.tld)
  c.register_request_matcher :anonymized_uri do |request_1, request_2|
    (URI(request_1.uri).port == URI(request_2.uri).port) &&
        URI(request_1.uri).path == URI(request_2.uri).path
  end

end

class ChargoverRubyTest < Minitest::Test

  def setup
    Chargeover.configure do |config|
      config.subdomain = 'imagerelay-staging'
      config.public_key = '123456'
      config.private_key = '789105'
    end
  end

end