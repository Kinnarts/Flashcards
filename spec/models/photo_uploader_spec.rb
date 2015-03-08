require "carrierwave/test/matchers"
require "rails_helper"
describe PhotoUploader do
  include CarrierWave::Test::Matchers
  before do
    PhotoUploader.enable_processing = true
    @card = Card.new(user_id: 1)
    @uploader = PhotoUploader.new(@card, :remote_photo_url)
    @uploader.store!(File.open("#{Rails.root}/spec/support/files/smile.jpg"))
  end
  after do
    PhotoUploader.enable_processing = false
    @uploader.remove!
  end
  context "the small version" do
    it "should scale down a landscape image to fit within 360 by 360 pixels" do
      expect(@uploader).to be_no_larger_than(360, 360)
    end
  end
end
