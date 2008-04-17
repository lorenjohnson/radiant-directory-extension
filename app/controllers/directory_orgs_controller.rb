require 'net/smtp'
require 'enumerator'

class DirectoryOrgsController < ApplicationController
  # layout "main"
  # no_login_required
  
  def index  
    @organizations = DirectoryOrg.find(:all, :order => "name")
  end

  def show 
    @organization = DirectoryOrg.find(params[:id])
  end
  
  def edit
    @organization = DirectoryOrg.find(params[:id])
  end

  def update
    @organization = DirectoryOrg.find(params[:id])
    if @organization.update_attributes(params[:directory_org]) and @organization.geocode
      redirect_to directory_orgs_url
    else
      flash[:notice] = ""
      @organization.errors.each_full { |e| flash[:notice] << e << ". " }
      render :action => "edit"
    end
  end
  
  def new
    @organization = DirectoryOrg.new
  end
  
  def create
    @organization = DirectoryOrg.new(params[:directory_org])    
    if @organization.save and @organization.geocode
      flash[:notice] = 'Organization was successfully created.'        
      redirect_to directory_orgs_url
    else
      flash[:notice] = ""
      @organization.errors.each_full { |e| flash[:notice] << e << ". " }
      render :action => "new"
    end
  end

  def destroy
    @organization = DirectoryOrg.find(params[:id])
    @organization.destroy
    redirect_to directory_orgs_url
  end

  def create_email
    @message = DirectoryMailings.create_mailing(DirectoryOrg.find(:all).find_all { |o| !o.email.nil? }.collect { |o| o.email }, "", "")
  end
  
  def send_bulk_message 
    # (recipients, subject, message)
    @message = DirectoryMailings.create_mailing(DirectoryOrg.find(:all).find_all { |o| !o.email.nil? }.collect { |o| o.email }, params[:message][:subject], params[:message][:body])
    exceptions = {}
    @message.to.each_slice(20) do |recipients_slice|
      Net::SMTP.start(ActionMailer::Base.smtp_settings[:address], ActionMailer::Base.smtp_settings[:port], "localhost", ActionMailer::Base.smtp_settings[:user_name],  ActionMailer::Base.smtp_settings[:password], ActionMailer::Base.smtp_settings[:authentication]) do |sender|
        recipients_slice.each do |recipient|
          @message_out = DirectoryMailings.create_mailing(recipient, params[:message][:subject], params[:message][:body])
          @message_out.to = recipient
          begin
            sender.sendmail @message_out.encoded, @message_out.from, recipient
          rescue Exception => e
            exceptions[recipient] = e 
            #needed as the next mail will send command MAIL FROM, which would 
            #raise a 503 error: "Sender already given"
            sender.finish
            sender.start
          end
        end
      end
    end
    if exceptions.length > 0
      # logfile = "log/mailing-exceptions-#{Time.now.strftime("%Y-%m-%dT%H:%M:%S")}.yaml"
      # File.open( logfile, 'w' ) do |out| YAML.dump( exceptions, out ) end
      flash[:notice] = YAML.dump(exceptions)
    else
      flash[:notice] = "Email successfully sent."
    end
    redirect_to directory_orgs_path
  end

end
