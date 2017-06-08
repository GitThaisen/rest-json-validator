require 'rest-json-validator'
require 'json'
gem "minitest"
require 'minitest/autorun'
require 'minitest/spec'
require "mediaelement_test_spec"
include RestJsonValidator
include MediaelementTestSpec

class Tester < JsonValidator
  def initialize
    @bugs = []
    super

  end

  def notify message
    @bugs << message
  end

  def num_bugs
    # @bugs.each do |b|
    #   puts b
    # end
    @bugs.length
  end
end

class RestJsonValidatorTest < Minitest::Spec

  def test_the_mediaelement_has_the_expected_specification
    tester = Tester.new
    tester.add_listener self
    mediaelement = JSON.parse open("./test/mediaelement.json").read()
    tester.validate_json_api_compliance(mediaelement, MEDIAELEMENT_V9_CHECKS )
    assert_equal 0, tester.num_bugs, "Expected no errors found here"


  end



end
