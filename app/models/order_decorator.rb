Order.class_eval do
  after_save :subscribe_to_customer_mailing_list, :if => email_changed?
  
  def subscribe_to_customer_mailing_list
    SpreeMailingLists::Job.subscribe(email, :customer)
  end
  
end