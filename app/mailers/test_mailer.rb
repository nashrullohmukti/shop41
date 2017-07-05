class TestMailer < ApplicationMailer
  def test
    mail(to: "rhulmukti@gmail.com", subject: 'Welcome to My Test')
  end
end
