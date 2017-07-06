require 'spec_helper'

RSpec.describe TireLibrary::Client do
  let(:resource) { TireLibrary::Client.new(api_key) }
  let(:api_key) { "api_key" }

  describe "on initialize" do
    it "should set the X-API-KEY header with api_key" do
      expect(resource.class.headers["X-API-KEY"]).to eq(api_key)
    end
  end
end
