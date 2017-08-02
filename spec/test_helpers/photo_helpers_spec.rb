def most_recent_photo
  Photo.order("created_at").last
end

def upload_file(file_name = 'test_image.png')
  Rack::Test::UploadedFile.new(File.open(File.join(Rails.root,
  'spec', 'support', 'images', file_name)))
end
