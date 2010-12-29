module Scalarium
  class Application
    attr_accessor :email, :password, :slug, :run_migrations

    def deploy
      login do
        agent.get("https://manage.scalarium.com/applications/#{slug}/deployments/new") do |page|
          form = page.forms.first
          form["deployment[migrate]"] = 1 if run_migrations
          form.click_button
        end
      end
    end

    def config
      yield(self)
    end

    private

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