RSpec.shared_examples 'gets chomp' do |name_function, *args|
  describe "##{name_function}" do
    context 'with input request' do
      before do
        allow(subject).to receive(:print)
        allow(subject).to receive(:puts)
      end

      it do
        expect(subject).to receive_message_chain(:gets, :chomp)
        subject.public_send(name_function, *args)
      end
    end
  end
end

RSpec.shared_examples 'puts method' do |name_function, *args|
  describe "##{name_function}" do
    it 'output text' do
      expect(subject).to receive(:puts)
      subject.public_send(name_function, *args)
    end
  end
end
