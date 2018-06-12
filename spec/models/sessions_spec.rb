require 'spec_helper'
require 'pry'

describe 'Sessions' do

  it 'loads the workouts index after login' do
    @user = User.create(:username => "yanna b", :password => "test")

    params = {
      :username => "yanna b",
      :password => "test"
    }

    post '/login', params
    expect(last_response.status).to eq(302)
    follow_redirect!
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Welcome,")
  end

end
