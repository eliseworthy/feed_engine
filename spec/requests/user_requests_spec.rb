require 'spec_helper'

describe User do
  context "who is authenticated" do
  end

  context "who is unauthenticated" do
    let(:new_user) { Fabricate.build(:user) }
    let(:user) { Fabricate(:user) }

    it "can sign up from the home page" do
      visit root_path
      page.should have_link "Sign Up"
    end

    describe "signing up" do
      before(:each) do
        visit signup_path
        fill_signup_form_as(new_user)
      end

      it "sees signup fields on the signup page" do
        page.should have_content "Sign Up"
        page.should have_content "Email"
        page.should have_content "Password"
      end

      it "can create an account" do
        expect { click_button "Sign Up" }.to change { User.count }.by(1)
      end

      it "is redirected to their dashboard after sign up with a flash message" do
        click_button "Sign Up"
        current_path.should == dashboard_path
        page.should have_content "Thank you for signing up!"
      end

      it "cannot sign up with an empty email address" do
        fill_in "Email", :with => ""
        expect { click_button "Sign Up" }.to change { User.count }.by(0)
        page.should have_content "Email can't be blank"
      end
      it "cannot sign up with an already-used email address" do
        fill_signup_form_as(user)
        expect { click_button "Sign Up" }.to change { User.count }.by(0)
        page.should have_content "Email has already been taken"
      end
      it "cannot sign up with an invalid email address" do
        fill_in "Email", :with => "test"
        expect { click_button "Sign Up" }.to change { User.count }.by(0)
        page.should have_content "Email is invalid"
      end
      it "cannot sign up with an invalid display name" do
        fill_in "Display name", :with => "test test"
        expect { click_button "Sign Up" }.to change { User.count }.by(0)
        page.should have_content "Display name must be only letters, numbers, dashes, or underscores"
      end
      it "cannot sign up with an empty password" do
        fill_in "Password", :with => ""
        fill_in "Password confirmation", :with => ""
        expect { click_button "Sign Up" }.to change { User.count }.by(0)
        page.should have_content "Password can't be blank"
      end
      it "cannot sign up with an inconsistent password and confirmation" do
        fill_in "Password", :with => "testering"
        fill_in "Password confirmation", :with => "tester"
        expect { click_button "Sign Up" }.to change { User.count }.by(0)
        page.should have_content "Password doesn't match confirmation"
      end
      it "cannot sign up with too short of a password" do
        fill_in "Password", :with => "testr"
        fill_in "Password confirmation", :with => "testr"
        expect { click_button "Sign Up" }.to change { User.count }.by(0)
        page.should have_content "Password is too short"
      end
      it "receives an email after a successful sign-up" do
        expect { click_button "Sign Up" }.to change { ActionMailer::Base.deliveries.length }.by(1)
      end
    end
  end
end