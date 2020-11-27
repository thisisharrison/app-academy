require 'action_view'

class Cat < ApplicationRecord 
    include ActionView::Helpers::DateHelper

    # #freeze renders a constant immutable 
    CAT_COLORS = %w(black white brown purple grey orange).freeze

    validates :name, :sex, :color, :birth_date, presence: true
    validates :sex, inclusion: { in: %w(M F), message: "%{value} is not a valid gender" }
    validates :color, inclusion: { in: CAT_COLORS, message: "%{value} is not a valid color" }

    has_many :cat_rental_requests, dependent: :destroy

    def age
        time_ago_in_words(birth_date)
    end
end
