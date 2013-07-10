namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_posts
    make_relationships
    make_private_messages
    make_recipes
    make_ingredients
  end
end

def make_users
  admin = User.create!(name: "Claudia",  #imposto chi è l'admin
                       surname: "Bertone",
                       email: "claudia@polito.it",
                       password: "claudia",
                       password_confirmation: "claudia",
                      age: "22")
  admin.toggle!(:admin)    #toggle! method to flip the admin attribute from false to true. Così tutti gli altri che vengono creati non saranno admin

  99.times do |n|   #per 99 volte crea falsi profili
    name  = Faker::Name.last_name
    surname= Faker::Name.last_name
    # take users from the Rails Tutorial book since most of them have a "real" profile pic
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    age =rand(max=70)
    User.create!(name: name,
                 surname: surname,
                 email: email,
                 password: password,
                 password_confirmation: password,
                  age: age)
  end
end

def make_posts
  # generate 50 fake posts for the first 10 users
  users = User.all(limit: 10)
  50.times do
    post_content = Faker::Lorem.sentence(8)
    users.each { |user| user.posts.create!(content: post_content )}
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  # first user follows user 3 up to 51
  followed_users.each { |followed| user.follow!(followed) }
  # users 4 up to 41 follow back the first user
  followers.each { |follower| follower.follow!(user) }
end

def make_private_messages
  # generate 10 fake messages for the first user
  first_user = User.first
  users = User.all
  message_from_users = users[3..12]
  message_from_users.each do |user|
    msg_body = Faker::Lorem.sentence(8)
    msg_subject = Faker::Lorem.sentence(3)
    message = Message.new
    message.sender = user
    message.recipient = first_user
    message.subject = msg_subject
    message.body = msg_body
    message.save!
  end
end


def make_recipes
  # generate 50 fake recipes for the first 10 users
  users = User.all
  1.times do |n|
    recipe_name =  Faker::Lorem.sentence(1)
    piatto = [:antipasto, :primo, :secondo, :dolce, :altro].sample
    cucina = [:araba, :cinese, :italiana, :messicana, :altro].sample
    vegetariana=[:true, :false].sample
    vegana=[:true, :false].sample
    latticini=[:true, :false].sample
    glutine=[:true, :false].sample

    descrizione = Faker::Lorem.sentence(8)
    users.each { |user| user.recipes.create!(name: recipe_name, piatto: piatto, cucina:cucina, vegetariana:vegetariana, vegana:vegana, latticini:latticini, glutine:glutine, descrizione:descrizione)}
    end
end

def make_ingredients
  # generate 50 fake recipes for the first 10 users
  recipes = Recipe.all
  1.times do |n|
    ingrediente= Faker::Lorem.sentence(1)
    quantit= Random.rand(1...15)
    tipoquantit=[:grammi, :numero].sample



    recipes.each { |recipes| recipes.ingredients.create!(ingrediente: ingrediente, quantit: quantit, tipoquantit:tipoquantit)}

  end
end



