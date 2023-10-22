class Book < ApplicationRecord
  # Model associations
  belongs_to :author

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :release_date, presence: true
  validate :release_date_cannot_be_in_future

  def release_date_cannot_be_in_future
    if release_date.present? && release_date > Date.today
      errors.add(:release_date, "can't be in the future")
    end
  end

  filterrific(
    default_filter_params: {},
    available_filters: [
      :search_by_name,
      :filter_by_release_date,
      :filter_by_author_name
    ]
  )

  scope :search_by_name, ->(query) {
    where('name LIKE ?', "%#{query}%")
  }

  scope :filter_by_release_date, ->(date) {
    where('release_date <= ?', date)
  }

  scope :filter_by_author_name, ->(author_name) {
    joins(:author).where('authors.name LIKE ?', "%#{author_name}%")
  }
end
