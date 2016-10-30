require 'rails_helper'

RSpec.describe Auditorium, :type => :model do
  it 'has a valid factory' do
    expect(build(:auditorium)).to be_valid
  end
end