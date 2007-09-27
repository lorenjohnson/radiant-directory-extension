class DirectoryMailings < ActionMailer::Base

  def mailing(message_recipients, message_subject, message)
    recipients message_recipients
    from "loren_johnson@yahoo.com"
    subject message_subject
    body :body => message
  end
  
end
