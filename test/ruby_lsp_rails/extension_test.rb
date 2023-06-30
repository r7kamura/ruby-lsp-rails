# typed: true
# frozen_string_literal: true

require "test_helper"

module RubyLsp
  module Rails
    class ExtensionTest < ActiveSupport::TestCase
      setup do
        stub_rails_config(server: true)
      end

      test "name returns extension name" do
        extension = Extension.new
        assert_equal("Ruby LSP Rails", extension.name)
      end

      test "activate checks if Rails server is running" do
        rails_client = stub("rails_client", check_if_server_is_running!: true)

        RubyLsp::Rails::RailsClient.stubs(instance: rails_client)
        extension = Extension.new
        assert_predicate(extension, :activate)
      end

      test "does not ping the server if disabled" do
        stub_rails_config(server: false)
        rails_client = mock("rails_client")
        mock.expects(:check_if_server_is_running!).never

        RubyLsp::Rails::RailsClient.stubs(instance: rails_client)
        extension = Extension.new
        extension.activate
      end
    end
  end
end
