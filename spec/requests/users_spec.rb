require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /create" do
    let(:valid_attributes) do
      {
        email: "test@example.com",
        password: "password",
        password_confirmation: "password",
        name: "Test User"
      }
    end

    let(:invalid_attributes) do
      {
        email: "invalid",
        password: "short",
        password_confirmation: "short",
        name: ""
      }
    end

    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post users_path, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "returns a created status" do
        post users_path, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post users_path, params: invalid_attributes
        }.to change(User, :count).by(0)
      end

      it "returns an unprocessable entity status" do
        post users_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body["errors"][0]).to include('Formato de e-mail inválid')
      end
    end
  end
end
