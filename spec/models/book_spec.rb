# require 'spec_helper'
# require 'rack/test'
# require 'factory_bot'

# FactoryBot.define do
#   factory :book do
#     isbn { "1230091823471" }
#     title  { "Mock Book" }
#     publisher  { "Mock publisher" }
#     releasedate  { "10/10/2018" }
#     website { "https://google.com" }
#   end
# end

# RSpec.describe Book, type: :model do
#   include FactoryBot::Syntax::Methods

#   it 'has a valid factory' do
#     expect(FactoryBot.create(:book)).to be_valid
#   end

#   context 'validations' do
#     it { is_expected.to validate_presence_of :isbn }
#     it { is_expected.to validate_uniqueness_of :title }
#     it { is_expected.to validate_confirmation_of :publisher }
#     it { is_expected.to validate_presence_of :releasedate }
#     it { is_expected.to validate_presence_of :website }
#   end
# end