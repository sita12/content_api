require 'rails_helper'

RSpec.describe "Api::V1::Contents", type: :request do
  describe ' controller test cases ' do
    let(:user1) { FactoryBot.create(:user, email: "kim@gmail.com") }
    let(:content1) { FactoryBot.create(:content, user: user1) }
    let(:new_user) { FactoryBot.create(:user, email: "katty@gmail.com") }

    describe '#create' do
      it 'should give status 200' do
        post "/api/v1/contents", params: { title: "Content title", body: "Content body" }, as: :json, headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("content")
      end
      it 'should give status 422' do
        post "/api/v1/contents", params: {}, as: :json, headers: authentication_header(user1)
        expect(response.status).to eq(422)
      end
      it 'should give status 401' do
        post "/api/v1/contents", params: { title: "Content title", body: "Content body" }, as: :json
        expect(response.status).to eq(401)
      end
    end

    describe '#update' do
      it 'should give status 200' do
        put "/api/v1/contents/#{content1.id}", params: { title: "Updated content title", body: "Updated content body" }, as: :json, headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("content")
      end
      it 'should give status 401' do
        put "/api/v1/contents/#{content1.id}", params: { title: "Updated content title", body: "Updated content body" }, as: :json
        expect(response.status).to eq(401)
      end
      it 'should give status 401' do
        put "/api/v1/contents/#{content1.id}", params: { title: "Updated content title", body: "Updated content body" }, as: :json, headers: authentication_header(new_user)
        expect(response.status).to eq(401)
      end
    end

    describe '#show' do
      it 'should give status 401' do
        get "/api/v1/contents/#{content1.id}"
        expect(response.status).to eq(401)
      end

      it 'should give status 200' do
        get "/api/v1/contents/#{content1.id}", headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("content")
      end
    end

    describe '#index' do
      it 'should give status 401' do
        get "/api/v1/contents"
        expect(response.status).to eq(401)
      end

      it 'should give status 200' do
        get "/api/v1/contents", headers: authentication_header(user1)
        expect(response.status).to eq(200)
        expect(response).to match_json_schema("contents")
      end
    end

    describe '#destroy' do
      it 'should give status 401' do
        user2 = FactoryBot.create(:user, email: "test3@gmail.com")
        content2 =  FactoryBot.create(:content, user: user2)
        delete "/api/v1/contents/#{content2.id}", headers: authentication_header(new_user)
        expect(response.status).to eq(401)
      end
      it 'should give status 200' do
        user2 = FactoryBot.create(:user, email: "test3@gmail.com")
        content2 =  FactoryBot.create(:content, user: user2)
        delete "/api/v1/contents/#{content2.id}", headers: authentication_header(user2)
        expect(response.status).to eq(200)
      end
    end
  end
end
