require 'spec_helper'

describe EventType do
  before { @event_type = EventType.new }

  subject { @event_type }

  it { should respond_to(:name) }
  it { should respond_to(:points_required) }
  it { should respond_to(:percentage_attendance_required) }

  before { @event_type = EventType.new(name: 'Miscellaneous') }

  describe 'name only' do
    it { should be_valid }
  end

  describe 'points only' do
    before { @event_type.points_required = 5 }
    it { should be_valid }
  end

  describe 'percentage only' do
    before { @event_type.percentage_attendance_required = 5 }
    it { should be_valid }
  end

  describe 'both points and percentage' do
    before do
      @event_type.percentage_attendance_required = 5
      @event_type.points_required = 5
    end
    it { should_not be_valid }
  end

  describe 'improperly formatted points points required' do
    before { @event_type.points_required = 'abc' }
    it { should_not be_valid }
  end

  describe 'improperly formatted percentage attendance required ' do
    before { @event_type.percentage_attendance_required = 'abc' }
    it { should_not be_valid }
  end

  describe 'points less than zero' do
    before { @event_type.points_required = -1 }
    it { should_not be_valid }
  end

  describe 'percentage attendance required  less than zero' do
    before { @event_type.percentage_attendance_required = -1 }
    it { should_not be_valid }
  end

  describe 'percentage attendance required less than zero' do
    before { @event_type.percentage_attendance_required = -1 }
    it { should_not be_valid }
  end

  describe 'percentage attendance required greater than 100' do
    before { @event_type.percentage_attendance_required = 101 }
    it { should_not be_valid }
  end
end
