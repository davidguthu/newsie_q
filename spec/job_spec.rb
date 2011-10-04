require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

MAILING_LISTS = { :customer => '1', :merchandiser => '2' }

describe NewsieQ::Job do
  let(:job) { NewsieQ::Job }
  let(:email) { Faker::Internet.email }
  let(:mailing_list_id) { 'f80ai25uox' }
  let(:mailing_list) { :mailing_list }
  let(:mailing_lists) { MAILING_LISTS }
  before { NewsieQ::Mailchimp.mailing_lists = MAILING_LISTS }
  
  describe "subscribe" do
    after { job.subscribe(mailing_list, email) }
  
    it "should enqueue" do
      Resque.should_receive(:enqueue).with(NewsieQ::Job, mailing_list, email)
    end    
  end

  describe "perform" do
    after { job.perform(:customer, email) }
  
    it "should call subscribe_to_mailing_list" do
      job.should_receive(:subscribe_to_mailing_list).with('1', email)
    end
  end
  
  describe "mailing_list_id" do
    let(:mailing_list) { 'customer' }
    after { NewsieQ::Job.mailing_list_id(mailing_list) }
    
    it "should convert string to symbol" do
      mailing_list.should_receive(:to_sym)
    end
    
  end
  
  describe "subscribe_to_mailing_list" do
    let(:client) { mock }
    before do
      client.stub(:list_subscribe => true)
      NewsieQ::Mailchimp.stub(:api_client => client)
    end
    after { job.subscribe_to_mailing_list(mailing_list_id, email) }
    
    it "should subscribe to mailchimp" do
      client.should_receive(:list_subscribe).with(mailing_list_id, email, {}, 'html', false)
    end
  end
  
end