require 'spec_helper'

RSpec.describe TireLibrary do
  it 'has a version number' do
    expect(TireLibrary::VERSION).not_to be nil
  end
end
