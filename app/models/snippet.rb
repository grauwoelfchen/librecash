class Snippet < ActiveRecord::Base
  include PublicActivity::Model
  include Orderable
  include HtmlConvertable

  acts_as_taggable
  tracked owner:          ->(controller, _) { controller.send(:current_user) },
          trackable_name: ->(_, model) { model.title }
  paginates_per 6
  orderable :title, :updated_at
  html_convertable :content

  validates :title,
    presence:   true,
    uniqueness: true,
    length:     {maximum: 192}
  validates :content,
    length: {maximum: 1024 * 4}
end
