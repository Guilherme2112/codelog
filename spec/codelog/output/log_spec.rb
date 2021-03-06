require 'spec_helper'

describe Codelog::Output::Log do
  let(:content) { 'test' }
  let(:mocked_stdout) { double }

  describe '#print' do
    subject { described_class.new.print(content) }
    before(:each) do
      allow(IO).to receive(:popen).and_yield(mocked_stdout)
      allow(mocked_stdout).to receive(:puts)
    end

    it 'prints the passed content the console' do
      subject

      expect(IO).to have_received(:popen).with('less', 'w')
      expect(mocked_stdout).to have_received(:puts).with(content)
    end
  end

  describe '.print' do
    subject { described_class.print(content) }
    it 'creates an instance of the class to run the command' do
      expect_any_instance_of(described_class).to receive(:print).with 'test'
      described_class.print 'test'
    end
  end
end
