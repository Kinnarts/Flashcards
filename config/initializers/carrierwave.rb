if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region: Rails.application.secrets.aws_region
    }
    config.storage = :fog
    config.fog_directory = Rails.application.secrets.aws_bucket
    config.fog_public = false
    config.fog_attributes = { "Cache-Control" => "max-age=#{365.day.to_i}" }
  end
end
