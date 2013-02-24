require 'spec_helper'

describe Post do
  before do
    I18n.available_locales = [ :de, :en, :es ]
    I18n.default_locale = :en
    I18n.locale = :en
  end

  describe '#body' do
    it { should respond_to(:body) }

    describe 'localization' do
      before do
        I18n.locale = :en
        @post = Post.new(:body => 'This is the english post body!')
      end # before

      it 'should return the correct value for english locale' do
        @post.body.should eq(@post.body_en)
      end # it

      it 'should return the correct value for spanish locale' do
        I18n.locale = :es
        @post.body.should eq(@post.body_es)
      end # it
    end # describe 'localization'
  end # describe '#body'

  describe '#body=' do
    it { should respond_to(:body=) }
  end # describe '#body='

  describe 'validations' do
    it { should validate_presence_of :body_en }
    it { should validate_presence_of :body_de }
  end # describe 'validations'
end # describe

