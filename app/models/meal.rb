class Meal < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { only_integer: true, :in => 1..50 }
  validates :meal_type, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  def background_image
    pixabay_api_key = Rails.application.credentials.dig(:pixabay_api_key)
    url = "https://pixabay.com/api/?key=#{pixabay_api_key}&q=#{name}+food&image_type=photo&pretty=true"
    parsed_response = JSON.parse(RestClient.get(url))
    parsed_response["hits"].present? ? parsed_response["hits"][0]["largeImageURL"] : ActionController::Base.helpers.asset_path("anton-8eG73NjiHao-unsplash.jpg")
  end
end
