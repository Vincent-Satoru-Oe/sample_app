require 'spec_helper'

describe "User Pages" do

  subject {page}
	let(:base_title) {"Ruby on Rails Tutorial Sample App" }

  describe "profile page" do
    let(:user) {FactoryGirl.create(:user) }
    before {visit user_path(user)}

    it {should have_selector('h1', text: user.name)}
    it {should have_selector('title', text: user.name)}
  end

  describe "Sign up Page" do
  	before {visit signup_path}

  	it {should have_selector('h1', :text => 'Sign Up')}
  	it {should have_selector('title', :text => "#{base_title} | Sign Up")}   
  end

end
