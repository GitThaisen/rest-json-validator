module RestJsonValidator
  class JsonValidator

    def initialize
      @stack        = []
      @listeners = []
    end

    # a listener must implement a method called notify, input string
    def add_listener(listener)
      @listeners << listener
    end

    def notify(message)
      @listeners.each do |l|
        l.notify message
      end
    end

    def is_field_validator?(api_element, api_key)
      if [:composite_checker].include?(api_key)
        retval = false
      elsif api_element == :composite
        retval = false
      elsif api_element.class == Symbol
        retval = true
      else
        retval = false
      end
      retval
    end

    def is_composite_checker?(api_element)
      (api_element.respond_to? :has_key? and api_element.has_key?(:composite_checker))
    end

    def is_sub_composite_checker?(api_element)
      (api_element.respond_to? :has_key? and api_element.has_key?(:sub_composite_checker))
    end

    def is_composite?(api_element)
      api_element == :composite
    end

    def is_content_checker?(api_element)
      api_element.is_a?(Array) and api_element[0].respond_to?(:has_key?) and api_element[0].has_key? :content_checker
    end

    def has_content_checker?(api_element)
      api_element.is_a?(Array) and api_element[0].respond_to?(:has_key?) and api_element[0].has_key? :content_checker
    end

    def find_id(json)
      id = nil
      if json.nil?
        puts "Warning: Trying to find id in a nil object (expected a actual_json structure)"
      elsif json.has_key? 'id'
        id = json['id']
      elsif json.has_key? 'programId'
        id = json['programId']
      elsif json.has_key? 'dataId'
        id = json['dataId']
      end
      id
    end

    def run_field_validators(actual_json, specification, level)
       if is_sub_composite_checker?(specification)
         send(specification[:sub_composite_checker], actual_json, find_id(actual_json), 'vetikke')
       else
      specification.keys.each do |api_key|
        api_element = specification[api_key]
        id          = find_id(actual_json)
        if is_field_validator?(api_element, api_key)
          send(api_element, actual_json[api_key], id, api_key)
        elsif is_composite_checker?(api_element)
          send(api_element[:composite_checker], actual_json[api_key], id, api_key)
        end
      end
       end
    end

    def validate_json(actual_json, specification, level)
      # puts "son: #{actual_json} api: #{api} level: #{level}"
      key_diff(actual_json, specification, level)
      run_field_validators(actual_json, specification, level)
    end

    def depth_validate_array(actual_json, specification, level, content_checker=nil)
      send(content_checker.intern, actual_json, @media_id, level) unless content_checker.nil?
      actual_json.each do |json_element|
        validate_json_api_compliance(json_element, specification, level)
      end
    end

    def depth_validate_hash(json, api, level)
      @last_id = json['id']
      validate_json(json, api, level)
      json.keys.each do |api_key|
        @stack.push(api_key)
        validate_json_api_compliance(json[api_key], api[api_key], level)
        @stack.pop
      end
    end

    def validate_json_api_compliance(actual_json, specification, level=0)
      return unless [Hash, Array].include? specification.class
      level += 1
      if actual_json.class == Array
        depth_validate_array(actual_json, specification[0][:data], level, specification[0][:content_checker])
      elsif actual_json.class == Hash
        depth_validate_hash(actual_json, specification, level)
      end
    end

    def key_diff(actual_json, specification, level)
      optionals = []
      if specification.respond_to?(:has_key?)
        optionals = specification.has_key?(:optionals) ? specification[:optionals].keys : []
      end
      api_keys = specification.keys
      api_keys.delete(:composite_checker)
      api_keys.delete(:sub_composite_checker)
      api_keys.delete(:optionals)
      json_keys = actual_json.keys
      diff      = []
      if api_keys.sort != json_keys.sort
        extra_api = api_keys - json_keys
        extra_json = json_keys - api_keys
        if extra_json.length == 0 and (extra_api - optionals).length == 0
          return
        else
          diff << 'specification - actual_json: '
          diff << api_keys - json_keys
          diff << 'actual_json - specification: '
          diff << json_keys - api_keys
          message = ("Nivå #{level}-feil\n(#{@stack.join('.')})\nfor #{@url}\ndiff: #{diff}\n")
          notify message: message
        end
      end
    end
  end
end
