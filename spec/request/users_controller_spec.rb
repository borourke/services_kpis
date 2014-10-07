require 'spec_helper'

describe UsersController do
  include RSpec::Rails::ControllerExampleGroup
  describe "#create" do 
    context "valid request" do
      it "creates a new user" do 
        post('create', {user: {name: "wee", password: "my_pass"}})
        expect(response).to redirect_to(sign_up_path)
      end

      it "returns a 200" do
      end
    end

    context "invalid request" do 
      it "returns a 422" do
      end

      it "returns error messages" do
      end
    end
  end
end