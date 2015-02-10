require 'spec_helper'

describe Event do
  before { @event = Event.new }

  subject { @event }

  it { should respond_to(:name) }
  it { should respond_to(:date) }
  it { should respond_to(:fine) }
  it { should respond_to(:self_submit_excuse) }
  it { should respond_to(:self_submit_attendance) }
  it { should respond_to(:semester) }
  it { should respond_to(:event_type_id) }

  it 'with all required fields' do
    event = Event.new(name: 'event', semester: 20141, event_type_id: 1,
                       date: Date.today)
    expect(event).to be_valid
  end

  it 'without name' do
    event = Event.new(semester: 20141, event_type_id: 1, date: Date.today)
    expect(event).to be_invalid
  end

  it 'without semester' do
    event = Event.new(name: 'event', event_type_id: 1, date: Date.today)
    expect(event).to be_invalid
  end

  it 'without name' do
    event = Event.new(semester: 20141, event_type_id: 1, date: Date.today)
    expect(event).to be_invalid
  end
end
