# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create({
    username: "Minh",
    email: "example@gmail.com",
    password: "gamegame",
    password_confirmation: "gamegame"
})
10.times do |i| 
    friend = User.create({
        username: "Friend_#{i}",
        email: "friend_#{i}@gmail.com",
        password: "gamegame",
        password_confirmation: "gamegame"
    })
    friend.posts.create(content: Faker::Lorem.sentence)
    admin.friendships.create(friend_id: friend.reload.id, pending: false)
end

100.times do |i|
    rando = User.create({
        username: Faker::Name.name,
        email: "random_#{i}@gmail.com",
        password: "gamegame",
        password_confirmation: "gamegame"
    })
    rando.posts.create(content: Faker::Lorem.sentence)
end

