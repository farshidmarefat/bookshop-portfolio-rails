class BlogPostTag < ApplicationRecord
  belongs_to :blog_post
  belongs_to :blog_tag
end
