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

    desc "setup", "Adds config/scalarium.yml to .gitignore and creates config/scalarium.yml and config/scalarium.yml.example"
    def setup
      # Add config/scalarium.yml to .gitignore
      puts "Adding config/scalarium.yml to .gitignore"
      if File.read(".gitignore").match(/config\/scalarium\.yml/)
        puts "\tLooks like you already have it. Moving on..."
      else
        File.open(".gitignore", "a+") do |file|
          file.write("\nconfig/scalarium.yml")
        end
      end

      # Create config/scalarium.yml
      puts "Creating config/scalarium.yml"
      write_config_yml

      # Create config/scalarium.yml.example
      puts "Creating config/scalarium.yml.example"
      write_config_yml(:example)
    end

    private

    def write_config_yml(type=nil)
      filename = type ? "config/scalarium.yml.example" : "config/scalarium.yml"

      if File.exists?(filename)
        puts "\tLooks like you already have it. Moving on..."
      else
        File.open(filename, "w") do |file|
          file.write <<-EOF
credentials: &CREDENTIALS
  email: email@email.com
  password: password

staging:
  <<: *CREDENTIALS
  slug: XXX

production:
  <<: *CREDENTIALS
  slug: XXX
          EOF
        end
      end
    end

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