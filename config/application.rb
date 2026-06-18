require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 7.2
    config.autoload_lib(ignore: %w[assets tasks])

    config.action_view.field_error_proc = Proc.new do |html_tag, instance|html_tag
    end
  end
end
