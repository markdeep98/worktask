class Micropost < ApplicationRecord
  belongs_to :user 
  default_scope -> { order(created_at: :desc) } #отображение в хронологичном порядке
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 150}
end
