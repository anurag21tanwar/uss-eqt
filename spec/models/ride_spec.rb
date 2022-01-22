# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Ride, type: :model do
  let(:queue_length) { 10 }
  let(:status) { 'H' }
  subject { build(:ride, queue_length: queue_length, status: status) }

  it { is_expected.to be_valid }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:current_capacity) }
    it { is_expected.to validate_presence_of(:ride_time) }
  end

  describe '#wait_time' do
    context 'when ride healthy' do
      context 'with queue length is 10' do
        it 'should return 4' do
          expect(subject.wait_time).to eq(4)
        end
      end

      context 'with queue length is 9' do
        let(:queue_length) { 9 }

        it 'should return 2' do
          expect(subject.wait_time).to eq(2)
        end
      end

      context 'with queue length is 11' do
        let(:queue_length) { 11 }

        it 'should return 4' do
          expect(subject.wait_time).to eq(4)
        end
      end
    end

    context 'when ride not healthy' do
      context 'with status malfunction' do
        let(:status) { 'MF' }

        it 'should return infinity' do
          expect(subject.wait_time).to eq('Infinity')
        end
      end

      context 'with status not working' do
        let(:status) { 'NW' }

        it 'should return infinity' do
          expect(subject.wait_time).to eq('Infinity')
        end
      end
    end
  end

  describe '#health_status' do
    context 'when status is H' do
      it 'should return healthy' do
        expect(subject.health_status).to eq('Healthy')
      end
    end

    context 'when status is MF' do
      let(:status) { 'MF' }

      it 'should return malfunction' do
        expect(subject.health_status).to eq('Malfunction')
      end
    end

    context 'when status is NW' do
      let(:status) { 'NW' }

      it 'should return not working' do
        expect(subject.health_status).to eq('Not working')
      end
    end
  end

  describe '#adjust_queue' do
    context 'when operation is in' do
      it 'should increase queue length by 1' do
        current_queue_length = subject.queue_length
        subject.adjust_queue('IN')
        new_queue_length = subject.queue_length
        expect(new_queue_length - current_queue_length).to eq(1)
      end
    end

    context 'when operation is out' do
      context 'when queue length is > 0' do
        it 'should reduce queue length by 1' do
          current_queue_length = subject.queue_length
          subject.adjust_queue('OUT')
          new_queue_length = subject.queue_length
          expect(new_queue_length - current_queue_length).to eq(-1)
        end
      end

      context 'when queue length is 0' do
        let(:queue_length) { 0 }

        it 'should not reduce queue length by 1' do
          current_queue_length = subject.queue_length
          subject.adjust_queue('OUT')
          new_queue_length = subject.queue_length
          expect(new_queue_length - current_queue_length).to eq(0)
        end
      end
    end
  end

  describe '#reset_queue' do
    it 'should reset queue length to 0' do
      expect(subject.queue_length).to eq(10)
      subject.reset_queue
      expect(subject.queue_length).to eq(0)
    end
  end
end
