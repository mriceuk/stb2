class MediaItem < ActiveRecord::Base
  belongs_to :news_item

  has_attachment :storage => :file_system,
                 :max_size => 100.megabytes,
                 :processor => :MiniMagick,
                 :thumbnails => { :thumb => '50x50>' },
                 :resize_to => '400x400'
                 
  validates_as_attachment
  
end