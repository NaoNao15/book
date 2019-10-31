class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :stockposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :picture, presence: true
  validate  :picture_size

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  def stock_user(user_id)
    stockposts.find_by(user_id: user_id)
  end

  def self.like_trend_sql
    joins("left join likes on posts.id = likes.post_id")
    .group("posts.id").order(Arel.sql("count(likes.id) desc"))
  end

  def self.stock_trend_sql
    joins("left join stockposts on posts.id = stockposts.post_id").group("posts.id").order(Arel.sql("count(stockposts.id) desc"))
  end

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
