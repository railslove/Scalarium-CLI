require "thor"

module Scalarium
  class CLI < Thor
    desc "deploy [staging|production]", "deploy to specified env"
    method_options :migrate => :boolean,
                   :config  => :string,
                   :comment => :string

    def deploy(env="production")
      application = Scalarium::Application.new

      application.config do |x|
        x.email = config[env]["email"]
        x.password = config[env]["password"]
        x.slug = config[env]["slug"]
      end

      application.deploy(
        :run_migrations => options.migrate?,
        :comment => options[:comment]
      )
    end

    private

    def config
      @config ||= begin
        config_path = options[:config] || "config/scalarium.yml"

        YAML.load_file(config_path)
      end
    end
  end
end