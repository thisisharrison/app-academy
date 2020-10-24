class House < ApplicationRecord
  has_many :gardeners,
    class_name: 'Gardener',
    foreign_key: :house_id,
    primary_key: :id

  has_many :plants,
    through: :gardeners,
    source: :plants

  def n_plus_one_seeds
    plants = self.plants
    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end

    seeds
  end

  def better_seeds_query
    # Create an array of all the seeds within a given house.

    plants = self.plants.includes(:seeds)
    seeds = plants.map { |plant| plant.seeds }
  # House Load (3.2ms)  SELECT  "houses".* FROM "houses" ORDER BY "houses"."id" ASC LIMIT $1  [["LIMIT", 1]]
  # Plant Load (4.5ms)  SELECT "plants".* FROM "plants" INNER JOIN "gardeners" ON "plants"."gardener_id" = "gardeners"."id" WHERE "gardeners"."house_id" = $1  [["house_id", 1]]
  # Seed Load (1.6ms)  SELECT "seeds".* FROM "seeds" WHERE "seeds"."plant_id" IN (1, 2, 3, 4, 5, 6, 7, 8, 9)
  end
end
