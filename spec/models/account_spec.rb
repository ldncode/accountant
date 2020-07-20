require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :nickname}

    it { is_expected.to have_many(:expense).dependent(:destroy) }
  end
end