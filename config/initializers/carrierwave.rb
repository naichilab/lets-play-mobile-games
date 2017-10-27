CarrierWave.configure do |config|
  container_name = ENV['CONOHA_CONTAINER_NAME']

  if ENV['CONOHA_TENANT_NAME']
    config.fog_credentials = {
        provider: 'openstack',
        openstack_tenant: ENV['CONOHA_TENANT_NAME'],
        openstack_username: ENV['CONOHA_API_USERNAME'],
        openstack_api_key: ENV['CONOHA_API_PASSWORD'],
        openstack_auth_url: ENV['CONOHA_API_AUTH_URL'] + '/tokens',
    }
    config.fog_directory = container_name
    config.asset_host = ENV['CONOHA_ASSET_HOST'] + '/' + container_name
  else
    config.fog_credentials = {
        provider: 'local',
        local_root: "#{Rails.root}/public/uploads/fog-local"
    }
    config.fog_directory = container_name
    config.asset_host = '/uploads/fog-local/' + container_name
  end

  config.storage :fog
  config.root = Rails.root.join('tmp')
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false
end
