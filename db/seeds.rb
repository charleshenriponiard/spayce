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

user = User.create!(
    first_name: "Charles-henri",
    last_name: "Poniard",
    email: "c.poniard@gmail.com",
    password: "secret",
    phone_number: "06-06-06-06-06",
    status: 1
)

user.companies.create!(
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
    code_ape: 12
)
puts "Users and Companies create !! "
puts "*" * 40

puts "*" * 40
puts "Clients"
companies = Company.all
companies.each do |company|
  3..4.times do
    name = Faker::Name.name
    company.clients.create!(
      company_id: company.id,
      name: name,
      email: "#{name.tr(" ", ".").downcase}@gmail.com"
    )
  end
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

