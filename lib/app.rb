require File.expand_path("../../config/env",__FILE__)

class WebMailerApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set :views, ["templates"]
  set :root, File.expand_path("../../", __FILE__)
  register Sinatra::AssetPack

  assets {
    serve '/js', :from => 'assets/javascripts'
    serve '/css', :from => 'assets/stylesheets'

    js :application, "/js/application.js", [
      '/js/jquery-1.11.0.min.js',
      '/js/**/*.js'
    ]

    css :application, "/css/application.css", [
      '/css/**/*.css'
    ]

    css_compression :yui
    js_compression  :uglify
  }

  get "/" do
    @mails = Dir[File.expand_path("../../templates/mailer/*.haml", __FILE__)]
    @mails.map!{|path|File.basename(path)}
    haml :index
  end

  get '/send_mail/:name' do
    haml :send_mail
  end

  post "/send_mail" do
    mail = Mailer.send_email(
      :template_name => params[:name],
      :from => params[:mail][:username],
      :to   => params[:mail][:to],
      :cc   => params[:mail][:cc],
      :subject => params[:mail][:subject],
      :content => params[:mail][:content]
    )
    mail.delivery_method.settings.merge!(
      :address   => params[:mail][:smtp],
      :user_name => params[:mail][:username],
      :password  => params[:mail][:password]
    )
    mail.deliver
    haml :send_mail
  end

end
