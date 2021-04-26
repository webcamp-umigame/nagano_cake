require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NaganoCake
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # タイムゾーンを東京へ変更（デフォルト：UTC）
    config.time_zone = 'Tokyo'

    # エラーメッセージの日本語化
    #g.i18n.default_locale = :ja
    # config/locales以下のディレクトリ内にある全てのymlファイルを読み込むように指示する
    # ( 参考：https://qiita.com/Ushinji/items/242bfba84df7a5a67d5b )
    #config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
  end
end
