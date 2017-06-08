require 'json'
gem "minitest"
require 'minitest/autorun'
require 'minitest/spec'
require "mediaelement_test_spec"
require 'tester'
include MediaelementTestSpec



class RestJsonValidatorTestWithSpecErrors < Minitest::Spec
  def test_the_mediaelement_with_errors
    tester = Tester.new
    tester.add_listener self
    mediaelement = JSON.parse open("./test/mediaelement_with_errors.json").read()
    tester.validate_json_api_compliance(mediaelement, MEDIAELEMENT_V9_CHECKS )
    assert_equal 1, tester.num_bugs, "Expected to find one error here"
    assert_equal true, tester.check_title_called?, "Expedted check_title to be called"
    assert_equal true, tester.check_parts_called?, "Content_checker: Expected check_parts to be called"
    assert_equal true, tester.check_nonplayable_called?, "Composite_checker: Expected check_nonplayable to be called"
  end
end
