require 'faker'
require 'open-uri'
require 'csv'

Feedback.destroy_all
Reservation.destroy_all
Car.destroy_all
Company.destroy_all
User.destroy_all

5.times do
  Company.create!(
    name: Faker::Company.name,
    address: Faker::Address.street_address
  )
end
companies = Company.all

cars_url = [
  "https://fr.wikipedia.org/wiki/Peugeot_3008_II",
  "https://fr.wikipedia.org/wiki/Peugeot_307",
  "https://fr.wikipedia.org/wiki/Renault_M%C3%A9gane",
  "https://fr.wikipedia.org/wiki/Renault_Zoe",
  "https://fr.wikipedia.org/wiki/Renault_Clio_IV",
  "https://fr.wikipedia.org/wiki/Renault_Twingo_III",
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
    plate_number: "#{letters} #{numbers} #{letters2}",
    company: companies.sample,
    base_kilomoters: rand(10_000..50_000)
  )

  image_url = "https:#{doc.search('table span a img').attr('src').value}"
  image_resized = image_url.gsub("280px", "700px")
  image = URI.open(image_resized)
  car.photo.attach(io: image, filename: "#{car.model}.jpg")

  car.save
end
cars = Car.all

5.times do |i|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.phone_number,
    owner: false,
    company: companies.sample,
    email: "user#{i}@test.com",
    password: 'password'
  )
end
users = User.all

cars.each do |car|
  latest_end_date = Date.today
  5.times do
    start_date = Faker::Date.between(from: latest_end_date + 1, to: latest_end_date + 5)
    end_date = Faker::Date.between(from: start_date + 3, to: start_date + 5)
    latest_end_date = end_date

    Reservation.create!(
      start_date: start_date,
      end_date: end_date,
      car: car,
      kilometers: rand(20..300),
      done: true,
      user: users.sample
    )
  end
  reservations = Reservation.all

  2.times do
    Feedback.create!(
      reservation: reservations.sample,
      comment: Faker::Lorem.sentence
    )
  end
end
