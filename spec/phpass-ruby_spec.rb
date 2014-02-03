# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "PhpassRuby" do
  before do
    @ps = Phpass.new
    @correct = 'test12345'
    @wrong = 'test12346'
  end

  it 'should correct' do
    hash = @ps.hash(@correct)
    @ps.check(@correct, hash).should be_true
    known = '$P$9IQRaTwmfeRo7ud9Fh4E2PdI0S3r.L0'
    @ps.check(@correct, known).should be_true
    @ps.check(@wrong, known).should be_false
  end

  it 'should work with international characters' do
    hash = '$P$BqrxgWbGuXvBN11Eip1u1KTdtqcrbe.'
      # took this hash from the PHP implementation:
      #   http://www.openwall.com/phpass/
      #   http://www.openwall.com/phpass/phpass-0.3.tar.gz
    wrong_hash = '$P$B/x0n43EbvnfKB5YOFhetILL0FmhVg1'
    correct = 'piña'
    wrong = 'wrong'
    @ps.check(correct, hash).should be_true
    @ps.check(correct, wrong_hash).should be_false
    @ps.check(wrong, hash).should be_false
  end
end


