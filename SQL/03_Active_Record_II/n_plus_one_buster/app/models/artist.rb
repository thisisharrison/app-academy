class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # Count all of the tracks on each album by a given artist.
    albums = self.albums.select('albums.id, albums.title, COUNT(*) as tracks_count').joins(:tracks).group('albums.id')

    result = {}
    albums.each do |album|
      result[album.title] = album.tracks_count
    end

    result

    # Hits DB 2 times
    # Artist Load (0.3ms)  SELECT  "artists".* FROM "artists" ORDER BY "artists"."id" ASC LIMIT $1  [["LIMIT", 1]]
    # Album Load (4.7ms)  SELECT albums.id, albums.title, COUNT(*) as tracks_count FROM "albums" INNER JOIN "tracks" ON "tracks"."album_id" = "albums"."id" WHERE "albums"."artist_id" = $1 GROUP BY albums.id  [["artist_id", 1]]

    # Hits DB 3 times (Artist, Album, Tracks)
    # albums = self.albums.includes(:tracks)
    # tracks_count = {}
    # albums.each do |album|
    #   tracks_count[album.title] = album.tracks.length
    # end
  end
end
