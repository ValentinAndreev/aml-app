Bugsnag.configure do |config|
  config.api_key = "3019edd97c98a2d81f7a880a635b3957"
  config.app_version = AppVersion.format('%M.%m.%p')
  config.notify_release_stages = %w(production staging staging2 staging3)
  config.send_code = true
  config.send_environment = true
end

Bugsnag.before_notify_callbacks << lambda do |report|
  report.add_tab :context, request_id: Thread.current[:request_id] if Thread.current[:request_id].present?
end
