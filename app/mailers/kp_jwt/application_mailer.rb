# frozen_string_literal: true

module KpJwt
  # base for kp jwt all application mailer
  class ApplicationMailer < ActionMailer::Base
    default from: 'from@example.com'
    layout 'mailer'
  end
end
