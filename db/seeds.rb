require 'faker'

# create a unique post
post_atrributes = [
  { title: "TEST POST", body: "This is the body for TEST POST" }
]

post_atrributes.each do |attributes|
  Post.where(attributes).first_or_create
end

# create a unique comment
comment_atrributes = [
  { post: "TEST POST - COMMENT", body: "This is a TEST comment" }
]

comment_atrributes.each do |attributes|
  Comment.where(attributes).first_or_create
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"