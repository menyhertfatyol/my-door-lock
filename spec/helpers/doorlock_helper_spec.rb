require 'rails_helper'

RSpec.describe DoorlockHelper, type: :helper do
  let(:helper) { Class.new }
  before { helper.extend DoorlockHelper }

  describe '#lock_state' do
    context 'when the last database entry is older than 2 minutes' do
      let(:last_lock_state) { create :doorlock, created_at: 3.minutes.ago }

      it 'returns an error message' do
        expect(helper.lock_state(last_lock_state)).to eq "No data received since #{last_lock_state.created_at}"
      end
    end

    context 'when the last database entry was within 2 minutes' do
      let(:last_lock_state) { create :doorlock, created_at: 1.minute.ago }

      it 'returns the last lock state' do
        expect(helper.lock_state(last_lock_state)).to eq last_lock_state.state
      end
    end
  end

  describe 'background_color' do
    context 'when door is open' do
      it 'sets the background color to warning' do
        expect(helper.background_color('open')).to eq 'bg-warning'
      end
    end

    context 'when door is locked' do
      it 'sets the background color to info' do
        expect(helper.background_color('locked')).to eq 'bg-info'
      end
    end

    context 'when no data received' do
      it 'sets the background color to danger' do
        expect(helper.background_color('No data received...')).to eq 'bg-danger'
      end
    end
  end
end
