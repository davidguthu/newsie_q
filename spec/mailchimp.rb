require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NewsieQ::Mailchimp do
  let(:api_key) { ActiveSupport::SecureRandom.hex(5) }
  
  describe "api_client" do
    before { NewsieQ::Mailchimp.api_key = api_key }
    after { NewsieQ::Mailchimp.api_client }
    
    it "should instantiate new hominid client" do
      Hominid::API.should_receive(:new).with(api_key)
    end
  end
  
end