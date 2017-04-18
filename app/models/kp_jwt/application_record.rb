# frozen_string_literal: true

module KpJwt
  # base for kp jwt models
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
