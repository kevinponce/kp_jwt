# frozen_string_literal: true

module GenericSupport
  def body_as_json(response)
    json_str_to_hash(response.body)
  end

  def json_str_to_hash(str)
    JSON.parse(str).with_indifferent_access
  end

  def is_unauthorized?(response)
    json_str_to_hash(response.body)[:errors].include? 'Not Authenticated'
  end
end
