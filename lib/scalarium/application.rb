module Scalarium
  class Application
    attr_accessor :email, :password, :slug

    %w{deploy rollback start stop restart undeploy}.each do |command|
      class_eval <<-EOF
      def #{command}(options={})
        run('#{command}', options)
      end
      EOF
    end

    def config
      yield(self)
    end

    private

    def run(deploy_command, options={})
      login do
        agent.get("https://manage.scalarium.com/applications/#{slug}/deployments/new") do |page|
          form = page.forms.first
          form["deployment[command]"] = deploy_command
          form["deployment[migrate]"] = 1 if options[:run_migrations]
          form["deployment[comment]"] = options[:comment]
          form.click_button
        end
      end
    end

    def login
      agent.get("https://manage.scalarium.com/session/new") do |page|
        manage_page = page.form_with(:action => "/session") do |f|
          f["user[email]"] = email
          f["user[password]"] = password
        end.click_button

        yield
      end
    end

    def agent
      @agent ||= Mechanize.new
    end
  end
end