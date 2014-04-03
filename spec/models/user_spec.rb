require 'spec_helper'

describe User do
  before { @user = FactoryGirl.create(:user) }
  subject { @user }

  it { should respond_to( :name) }
  it { should respond_to( :email) }
  it { should respond_to( :password_digest) }
  it { should respond_to( :password )}
  it { should respond_to( :password_confirmation )}
  it { should respond_to( :authenticate )}
  it { should respond_to( :remember_token )}
  it { should be_valid}
  
  describe "When password => " do
    describe "when password is too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should_not be_valid }
    end
    
    describe "when password is not present" do
      before do
        @user.password = " "
        @user.password_confirmation = " "
      end
      it { should_not be_valid}
    end
    
    describe "when password is not match" do
      before do 
        @user.password_confirmation = "mismatch"
      end
      it { should_not be_valid }
    end
  end
  
  describe "when email =>" do
    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com hfef@mail...com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).not_to be_valid
        end
      end
    end
  
    describe "when email format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end
    
    describe "when email is not present" do
      before { @user.email = " " }
      it { should_not be_valid }
    end
  
    describe "when email is already taken" do
    	before do
        @user_with_same_email = @user.dup
        @user_with_same_email.save
    	end
    	subject { @user_with_same_email }
    	it { should_not be_valid }
    end
  
    describe "email should be downcase before save to db" do
    	let(:mix_case_email) { "HoangHIEU@mail.com" }  	
    	before do		
    		@user.email = mix_case_email
    		@user.save
    	end
    	it " => should be downcase" do  		
    		expect(@user.reload.email).to eq mix_case_email.downcase
    	end
    end
  end

  describe "return value of authenticate method" do 
  	before { @user.save }
  	let(:found_user) { User.find_by(email: @user.email)}

  	describe "user should be accessed" do  		
  		it { should eq found_user.authenticate(@user.password)}
  	end

  	describe "user should not be accessed" do
  		let(:user_for_invalid) { found_user.authenticate("invalid") }
  		it { should_not eq user_for_invalid }
  		specify { expect(user_for_invalid).to be_false}
  	end
  end
  
  describe "When name is not present" do
  	before { @user.name = "" }
  	it { should_not be_valid}
  end

  describe "when name is too long" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid}
  end 

  describe "before create" do
    before { @user.save }
    its(:remember_token) { should_not be_blank}
  end

  describe "user relations" do
    
  end
end
