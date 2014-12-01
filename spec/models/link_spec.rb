require 'spec_helper'

describe Link do
  before { @link = Link.new }

  subject { @link }

  it { should respond_to(:name) }
  it { should respond_to(:url) }
  it { should respond_to(:expiration) }

  before { @link = Link.new(name: 'Sign Up') }

  it { should be_valid }
end
