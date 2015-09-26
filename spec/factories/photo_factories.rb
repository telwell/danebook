include ActionDispatch::TestProcess

FactoryGirl.define do
  
  factory :photo do
     photo { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'default-avatar.jpg'), 'image/jpg') }
  end

end
