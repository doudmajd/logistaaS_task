class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Model associations
  has_many :books

  # Validations
  validates :name, uniqueness: true

  filterrific(
    default_filter_params: {},
    available_filters: [
      :search_by_name
    ]
  )

  scope :search_by_name, ->(query) {
    where('authors.name LIKE ?', "%#{query}%")
  }
end
