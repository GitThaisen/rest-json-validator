require 'rest-json-validator'
include RestJsonValidator

class Tester < JsonValidator
  def initialize
    @bugs = []
    @check_title_called = false
    @check_parts_called = false
    @check_nonplayable_called = false
    super
  end

  def notify message
    @bugs << message
  end

  def check_title(a, b, c)
    @check_title_called = true
  end

  def check_parts(a, b, c)
    @check_parts_called = true
  end

  def check_nonplayable(a, b, c)
    @check_nonplayable_called = true
  end

  def num_bugs
    @bugs.each do |b|
      puts b
    end
    @bugs.length
  end

  def check_title_called?
    @check_title_called
  end

  def check_parts_called?
    @check_parts_called
  end

  def check_nonplayable_called?
    @check_nonplayable_called
  end
end