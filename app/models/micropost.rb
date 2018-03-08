# rails generate model Micropost content:text user:references
# This generated model includes a line indicating that a micropost "belongs_to" a user,
# which is included as a result of the "user:references" argument in above command

class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
