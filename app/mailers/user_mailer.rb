# encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "volker@vergleichsportal.de"

  def reset_password_email(user)
    @user = user
    if Rails.env == "development"
      @url  = "http://0.0.0.0:3000/password_resets/#{user.reset_password_token}/edit"
    else
      @url  = "http://www.volkers-vergleichsportal.de/de/password_resets/#{user.reset_password_token}/edit"
    end
    mail(:to => user.email,
         :subject => "Dein Password wurde zurückgesetzt.")
  end

  def provider_quotation(name)
    @name = name
    mail(:to => "twe@informatik.uni-kiel.de",
	 :subject => "Volker wünscht einen neuen Provider")
  end
end
