class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :exercises
  
  validates :first_name, presence: true
  validates :last_name, presence: true

  self.per_page = 10

  def full_name
    [first_name, last_name].join(' ')
  end

  def self.search_by_name(name)
    names_array = name.split(' ')
    names_array.map! { |x| x.downcase }
    if names_array.size == 1
      where('lower(first_name) LIKE ? or lower(last_name) LIKE ?',
        "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
    else
      where('lower(first_name) LIKE ? or lower(first_name) LIKE ? or lower(last_name) LIKE ?
        or lower(last_name) LIKE ?', "%#{names_array[0]}%",
        "%#{names_array[1]}%", "%#{names_array[0]}%",
        "%#{names_array[1]}%").order(:first_name)
    end
  end
end
