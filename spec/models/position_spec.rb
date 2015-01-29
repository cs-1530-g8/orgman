require 'spec_helper'

describe Position do
  before { @position = Position.new }

  subject { @position }

  it {should respond_to(:name) }
  it {should respond_to(:user_id) }
end
