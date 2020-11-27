module Toyable
    extend ActiveSupport::Concern

    included do 
        has_many :toys, as: :toyable
    end

    def receive_toy(name)
        begin
            self.toys.find_or_create_by(name: name)
        rescue ActiveRecord::RecordNotUnique
            retry
        end
    end
end