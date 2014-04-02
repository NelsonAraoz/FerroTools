class Picture < ActiveRecord::Base
	belongs_to :product
has_attached_file :picture,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_options => {:path =>proc { |style| "Pictures/#{product_id}/#{id}/#{picture.original_filename}" } , :unique_filename => true}
validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
end
