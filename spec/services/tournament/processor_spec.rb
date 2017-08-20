require 'rails_helper'

RSpec.describe Tournament::Processor do
  let(:user_id) { User.create.id }

  describe '#build' do
    let(:tourn_summary_id) { raise 'define me' }

    subject { described_class.build(tourn_summary_id) }

    context 'success' do
      let(:tourn_summary_id) { TournSummary.create(user_id: user_id).id }

      it 'create new instance' do
        is_expected.to be_an_instance_of(Tournament::Processor)
      end
    end

    context 'failed' do
      let(:user_id) { User.create }
      let(:tourn_summary_id) { 10 }

      it 'raise ActiveRecord::RecordNotFound' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#new' do
    let(:tourn_summary) { raise 'define me' }

    subject { described_class.new(tourn_summary) }

    context 'with bad values' do
      let(:tourn_summary) { 'bad value' }

      it 'raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#call' do
    let(:tourn_summary) { raise 'define me' }

    subject { described_class.new(tourn_summary) }

    context 'success (tourn_summary with correct data)' do
      it 'return true' do
        expect(subject.call).to eq true
      end

      it 'change tourn_summary state to success' do
        pending
        # test that tourn_summary.aasm_state == :success
      end
    end

    context 'failed (tourn_summary without correct data)' do
      let(:tourn_summary) { TournSummary.create(user_id: user_id) }

      it 'return false' do
        expect(subject.call).to eq false
      end

      it 'change state to fail' do
        pending
        # subject.call
        # expect(subject.tourn_summary.aasm_state).to eq :failed
      end
    end
  end
end
