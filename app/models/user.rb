class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :purchases, foreign_key: :buyer_id
  has_many :movies, through: :purchases
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def cart_count
  	$redis.scard "cart#{id}"
  end
end
