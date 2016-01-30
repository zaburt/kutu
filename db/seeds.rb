# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

USERS =  JSON.parse(IO.read(Rails.root.join('db', 'seeds', 'users.json')))
HOUSES_AND_GAMES =  JSON.parse(IO.read(Rails.root.join('db', 'seeds', 'houses_and_games.json')))
ARTICLES = JSON.parse(IO.read(Rails.root.join('db', 'seeds', 'articles.json')))
CITIES = ['Istanbul Avrupa', 'Istanbul Anadolu', 'Ankara', 'İzmir']

USERS.each do |email, name, display_name, default_pass|
  User.create(
    :email => email,
    :name => name,
    :display_name => display_name,
    :password => default_pass,
    :password_confirmation => default_pass
  )
end

CITIES.each do |city|
  City.create(:name => city)
end

HOUSES_AND_GAMES.each do |house_name, games|
  house = House.create(:name => house_name)

  games.each do |game|
    Game.create(:name => game, :house_id => house.id)
  end
end

ARTICLES.each do |old_article|
  Article.create(
    :title => old_article['post_title'],
    :publish => true,
    :publish_time => old_article['post_date'],
    :created_at => old_article['post_date'],
    :content => old_article['post_content']
  )
end

