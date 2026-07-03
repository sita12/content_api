require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe ' controller test cases ' do
    let(:user1) { FactoryBot.create :user }

    describe '#create' do
      it 'should give status 200' do
        post "/api/v1/users/signup", params: { first_name: "John", last_name: "Doe", email: "john1@email.com", password: "very_secret", country: "US" }, as: :json
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("user")
      end
      it 'should give status 422' do
        post "/api/v1/users/signup", params: {}, as: :json
        expect(response.status).to eq(422)
      end
    end

    describe '#login' do
      it 'should give status 200' do
        post "/api/v1/auth/signin", params: { auth: { email: "johnvon@gmail.com", password: "verysecret" } }, as: :json
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("user")
      end
      it 'should give status 400' do
        post "/api/v1/auth/signin", params: { auth: { email: "johnvon@gmail.com", password: "secret" } }, as: :json
        expect(response.status).to eq(400)
      end
    end
  end
end
