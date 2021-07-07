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
end
