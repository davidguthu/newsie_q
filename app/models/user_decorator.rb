User.class_eval do
  after_create :subscribe_to_customer_mailing_list
  
  def subscribe_to_merchandiser_mailing_list
    SpreeMailingLists::Job.subscribe(email, :merchandiser)
  end
  
  def subscribe_to_customer_mailing_list
    unless anonymous?
      SpreeMailingLists::Job.subscribe(email, :customer)
    end
  end
  
end