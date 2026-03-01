if Rails.env.production?
  puts "Skipping sample seeds in production."
  return
end

puts "Destroying Records"
Job.destroy_all

puts "Creating Jobs"

Job.create!(
  title: "Site Manager",
  sub_heading: "Immediate Start!",
  category: "Teir 1",
  description: "asdfsdkfjsdhfbsjdhbfsjhdfbsjdhbfsjhdbfjshdbfjshbdfjshdbfabsjdhbasjhdbashdbajshbdjhdbsfjahsbdfjahbsdjfbhasdfbsjfhb",
  salary: "200000",
  location: "South yarra"
)

Job.create!(
  title: "Site Manager",
  sub_heading: "Immediate Start!",
  category: "Teir 1",
  description: "asdfsdkfjsdhfbsjdhbfsjhdfbsjdhbfsjhdbfjshdbfjshbdfjshdbfabsjdhbasjhdbashdbajshbdjhdbsfjahsbdfjahbsdjfbhasdfbsjfhb",
  salary: "200000",
  location: "South Yarra"
)

Job.create!(
  title: "Project Manager",
  sub_heading: "Immediate Start!",
  category: "Teir 2",
  description: "asdfsdkfjsdhfbsjdhbfsjhdfbsjdhbfsjhdbfjshdbfjshbdfjshdbfabsjdhbasjhdbashdbajshbdjhdbsfjahsbdfjahbsdjfbhasdfbsjfhb",
  salary: "250000",
  location: "Southbank"
)

Job.create!(
  title: "Constacts Administrator",
  sub_heading: "Immediate Start!",
  category: "Teir 1",
  description: "asdfsdkfjsdhfbsjdhbfsjhdfbsjdhbfsjhdbfjshdbfjshbdfjshdbfabsjdhbasjhdbashdbajshbdjhdbsfjahsbdfjahbsdjfbhasdfbsjfhb",
  salary: "180000",
  location: "Clayton"
)

puts "Finished Seeding"
