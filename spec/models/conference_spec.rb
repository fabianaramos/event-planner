require 'rails_helper'

RSpec.describe Conference, type: :model do
  describe 'validations' do
    context 'when name is present' do
      subject { build(:conference) }
      it { is_expected.to be_valid }
    end

    context 'when name is not present' do
      subject { build(:conference, name: nil) }
      it { is_expected.not_to be_valid }
    end
  end
end
