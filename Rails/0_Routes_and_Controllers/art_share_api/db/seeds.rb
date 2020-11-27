# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all
Comment.destroy_all
Like.destroy_all
ArtworkCollection.destroy_all
Collection.destroy_all


u1 = User.create!(username: 'Potter')
u2 = User.create!(username: 'Gringer')
u3 = User.create!(username: 'Weasley')

a1 = Artwork.create!(title: 'portrait', image_url: 'example.com', artist_id: u1.id, favourite: true)
a2 = Artwork.create!(title: 'landscape', image_url: 'example2.com', artist_id: u2.id)

as1 = ArtworkShare.create!(artwork_id: a1.id, viewer_id: u2.id, favourite: true)
as2 = ArtworkShare.create!(artwork_id: a1.id, viewer_id: u3.id)

c1 = Comment.create!(user_id: u3.id, artwork_id: a1.id, body: 'pretty okay')

l1 = Like.create!(user_id: u2.id, likeable_id: a1.id, likeable_type: 'Artwork')
l2 = Like.create!(user_id: u2.id, likeable_id: c1.id, likeable_type: 'Comment')

cl1 = Collection.create!(user_id: u1.id, name: 'Master piece')
ac1 = ArtworkCollection.create!(collection_id: cl1.id, artwork_id: a1.id)

