require 'rails_helper'

RSpec.describe Track, type: :model do
  subject { build(:track) }

  describe 'associations' do
    context 'when it is not associated with a conference' do
      it { is_expected.to be_valid }
    end

    context 'when it is not associated with a conference' do
      subject { build(:track, conference: nil) }
      it { is_expected.not_to be_valid }
    end
  end

  describe '#duration' do
    let!(:lecture) { create(:lecture, track: subject, duration: 60) }

    it 'return the sum of track lectures duration' do
      expect(subject.duration).to eq(60)
    end
  end
end
