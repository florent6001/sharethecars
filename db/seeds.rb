require 'faker'
require 'open-uri'
require 'csv'

Feedback.destroy_all
Reservation.destroy_all
Car.destroy_all
Company.destroy_all
User.destroy_all

2.times do
  company = Company.create!(
    name: Faker::Company.name,
    address: Faker::Address.street_address
  )
  Chatroom.create(name: company.name, company: company)
end
companies = Company.all

cars_url = [
  "https://fr.wikipedia.org/wiki/Peugeot_3008_II",
  "https://fr.wikipedia.org/wiki/Peugeot_307",
  "https://fr.wikipedia.org/wiki/Renault_M%C3%A9gane",
  "https://fr.wikipedia.org/wiki/Renault_Zoe",
  "https://fr.wikipedia.org/wiki/Renault_Zoe",
  "https://fr.wikipedia.org/wiki/Renault_Clio_IV",
  "https://fr.wikipedia.org/wiki/Renault_Clio_IV",
  "https://fr.wikipedia.org/wiki/Renault_Clio_III",
  "https://fr.wikipedia.org/wiki/Renault_Clio_V",
  "https://fr.wikipedia.org/wiki/Renault_Twingo_III",
  "https://fr.wikipedia.org/wiki/Renault_Twingo_II",
  "https://fr.wikipedia.org/wiki/Peugeot_208_II",
  "https://fr.wikipedia.org/wiki/Peugeot_308_III",
  "https://fr.wikipedia.org/wiki/Peugeot_208_II"
]

cars_url.each do |url|
  html = URI.open(url)
  doc = Nokogiri::HTML.parse(html)
  colors = ["rouge", "vert", "bleu", "jaune", "noir", "blanc"]
  letters = ('A'..'Z').to_a.sample(2).join('')
  numbers = rand(100..999)
  letters2 = ('A'..'Z').to_a.sample(2).join('')

  car = Car.new(
    model: doc.search('.mw-page-title-main').text,
    color: colors.sample,
    plate_number: "#{letters}-#{numbers}-#{letters2}",
    company: companies.sample,
    kilometers: rand(10_000..50_000)
  )

  image_url = "https:#{doc.search('table span a img').attr('src').value}"
  image_resized = image_url.gsub("280px", "700px")
  image = URI.open(image_resized)
  car.photo.attach(io: image, filename: "#{car.model}.jpg")

  car.save
end
require 'uri'

companies = Company.all
cars = Car.all

25.times do |i|
  image = URI.open("https://i.pravatar.cc/300?=#{i}")
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.phone_number,
    owner: false,
    company: companies.sample,
    email: "user#{i}@test.com",
    password: 'password'
  )
  user.avatar.attach(io: image, filename: "#{user.email}.jpg")
  user.save
end
users = User.all

cars.each do |car|
  latest_end_date = Date.today
  last_recorded_kilometers = car.kilometers

  5.times do
    start_date = Faker::Date.between(from: latest_end_date + 1, to: latest_end_date + 5)
    end_date = Faker::Date.between(from: start_date + 3, to: start_date + 5)
    latest_end_date = end_date
    new_kilometers = last_recorded_kilometers + rand(200..800)

    Reservation.create!(
      start_date: start_date,
      end_date: end_date,
      car: car,
      kilometers: new_kilometers,
      done: [true, false].sample,
      user: users.sample
    )
    last_recorded_kilometers = new_kilometers
  end
  reservations = Reservation.all

  2.times do
    Feedback.create!(
      reservation: reservations.sample,
      comment: Faker::Lorem.sentence
    )
  end
end
