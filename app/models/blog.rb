class Blog < ApplicationRecord
    validates :title, presence: true
    validates :title, length: { minimum: 3 } 
    validates :title, length: { maximum: 30 }
    validates :title, uniqueness: true
    validates :content, presence: true
    has_many :comments
end
