CarrierWave.configure do |config|
    config.storage = :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAJ24RDABGOAXK5RWA',
    aws_secret_access_key: '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',
    region: 'us-east-1'
  }

    case Rails.env
    when 'development'
        config.fog_directory  = 'goodpoint'
        config.asset_host = 'https://s3.amazonaws.com/goodpoint'
    when 'production'
        config.fog_directory  = 'goodpoint'
        config.asset_host = 'https://s3.amazonaws.com/goodpoint'
    end
end
