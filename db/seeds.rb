
puts "Remove all Invoices"
Invoice.delete_all
puts "Remove all Client"
Client.delete_all
puts "Remove all Companies"
Company.delete_all
puts "Remove all users"
User.delete_all

puts "=" * 40
puts "start SEED"
puts "=" * 40

puts "*" * 40
puts "Users and Companies"

users = [{ person: {
  first_name: "Charles-henri",
  last_name: "Poniard",
  email: "c.poniard@gmail.com",
  password: "secret",
  phone_number: "06 06 06 06 06",
  status: 1
},
  company: {
    name: "Charles-henri Poniard Photographie",
    siret: 	79973482700014,
    legal_structure: "Entrepreneur individuel",
    vat: 0,
    start_activity: "15-12-2013",
    street_number: 160,
    street: "avenue du général de gaulle",
    zip_code: 17430,
    city: "Tonnay-Charente",
    country: "France",
    code_ape: '6201Z'
 }
},
{ person: {
  first_name: "Benoit",
  last_name: "Calin",
  email: "benoit.calin@gmail.com",
  password: "secret",
  phone_number: "06 06 06 06 06",
  status: 1
},
  company: {
    name: "MONSIEUR BENOIT CALIN",
    siret: 	84955687300016,
    legal_structure: "Entrepreneur individuel",
    vat: 0,
    start_activity: "27-03-2019",
    street_number: 8,
    street: "crs de la martinique",
    zip_code: 33000,
    city: "Bordeaux",
    country: "France",
    code_ape: '6201Z'
  }
}
]

users.each do |user|
  spayce_user = User.create!(
    user[:person]
  )
  spayce_user.companies.create!(
      user[:company]
  )
end

puts "Users and Companies create !! "
puts "*" * 40

puts "*" * 40
puts "Clients"
companies = Company.all
companies.each do |company|
  name = Faker::Name.name
  company.clients.create!(
    name: name,
    email: "#{name.tr(" ", ".").downcase}@gmail.com"
  )
end 
puts "*" * 40
puts "Clients create !"

puts "*" * 40
puts "Invoices"
clients = Client.all
clients.each do |client|
  name = Faker::Name.name
  client.invoices.create!(
    amount: Faker::Number.decimal(l_digits: 4, r_digits: 2),
    file: "en attente de mieux",
    description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: true),
    ref_number: Faker::Invoice.reference,
    end_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + rand(10..30)),
    status: rand(0..4),
    code_promo: "SPAYCE",
  )
end 
puts "*" * 40
puts "Invoices create !"

