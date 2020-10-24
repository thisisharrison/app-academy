# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
    SELECT
      COUNT(*)
    FROM
      stops;
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    SELECT
      id
    FROM
      stops
    WHERE
      name = 'Craiglockhart';
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    SELECT
      routes.stop_id,
      stops.name
    FROM
      routes
    JOIN
      stops ON routes.stop_id = stops.id
    WHERE
      routes.company = 'LRT' AND routes.num = '4'
  SQL
end

def connecting_routes
  # Consider the following query:
  #
  # SELECT
  #   company,
  #   num,
  #   COUNT(*)
  # FROM
  #   routes
  # WHERE
  #   stop_id = 149 OR stop_id = 53
  # GROUP BY
  #   company, num
  #
  # The query gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
    SELECT
      company,
      num,
      COUNT(*)
    FROM
      routes
    WHERE
      stop_id = 149 OR stop_id = 53
    GROUP BY
      company, num
    HAVING
      COUNT(*) = 2;
  SQL
end

def cl_to_lr
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   a.stop_id,
  #   b.stop_id
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # WHERE
  #   a.stop_id = 53
  #
  # Observe that b.stop_id gives all the places you can get to from
  # Craiglockhart, without changing routes. Change the query so that it
  # shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
    SELECT
      a.company,
      a.num,
      a.stop_id,
      b.stop_id
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    WHERE
      a.stop_id = 53 AND b.stop_id = 149;
  SQL
end

def cl_to_lr_by_name
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   stopa.name,
  #   stopb.name
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # JOIN
  #   stops stopa ON (a.stop_id = stopa.id)
  # JOIN
  #   stops stopb ON (b.stop_id = stopb.id)
  # WHERE
  #   stopa.name = 'Craiglockhart'
  #
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown.
  execute(<<-SQL)
    SELECT
      a.company,
      a.num,
      stopa.name,
      stopb.name
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
      stops stopa ON (a.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
    WHERE
      stopa.name = 'Craiglockhart' AND stopb.name = 'London Road';
  SQL
end

def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
    SELECT DISTINCT
      start_routes.company,
      start_routes.num
    FROM
      routes AS start_routes
    JOIN
      routes AS destination_routes ON start_routes.company = destination_routes.company AND start_routes.num = destination_routes.num
    WHERE
      start_routes.stop_id = 115 AND destination_routes.stop_id = 137;
  SQL
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
    SELECT
      start.company,
      start.num
    FROM
      routes AS start
    JOIN
      routes AS stop ON (start.company = stop.company AND start.num = stop.num)
    JOIN 
      stops AS start_stops ON start.stop_id = start_stops.id
    JOIN
      stops AS destination_stops ON stop.stop_id = destination_stops.id
    WHERE
      start_stops.name = 'Craiglockhart'
      AND
      destination_stops.name = 'Tollcross';
      
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
    SELECT
      end_routes_stops.name AS destination_name,
      end_routes.company,
      end_routes.num
    FROM
      routes AS start_routes
    JOIN
      routes AS end_routes ON start_routes.num = end_routes.num AND start_routes.company = end_routes.company
    JOIN
      stops AS end_routes_stops ON end_routes.stop_id = end_routes_stops.id
    JOIN
      stops AS start_routes_stops ON start_routes.stop_id = start_routes_stops.id
    WHERE
      start_routes_stops.name = 'Craiglockhart';

  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
    SELECT DISTINCT
      start_routes.num AS starting_bus,
      start_routes.company AS starting_bus_co,
      transfer_stops.name AS transfer_stop,
      end_routes.num AS last_bus,
      end_routes.company AS last_bus_co
    FROM
      routes AS start_routes
    JOIN
      routes AS to_transfer_routes ON to_transfer_routes.num = start_routes.num AND to_transfer_routes.company = start_routes.company
    JOIN
      stops AS transfer_stops ON transfer_stops.id = to_transfer_routes.stop_id
    JOIN
      routes AS from_transfer_routes ON transfer_stops.id = from_transfer_routes.stop_id
    JOIN
      routes AS end_routes ON end_routes.num = from_transfer_routes.num AND end_routes.company = from_transfer_routes.company
    WHERE 
      start_routes.stop_id IN (
        SELECT
          id
        FROM
          stops
        WHERE
          name = 'Craiglockhart'
      ) AND 
      end_routes.stop_id IN (
        SELECT
          id
        FROM
          stops
        WHERE
          name = 'Sighthill'
      );
  SQL
end