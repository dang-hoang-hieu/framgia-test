require 'spec_helper'

describe Level do
  before { @level = FactoryGirl.create(:level) }
  subject { @level }

  it { should respond_to( :level )}
  it { should be_valid }
end
