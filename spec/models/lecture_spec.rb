require 'rails_helper'

RSpec.describe Lecture, type: :model do
  subject { build(:lecture) }

  describe 'validations' do
    context 'when name is present' do
      it { is_expected.to be_valid }
    end

    context 'when name is not present' do
      subject { build(:lecture, name: nil) }
      it { is_expected.not_to be_valid }
    end

    context 'when duration is present' do
      it { is_expected.to be_valid }
    end

    context 'when duration is not present' do
      subject { build(:lecture, duration: nil) }
      it { is_expected.not_to be_valid }
    end

    context 'when duration is included in DURATIONS constant' do
      subject { build(:lecture, duration: 15) }
      it { is_expected.not_to be_valid }
    end
  end

  describe 'associations' do
    context 'when it is not associated with a conference' do
      it { is_expected.to be_valid }
    end

    context 'when it is not associated with a conference' do
      subject { build(:lecture, conference: nil) }
      it { is_expected.not_to be_valid }
    end
  end

  describe '#starts_at_formatted' do
    it 'returns starts_at formatted' do
      expect(subject.starts_at_formatted).to eq('10:00')
    end
  end

  describe '#ends_at_formatted' do
    it 'returns starts_at formatted' do
      expect(subject.ends_at_formatted).to eq('11:00')
    end
  end
end
