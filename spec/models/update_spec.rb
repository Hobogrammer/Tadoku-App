require 'spec_helper'

describe Update do
  let(:user) { FactoryGirl.create(:user) }
  before { @update = user.updates.build(round_id: "201202",  newread: 10, medium: "book", lang: "jp", recpage: 0) }

  subject { @update }

  it { should respond_to(:user_id) }
  it { should respond_to(:round_id) }
  it { should respond_to(:newread) }
  it { should respond_to(:medium) }
  it { should respond_to(:lang) }
  it { should respond_to(:recpage) }

  its(:user) { should == user }
end
