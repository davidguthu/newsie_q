require 'resque'

module NewsieQ
  class Job
    @queue = :newsie_q_job

    class << self
      
      def subscribe(mailing_list, email)
        Resque.enqueue(NewsieQ::Job, mailing_list, email)
      end
    
      def perform(mailing_list, email)
        subscribe_to_mailing_list(mailing_list_id(mailing_list), email)
      end
    
      def mailing_list_id(mailing_list)
        NewsieQ::Mailchimp.mailing_lists[mailing_list.to_sym]
      end
  
      def subscribe_to_mailing_list(mailing_list_id, email)
        NewsieQ::Mailchimp.api_client.list_subscribe(mailing_list_id, email, {}, 'html', false, true)
      end
      
    end
  
  end
end