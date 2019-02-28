require "rails_helper"

describe "users#create", type: :request do
  describe "success" do
    let(:default_params) {{
      user: {
        first_name: "Test First",
        last_name: "Test Last",
        email: "test1@test.com"
      }
    }}

    it "responds with success" do
      post "/users", params: default_params
      expect(response).to have_http_status(:ok)
    end

    it "returns user data" do
      post "/users", params: default_params
      body = JSON.parse(response.body)
      first_name = body["user"]["first_name"]
      expect(first_name).to eq(default_params[:user][:first_name])
    end

    it "creates a user" do
      expect{ post "/users", params: default_params }.to change(User, :count).by(1)
    end
  end

  describe "failure" do
    let(:invalid_params) {{
      user: { last_name: "Test Last", email: "test1@test.com" }
    }}

    it "responds with failure" do
      post "/users", params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "does not create a user" do
      expect{ post "/users", params: invalid_params }.to change(User, :count).by(0)
    end
  end

end
