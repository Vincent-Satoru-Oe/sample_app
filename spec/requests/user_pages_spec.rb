require 'spec_helper'

describe "User Pages" do

	let(:base_title) {"Ruby on Rails Tutorial Sample App" }

  	describe "Sign up Page" do
  		before {visit signup_path}

    	it "should have the h1 'Sign Up'" do
    		page.should have_selector('h1', :text => 'Sign Up')
    	end

    	it "should have the title 'Sign Up'" do
    		page.should have_selector('title', :text => "#{base_title} | Sign Up")
    	end

    end

end
