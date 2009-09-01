class Message < ActiveRecord::Base
  cattr_accessor :settings
  belongs_to :from_user, :class_name => 'User'
  belongs_to :to_user, :class_name => 'User'
  
  validates_presence_of :from_user
  validates_presence_of :to_user
  
  def to_s() title end
  
  def self.relay
    imap = Net::IMAP.new('imap.gmail.com', '993', true)
    imap.login Message.settings[:address], Message.settings[:password]
    imap.select('Inbox')
    rejected_count = sent_count = 0
    messages = imap.uid_search(["NOT", "DELETED"]).map do |m|
      mail = TMail::Mail.parse(imap.uid_fetch(m, ['RFC822']).first.attr['RFC822'])
      to_user = User[mail.to_addrs.first.local]
      from_user = User.find_by_email mail.from_addrs.first.spec
      message = nil
      if to_user && from_user && from_user.has_access_to_user(to_user)
        body = mail.parts.empty?? mail.body.to_s : mail.parts.first.body.to_s
        message = Message.create! :from_user => from_user, :to_user => to_user, :body => body, :title => mail.subject
        imap.uid_copy(m, "Relayed")
        sent_count += 1
        puts "Sent: #{from_user} -> #{to_user}"
      else
        rejected_count += 1
        imap.uid_copy(m, "[Gmail]/All Mail")
        puts "Rejected: #{from_user} -> #{to_user}"
      end
    
      imap.uid_store(m, "+FLAGS", [:Deleted])
      message
    end.compact
    imap.expunge
    imap.logout
  
    puts "Received #{messages.size} emails, rejected #{rejected_count}"
  end
end
