def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie.select(:title, :id)
    .joins(:actors)
    .where(actors: {name: those_actors})
    .group(:id)
    .having('COUNT(actors.id) >= ?', those_actors.length)
  
  # Last line making sure that all actors in "those_actors" were part of the movie
end

def golden_age
  # Find the decade with the highest average movie score.
  
  Movie.select('(yr / 10) * 10 AS decade, AVG(score) AS avg')
    .group('decade')
    .order('AVG(score) DESC')
    .first
    .decade
  # calls the new column names (decade or avg) in the last line

  # How do you do decade??
  # SELECT (yr / 10) * 10 AS decade, AVG(score)
  # FROM movies
  # GROUP BY decade
  # ORDER BY AVG(score)
  # LIMIT 1;
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery

  Actor
    .joins(:movies)
    .where(movies: {id: 
      Movie.select(:id)
        .joins(:actors)
        .where(actors: {name: name})
      })
    .where.not(actors: {name: name})
    .distinct
    .pluck(:name)

  # SELECT actors.name
  # FROM actors
  # JOIN castings ON actors.id = castings.actor_id
  # WHERE movie_id IN (
  #   SELECT movies.id
  #   FROM movies
  #   JOIN castings ON movies.id = castings.movie_id
  #   WHERE actor_id = 1
  # ) AND 
  # NOT actor_id = 1;
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .joins('LEFT OUTER JOIN castings ON castings.actor_id = actors.id')
    .where(castings: {movie_id: nil})
    .count

end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"

  alike = whazzername.split('').join('%')
  matcher = "%#{alike}%"

  # %w%h%a%z%z%e%r%n%a%m%

  Movie.joins(:actors)
    .where('UPPER(actors.name) LIKE UPPER(?)', matcher)

  # SELECT actors.name
  # FROM actors
  # WHERE LOWER(actors.name) LIKE '%w%h%a%z%z%e%r%n%a%m%';

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.

  Actor.select('actors.id, actors.name, MAX(movies.yr) - MIN(movies.yr) as career')
    .joins(:movies)
    .group('actors.id')
    .order('career DESC, actors.name')
    .limit(3)
end
