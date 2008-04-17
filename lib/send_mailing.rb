# From http://www.myowndb.com/blog/?p=20 

require 'net/smtp'
require 'enumerator'
require 'breakpoint'

#number of mails sent in one connection to the smtp server
SENDING_BATCH_SIZE=50

#SMTP SERVER
SMTP_SERVER='localhost'

tmail = DirectoryMailings.create_mailing()

#Build your recipient list here
recipients = [] 


puts "Are you sure you want to send the mailing to #{recipients.length} recipients? Type yes to confirm."
confirmation = (STDIN.readline.chop=='yes')
exit if !confirmation
puts "sending...."

exceptions = {}
recipients.each_slice(SENDING_BATCH_SIZE) do |recipients_slice|
  Net::SMTP.start(SMTP_SERVER, 25) do |sender|
    recipients_slice.each do |recipient|
      tmail.to = recipient
      begin
        sender.sendmail tmail.encoded, tmail.from, recipient
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

if exceptions.length>0
  answer = ""
  while not ["y","n"].include? answer
    puts "There were #{exceptions.length} errors! Do you want to use breakpoint to see them? (y/n)"
    answer = STDIN.readline.chop
  end
  breakpoint if (answer=='y')
  logfile = "log/mailing-exceptions-#{Time.now.strftime("%Y-%m-%dT%H:%M:%S")}.yaml"
  File.open( logfile, 'w' ) do |out| YAML.dump( exceptions, out ) end
  puts "You can find a dump of the exceptions in #{logfile}"
end
