class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  belongs_to :subject
  has_many :users, through: :favorites
end
