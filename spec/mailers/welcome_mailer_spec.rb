require "rails_helper"

describe WelcomeMailer, type: :mailer do
  
  let(:user){ create(:user) }
  let(:mail){ WelcomeMailer.welcome(user) }

  it 'sends the right subject' do
  	expect(mail.subject).to eql('Welcome to TrevBook!')
  end

  it 'renders the receivers email' do
  	expect(mail.to).to eql([user.email])
  end

  it 'renders the sender email' do
  	expect(mail.from).to eql(['me@trevorelwell.com'])
  end

  it 'displays the users full name' do
  	expect(mail.body.encoded).to match(user.name)
  end

end
