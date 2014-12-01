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

  before do
    @event = Event.new(name: "chapter meeting", date: Time.now,
                              semester: 20142, event_type_id: 1)
  end

  it { should be_valid }

end
