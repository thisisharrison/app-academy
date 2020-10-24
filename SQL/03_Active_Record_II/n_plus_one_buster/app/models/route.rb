class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    #  Create a hash with bus id's as keys and an array of bus drivers as the corresponding value.
    # (e.g., {'1' => ['Joan Lee', 'Charlie McDonald', 'Kevin Quashie'], '2' => ['Ed Michaels', 'Lisa Frank', 'Sharla Alegria']})
    
    # METHOD #1
    buses = self.buses.select('buses.id AS id, drivers.name AS driver').joins(:drivers)
    
    result = {}
    buses.each do |bus|
      if result[bus.id]
        result[bus.id] << bus.driver 
      else
        result[bus.id] = [bus.driver]
      end
    end

    result

    # METHOD #2
    # buses = self.buses.includes(:drivers)

    # all_drivers = {}

    # buses.each do |bus|
    #   names = bus.drivers.map(&:name)
    #   all_drivers[bus.id] = names
    # end

    # all_drivers


  end
  # Method 1: Hit DB 2x
  # Route Load (0.2ms)  SELECT  "routes".* FROM "routes" ORDER BY "routes"."id" ASC LIMIT $1  [["LIMIT", 1]]
  # Bus Load (0.9ms)  SELECT buses.id AS id, drivers.name AS driver FROM "buses" INNER JOIN "drivers" ON "drivers"."bus_id" = "buses"."id" WHERE "buses"."route_id" = $1  [["route_id", 1]]

  # Method 2: Hit DB 3x
  # Route Load (0.4ms)  SELECT  "routes".* FROM "routes" ORDER BY "routes"."id" ASC LIMIT $1  [["LIMIT", 1]]
  # Bus Load (0.5ms)  SELECT "buses".* FROM "buses" WHERE "buses"."route_id" = $1  [["route_id", 1]]
  # Driver Load (0.5ms)  SELECT "drivers".* FROM "drivers" WHERE "drivers"."bus_id" IN (1, 2, 3, 4, 5)

end
