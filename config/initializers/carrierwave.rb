CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Rails.application.secrets.aws_access_key_id,
    aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region:                'us-east-1'
  }
  config.fog_directory  = 'flashcards-mkdev'
  # config.fog_public     = false
  # config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
end
