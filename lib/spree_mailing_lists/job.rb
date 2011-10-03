require 'resque'

module SpreeMailingLists
  class Job

    class << self
      
      def subscribe(mailing_list, email)
        Resque.enqueue(SpreeMailingLists::Job, mailing_list, email)
      end
    
      def perform(mailing_list, email)
        subscribe_to_mailing_list(mailing_list_id(mailing_list), email)
      end
    
      def mailing_list_id(mailing_list)
        SpreeMailingLists::Mailchimp.mailing_lists[mailing_list]
      end
  
      def subscribe_to_mailing_list(mailing_list_id, email)
        SpreeMailingLists::Mailchimp.api_client.list_subscribe(mailing_list_id, email, {}, 'html', false)
      end
      
    end
  
  end
end