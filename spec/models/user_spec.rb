require 'spec_helper' #do I need this here?
require 'pry'

describe 'User' do
  before do
    @user = User.create(:username => "yanna b", :password => "test")
  end
  it 'can slug the username' do
    expect(@user.slug).to eq ("yanna-b")
  end

  it 'can find user based on slug' do
    name = @user.username
    slug = @user.slug
    expect(User.find_by_slug(slug).username).to eq (name)
  end

  it 'has a secure password' do
    expect(@user.authenticate("wrongpassword")).to eq(false)

    expect(@user.authenticate("test")).to eq(@user)
  end

end
