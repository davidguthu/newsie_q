require 'hominid'

module SpreeMailingLists
  module Mailchimp
    extend self
    
    attr_accessor :api_key
  
    # lists takes form {:customer => 'id1', :merchandiser => 'id2'}
    def mailing_lists=(mailing_lists)
      @mailing_lists = mailing_lists
    end
  
    def mailing_lists
      @mailing_lists ||= {}
    end
  
    def api_client
      @api_client ||= Hominid::API.new(api_key)
    end
    
  end
end
