class AvatarUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model}/#{SecureRandom.uuid}"
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end