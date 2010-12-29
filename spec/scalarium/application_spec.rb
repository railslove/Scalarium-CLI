require "spec_helper"

describe Scalarium::Application do
  describe "Configuring an application" do
    before(:all) do
      @application = Scalarium::Application.new
      @application.config do |c|
        c.email = "test@email.com"
        c.password = "password"
        c.slug = "railslove"
      end
    end

    subject { @application }

    its(:email) { should eql("test@email.com") }
    its(:password) { should eql("password") }
    its(:slug) { should eql("railslove") }
  end

  describe "Deploying an application" do
    before do
      stub_request(:any, /scalarium/)

      @application = Scalarium::Application.new

      # WebMock stubs
      stub_request(:get, "https://manage.scalarium.com/session/new").
        to_return(:body => fixture("session_new.html"),
                  :headers => {"Content-Type" => "text/html"})

      stub_request(:post, "https://manage.scalarium.com/session")

      stub_request(:get, "https://manage.scalarium.com/applications/railslove/deployments/new").
        to_return(:body => fixture("new_deploy.html"),
                  :headers => {"Content-Type" => "text/html"})
    end

    context "when basic deploy" do
      before do
        @application.config do |c|
          c.email = "test@email.com"
          c.password = "password"
          c.slug = "railslove"
        end

        @application.deploy
      end

      subject { WebMock::API }

      it { should have_requested(:get, "https://manage.scalarium.com/session/new") }
      it { should have_requested(:get, "https://manage.scalarium.com/applications/railslove/deployments/new") }
      it { should have_requested(:post, "https://manage.scalarium.com/applications/railslove/deployments") }
    end

    context "when deploying with a migration" do
      before do
        @application.config do |c|
          c.email = "test@email.com"
          c.password = "password"
          c.slug = "railslove"
          c.run_migrations = true
        end

        @application.deploy
      end

      subject { WebMock::API }

      it { should have_requested(:post, "https://manage.scalarium.com/applications/railslove/deployments").
            with {|req| req.body.match(/migrate%5D=1/) } }
    end
  end
end