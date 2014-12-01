require 'spec_helper'

describe Attendance do
  before { @attendance = Attendance.new }

  subject { @attendance }

  it { should respond_to(:id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:event_id) }
  it { should respond_to(:present) }
  it { should respond_to(:excused) }
end
