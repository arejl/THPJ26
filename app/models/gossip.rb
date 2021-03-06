class Gossip < ApplicationRecord
  belongs_to :user
  has_many :join_table_gossip_tags
  has_many :tags, through: :join_table_gossip_tags
  has_many :likes
  has_many :comments
  validates :title,
    presence: true,
    length: { minimum: 2, maximum: 14 }
  validates :content,
  presence: true,
  length: { maximum: 750 }
end
