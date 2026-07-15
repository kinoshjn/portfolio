class InquiriesMailer < ApplicationMailer
  def notify(name, email, content)
    @name = name
    @email = email
    @content = content
    mail(
      to: ENV["INQUIRY_TO_EMAIL"],
      reply_to: email,
      subject: "お問い合わせ"
    )
  end
end
