class Picture < ActiveRecord::Base
  belongs_to :game

  has_attached_file :image,
    styles: {
      medium: '300x300>',
      thumb: '100x100>'
    },
    # url: '/media/:class/:attachment/:id_partition/:style/:filename',
    default_url: '/images/:style/missing.png'

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  # validates_attachment_content_type :image, content_type: /\Aimage/
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i, /gif\Z/i]

end

