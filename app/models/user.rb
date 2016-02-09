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

  def cart_total_price
  	total_price = 0
  	get_cart_movies.each {|movie| total_price += movie.price}
  	total_price
  end

end
