class Feedback < MailForm::Base
  attribute :name      
  attribute :email
  attribute :message, validate: true

  def headers
    {
      :subject => "You've got feedback from #{email}",
      :to => ENV['ADMIN_EMAIL'],
      :from => "#{email}"
    }
  end
end
