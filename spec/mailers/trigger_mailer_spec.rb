require "rails_helper"

describe TriggerMailer, type: :mailer do


  context 'user with a post comment' do
  	let(:user){ create(:user) }
  	let(:post){ create( :post, :author_id => user.id ) }
  	let(:comment){ build(:comment, :author_id => user.id, :commentable_id => post.id) }
  	let(:mail){ TriggerMailer.new_comment(comment) }

  	before do
  		user.save
  	end


  	it 'sends an email when a user comments on a post' do
  		expect{ comment.save! }.to change {ActionMailer::Base.deliveries.count }.by(1)
	  end


	  it 'has the proper email subject' do
	  	expect(mail.subject).to eql('Someone commented on your post!')
	  end


	  it 'has the right TO address' do
	  	expect(mail.to).to eql([user.email])
	  end


	  it 'has the right FROM address' do
	  	expect(mail.from).to eql(['me@trevorelwell.com'])
	  end


	  it 'has the proper content' do
			expect(mail.body.encoded).to match(user.name)
	  end


  end


  context 'user with a photo comment' do
  	let(:user){ create(:user) }
  	let(:photo){ create( :photo, :user_id => user.id ) }
  	let(:comment){ build(:photo_comment, :author_id => user.id, :commentable_id => photo.id) }
  	let(:mail){ TriggerMailer.new_comment(comment) }

  	before do
  		user.save
  	end

  	# TODO: This is super strange. The POST above has the commentable association working
  	# properly but this photo doesn't find it- it returns nil. Why is this happening? It's causing
  	# These two tests to fail. The error stems from trigger_mailer.rb where @user is being set.
  	# ANSWER: I didn't setup my photo_comment factory properly. 
		it 'sends an email when a user comments on a photo' do
  		expect{ comment.save! }.to change {ActionMailer::Base.deliveries.count }.by(1)
	  end


	  it 'has the proper email subject' do
	  	expect(mail.subject).to eql('Someone commented on your photo!')
	  end


  end


end