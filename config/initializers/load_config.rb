#In summary:

# config/initializers/load_config.rb
#APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")[RAILS_ENV]

# application.rb
#if APP_CONFIG['perform_authentication']
  # Do stuff
#end

require 'delegate'

module BBTangCMS
  class Config < SimpleDelegator
    def initialize(file_name)
      super(symbolize_keys( YAML.load_file(file_name)[Rails.env] || YAML.load_file(file_name)))
    end

    def [](*path)
      path.inject(__getobj__()) {|config, item|
        config[item]
      }
    end

    #def author_open_ids
    #  [self[:author, :open_id]].flatten.map {|uri| URI.parse(uri)}
    #end

    def self.default
      BBTangCMS::Config.new(default_location)
    end

    def self.default_location
      "#{Rails.root}/config/bbtangcms.yml"
    end

    def self.sina
      BBTangCMS::Config.new(sina_location)
    end

    def self.sina_location
      "#{Rails.root}/config/oauth/sina.yml"
    end

    def self.qq
      BBTangCMS::Config.new(qq_location)
    end

    def self.qq_location
      "#{Rails.root}/config/oauth/qq.yml"
    end

    def self.tag
      BBTangCMS::Config.new(tag_location)
    end

    def self.tag_location
      "#{Rails.root}/config/tag.yml"
    end

    def self.cms_roles
      BBTangCMS::Config.new(cms_roles_location)
    end

    def self.cms_roles_location
      "#{Rails.root}/config/cms_roles.yml"
    end

    def self.permits
      BBTangCMS::Config.new(permits_location)
    end

    def self.permits_location
      "#{Rails.root}/config/permits.yml"
    end

    private

    def symbolize_keys(hash)
      hash.inject({}) do |options, (key, value)|
        options[(key.to_sym rescue key) || key] = value.is_a?(Hash) ? symbolize_keys(value) : value
        options
      end
    end
  end
end
