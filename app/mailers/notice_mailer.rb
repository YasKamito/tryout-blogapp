class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_confirm.subject
  #
  default from: "from@example.com"
  
  def sendmail_confirm(blog, entry, comment)
    @blog = blog
    @entry = entry
    @comment = comment

    mail to: "admin@example.com",
    subject: "テストメール"

  end
end
