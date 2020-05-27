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