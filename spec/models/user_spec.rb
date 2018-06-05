require 'spec_helper'

require 'pry'
describe 'User' do
  before do
    binding.pry
    @user = User.create(:username => "yanna b", :password => "test")
    binding.pry
  end
  it 'can slug the username' do
    binding.pry
    expect(@user.slug).to eq ("yanna-b")
  end


end
