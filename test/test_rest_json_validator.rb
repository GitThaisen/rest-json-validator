require 'rest-json-validator'
require 'json'
gem "minitest"
require 'minitest/autorun'
require 'minitest/spec'

include RestJsonValidator

class RestJsonValidatorTest < Minitest::Spec

  #implement test here
  # def test_all_agents_have_a_device
  #   puts "The USER_AGENTS contains streaming specifications for these platforms: #{USER_AGENTS.keys}."
  #   USER_AGENTS.keys.each do |platform|
  #     assert USER_AGENTS[platform][:device].class == String
  #     assert USER_AGENTS[platform][:device] != ""
  #   end
  # end
end
