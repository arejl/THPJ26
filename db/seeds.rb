require "faker"

print "Destruction des données existantes..."
User.destroy_all
print "."
Gossip.destroy_all
print "."
City.destroy_all
print "."
PrivateMessage.destroy_all
print "."
Comment.destroy_all
print "."
Tag.destroy_all
print "."
Like.destroy_all
puts "."
puts "Données existantes détruites"

print "Création de nouvelles données..."

10.times do
  City.create!(
    city_name: Faker::Address.city.downcase,
    zip_code: Faker::Address.zip_code,
  )
end

print "."

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::TvShows::RuPaul.quote,
    email: Faker::Internet.free_email,
    age: rand(15..80),
    city_id: City.all.sample.id,
    password: Faker::Lorem.characters(number: 10)
  )
end

print "."

5.times do
  #Le message est créé avec un expéditeur et un contenu.
  new_message = PrivateMessage.create!(
    content: Faker::Quote.yoda,
    sender_id: User.all.sample.id,
  )
  #On rajoute des destinataires, entre 1 et 5.
  new_message.recipients << User.all.sample(rand(1..5))
end

print "."

10.times do
  Tag.create!(
    title: Faker::Hipster.word,
  )
end

print "."

20.times do
  new_gossip = Gossip.create!(
    title: Faker::Lorem.characters(number: 10),
    content: Faker::Lorem.paragraph(sentence_count: 30),
    user_id: User.all.sample.id,
  )
  new_gossip.tags << Tag.all.sample(rand(1..5))
end

print "."

20.times do
  new_comment = Comment.create!(
    content: Faker::ChuckNorris.fact,
    gossip_id: Gossip.all.sample.id,
    user_id: User.all.sample.id,
  )
  #Ajout des commentaires de commentaires
  rand(0..5).times do
    new_comment.comments << Comment.create!(
      content: Faker::Quotes::Chiquito.sentence,
      user_id: User.all.sample.id,
    )
  end
end

print "."

20.times do
  liking_user = User.all.sample.id
  #Le like est aléatoirement placé soit sur un gossip, soit sur un commentaire.
  is_like = rand(0..1)
  if is_like == 0
    Like.create!(
      user_id: liking_user,
      gossip_id: Gossip.all.sample.id,
    )
  else
    Like.create!(
      user_id: liking_user,
      comment_id: Comment.all.sample.id,
    )
  end
end

puts "."

puts "Création d'un utilisateur test en cours"

User.create!(
  first_name: "anonymous",
  last_name: "user",
  description: "Cet utilisateur est anonyme",
  email: "test@test.com",
  age: rand(15..80),
  city_id: City.all.sample.id,
  password:"motdepasse"
)

puts "Seed terminé :)"
