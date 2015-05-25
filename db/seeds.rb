require 'faker'

# Create Users
# call User.new instead of create so that I can run
# skip_confirmation! before saving.
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Posts
50.times do
  Post.create!(
    user:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
 )
end
posts = Post.all

# Create Comments
100.times do
  Comment.create!(
    # user: users.sample,   # we have not yet associated Users with Comments
    post: posts.sample,
    body: Faker::Lorem.paragraph
 )
end

# creates a testable user
user = User.first
user.skip_reconfirmation!
user.update_attributes!(
  name: 'Brendan',
  email: 'bmcg0707@hotmail.com',
  password: 'Arnytest07!'
 )

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"