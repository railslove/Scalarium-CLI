require "thor"

module Scalarium
  class CLI < Thor
    %w{deploy rollback start stop restart undeploy}.each do |command|
      class_eval <<-EOF
        desc "#{command} [staging|production]", "#{command} to specified env"
        method_options :migrate => :boolean,
                       :config  => :string,
                       :comment => :string

        def #{command}(env="production")
          run(:#{command}, env)
        end
      EOF
    end

    private

    def run(command, env)
      application = Scalarium::Application.new

      application.config do |x|
        x.email = config[env]["email"]
        x.password = config[env]["password"]
        x.slug = config[env]["slug"]
      end

      deploy_options = {
        :run_migrations => options.migrate?,
        :comment => options[:comment]
      }

      application.send(command, deploy_options)
    end

    def config
      @config ||= begin
        config_path = options[:config] || "config/scalarium.yml"

        YAML.load_file(config_path)
      end
    end
  end
end