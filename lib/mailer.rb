class Mailer < ActionMailer::Base

  def send_email(options)
    @subject = options[:subject]
    @content = options[:content]

    mail(
      :from    => options[:from],
      :to      => options[:to],
      :cc      => options[:cc],
      :subject => @subject
    ) do |format|
      format.html{render "mailer/#{options[:template_name]}"}
    end
  end
end