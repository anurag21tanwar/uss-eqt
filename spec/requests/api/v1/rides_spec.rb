# frozen_string_literal: true

require 'rails_helper'

describe V1::Rides, type: :request do
  describe 'GET /api/v1/rides' do
    let(:path) do
      '/api/v1/rides'
    end

    context 'positive case' do
      it 'response code' do
        get path
        expect(response.code).to eq('200')
      end

      context 'response body' do
        it 'should return correct response body' do
          ride = create(:ride)
          get path
          expected = {
            status: 'ok',
            rides: [{ id: ride.id,
                      name: ride.name,
                      capacity: ride.current_capacity,
                      ride_time: ride.ride_time,
                      wait_time: ride.wait_time,
                      queue_length: ride.queue_length,
                      status: ride.health_status }]
          }.to_json
          expect(response.body).to eq(expected)
        end
      end
    end
  end

  describe 'POST /api/v1/rides' do
    let(:path) do
      '/api/v1/rides?name=Transformer&current_capacity=10&ride_time=2'
    end

    context 'positive case' do
      it 'should be successful' do
        post path
        expect(response.code).to eq('201')
      end

      context 'response body' do
        it 'should return correct response body' do
          post path
          expected = {
            status: 'ok',
            message: 'ride successfully created'
          }.to_json
          expect(response.body).to eq(expected)
        end
      end
    end

    context 'negative case' do
      let(:path) do
        '/api/v1/rides'
      end

      context 'when missing required params' do
        it 'should be bad request' do
          post path
          expect(response.code).to eq('400')
        end

        context 'response body' do
          it 'should return error response body' do
            post path
            expected = {
              status: 'bad_request',
              error_message: 'name is missing, current_capacity is missing, ride_time is missing'
            }.to_json
            expect(response.body).to eq(expected)
          end
        end
      end
    end
  end

  describe 'PATCH /api/v1/rides/{:id}' do
    let(:ride) { create(:ride) }
    let(:path) do
      "/api/v1/rides/#{ride.id}?current_capacity=10&status=MF"
    end

    context 'positive case' do
      it 'should be successful' do
        patch path
        expect(response.code).to eq('200')
      end

      context 'response body' do
        it 'should return correct response body' do
          patch path
          expected = {
            status: 'ok',
            message: 'ride successfully patched'
          }.to_json
          expect(response.body).to eq(expected)
        end
      end
    end

    context 'negative case' do
      let(:path) do
        "/api/v1/rides/#{ride.id}"
      end

      context 'when missing required params' do
        it 'should be bad request' do
          patch path
          expect(response.code).to eq('400')
        end

        context 'response body' do
          it 'should return error response body' do
            patch path
            expected = {
              status: 'bad_request',
              error_message: 'current_capacity is missing, status is missing, status does not have a valid value'
            }.to_json
            expect(response.body).to eq(expected)
          end
        end
      end
    end
  end

  describe 'DELETE /api/v1/rides/{:id}' do
    let(:ride) { create(:ride) }
    let(:path) do
      "/api/v1/rides/#{ride.id}"
    end

    context 'positive case' do
      it 'should be successful' do
        delete path
        expect(response.code).to eq('200')
      end

      context 'response body' do
        it 'should return correct response body' do
          delete path
          expected = {
            status: 'ok',
            message: 'ride successfully deleted'
          }.to_json
          expect(response.body).to eq(expected)
          expect { Ride.find(ride.id) }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'negative case' do
      let(:path) do
        '/api/v1/rides/100'
      end

      context 'when missing or already deleted ride object' do
        it 'should be internal server error' do
          delete path
          expect(response.code).to eq('500')
        end

        context 'response body' do
          it 'should return correct response body' do
            delete path
            expected = {
              status: 'internal_server_error',
              error_message: "Couldn't find Ride with 'id'=100"
            }.to_json
            expect(response.body).to eq(expected)
          end
        end
      end
    end
  end

  describe 'PATCH /api/v1/rides/{:id}/in' do
    let(:ride) { create(:ride) }
    let(:path) do
      "/api/v1/rides/#{ride.id}/in"
    end

    context 'positive case' do
      it 'should be successful' do
        patch path
        expect(response.code).to eq('200')
      end

      context 'response body' do
        it 'should return correct response body' do
          patch path
          expected = {
            status: 'ok',
            message: 'adjustment of ride queue length successfully completed'
          }.to_json
          expect(response.body).to eq(expected)
        end
      end
    end

    context 'negative case' do
      let(:path) do
        '/api/v1/rides/100/in'
      end

      context 'when missing required params' do
        it 'should be internal server error' do
          patch path
          expect(response.code).to eq('500')
        end

        context 'response body' do
          it 'should return error response body' do
            patch path
            expected = {
              status: 'internal_server_error',
              error_message: "Couldn't find Ride with 'id'=100"
            }.to_json
            expect(response.body).to eq(expected)
          end
        end
      end
    end
  end

  describe 'PATCH /api/v1/rides/{:id}/out' do
    let(:ride) { create(:ride) }
    let(:path) do
      "/api/v1/rides/#{ride.id}/out"
    end

    context 'positive case' do
      it 'should be successful' do
        patch path
        expect(response.code).to eq('200')
      end

      context 'response body' do
        it 'should return correct response body' do
          patch path
          expected = {
            status: 'ok',
            message: 'adjustment of ride queue length successfully completed'
          }.to_json
          expect(response.body).to eq(expected)
        end
      end
    end

    context 'negative case' do
      let(:path) do
        '/api/v1/rides/100/out'
      end

      context 'when missing required params' do
        it 'should be internal server error' do
          patch path
          expect(response.code).to eq('500')
        end

        context 'response body' do
          it 'should return error response body' do
            patch path
            expected = {
              status: 'internal_server_error',
              error_message: "Couldn't find Ride with 'id'=100"
            }.to_json
            expect(response.body).to eq(expected)
          end
        end
      end
    end
  end

  describe 'PATCH /api/v1/rides/{:id}/reset' do
    let(:ride) { create(:ride) }
    let(:path) do
      "/api/v1/rides/#{ride.id}/reset"
    end

    context 'positive case' do
      it 'should be successful' do
        patch path
        expect(response.code).to eq('200')
      end

      context 'response body' do
        it 'should return correct response body' do
          patch path
          expected = {
            status: 'ok',
            message: 'reset of ride queue count successfully completed'
          }.to_json
          expect(response.body).to eq(expected)
        end
      end
    end

    context 'negative case' do
      let(:path) do
        '/api/v1/rides/100/reset'
      end

      context 'when missing required params' do
        it 'should be internal server error' do
          patch path
          expect(response.code).to eq('500')
        end

        context 'response body' do
          it 'should return error response body' do
            patch path
            expected = {
              status: 'internal_server_error',
              error_message: "Couldn't find Ride with 'id'=100"
            }.to_json
            expect(response.body).to eq(expected)
          end
        end
      end
    end
  end
end
