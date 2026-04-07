# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Cleaning database..."
Message.destroy_all
Case.destroy_all
Policy.destroy_all
Employee.destroy_all

puts "Creating employees..."

employees = [
  # Normal employees (5)
  {
    first_name: "John", last_name: "Smith", email: "john.smith@example.com",
    employee_id: "US12345", job_title: "Software Engineer", department: "Engineering",
    country: "United States", manager_name: "Sarah Johnson",
    hire_date: Date.new(2021, 5, 10), role: "employee", employment_status: :active
  },
  {
    first_name: "Maria", last_name: "Lopez", email: "maria.lopez@example.com",
    employee_id: "MX54321", job_title: "Customer Support Specialist", department: "Customer Support",
    country: "Mexico", manager_name: "Miguel Santos",
    hire_date: Date.new(2020, 3, 15), role: "employee", employment_status: :active
  },
  {
    first_name: "Ana", last_name: "Silva", email: "ana.silva@example.com",
    employee_id: "PT98765", job_title: "Finance Analyst", department: "Finance",
    country: "Portugal", manager_name: "João Pereira",
    hire_date: Date.new(2019, 9, 1), role: "employee", employment_status: :active
  },
  {
    first_name: "Carlos", last_name: "Gomez", email: "carlos.gomez@example.com",
    employee_id: "ES67890", job_title: "Manufacturing Operator", department: "Manufacturing",
    country: "Spain", manager_name: "Lucia Fernandez",
    hire_date: Date.new(2022, 1, 20), role: "employee", employment_status: :active
  },
  {
    first_name: "Priya", last_name: "Rao", email: "priya.rao@example.com",
    employee_id: "IN11223", job_title: "Software Engineer", department: "Engineering",
    country: "India", manager_name: "Ravi Kumar",
    hire_date: Date.new(2018, 7, 30), role: "employee", employment_status: :active
  },

  # HR stakeholders (5)
  {
    first_name: "Laura", last_name: "Martins", email: "laura.martins@example.com",
    employee_id: "PT44556", job_title: "HRSC Specialist", department: "HR Shared Services",
    country: "Portugal", manager_name: "Helena Costa",
    hire_date: Date.new(2017, 4, 12), role: "hr_agent", employment_status: :active
  },
  {
    first_name: "Daniel", last_name: "Reyes", email: "daniel.reyes@example.com",
    employee_id: "US99887", job_title: "GTA Recruiter", department: "Talent Acquisition",
    country: "United States", manager_name: "Emily Brown",
    hire_date: Date.new(2021, 11, 5), role: "gta", employment_status: :active
  },
  {
    first_name: "Akira", last_name: "Tanaka", email: "akira.tanaka@example.com",
    employee_id: "JP33445", job_title: "Payroll Operations Analyst", department: "Payroll",
    country: "Japan", manager_name: "Hiroshi Sato",
    hire_date: Date.new(2016, 6, 18), role: "payroll", employment_status: :active
  },
  {
    first_name: "Sofia", last_name: "Costa", email: "sofia.costa@example.com",
    employee_id: "ES55667", job_title: "Benefits Administration Specialist", department: "Benefits",
    country: "Spain", manager_name: "María Delgado",
    hire_date: Date.new(2019, 2, 8), role: "benefits", employment_status: :active
  },
  {
    first_name: "Ethan", last_name: "Wong", email: "ethan.wong@example.com",
    employee_id: "SG77889", job_title: "HR Business Technology Analyst", department: "HR Business Technology",
    country: "Singapore", manager_name: "Wei Ling Tan",
    hire_date: Date.new(2020, 10, 22), role: "hr_bt", employment_status: :active
  }
]

employees = employees.map { |attrs| Employee.create!(attrs) }

puts "Creating policies..."


puts "Creating users..." #adding users

Employee.all.each do |employee|
  User.create!(
    email: employee.email,
    password: "password123",
    employee: employee
  )
end

puts "Users created!"


policies = [
  { title: "US PTO Policy", body: "Details about paid time off in the US.", category: "Leave", country: "United States", tags: "pto, leave, vacation", visibility: "public", last_updated: Date.today },
  { title: "Mexico Social Security", body: "IMSS contributions and benefits.", category: "Benefits", country: "Mexico", tags: "imss, benefits", visibility: "public", last_updated: Date.today },
  { title: "Portugal Holiday Allowance", body: "Holiday allowance rules in Portugal.", category: "Payroll", country: "Portugal", tags: "holiday, allowance", visibility: "public", last_updated: Date.today },
  { title: "Spain Sick Leave", body: "Sick leave documentation and pay.", category: "Leave", country: "Spain", tags: "sick leave, baja", visibility: "public", last_updated: Date.today },
  { title: "India Leave Policy", body: "Earned leave and casual leave rules.", category: "Leave", country: "India", tags: "leave, india", visibility: "public", last_updated: Date.today },
  { title: "Singapore Public Holidays", body: "Official public holidays in Singapore.", category: "Leave", country: "Singapore", tags: "public holidays", visibility: "public", last_updated: Date.today },
  { title: "US Payroll Cutoff", body: "Payroll cutoff dates for US employees.", category: "Payroll", country: "United States", tags: "payroll, cutoff", visibility: "internal", last_updated: Date.today },
  { title: "EU Remote Work Guidelines", body: "Remote work rules across the EU.", category: "Remote Work", country: "EU", tags: "remote, eu", visibility: "public", last_updated: Date.today },
  { title: "APAC Travel & Expenses", body: "T&E rules for APAC region.", category: "Expenses", country: "APAC", tags: "travel, expenses", visibility: "internal", last_updated: Date.today },
  { title: "Global Code of Conduct", body: "Company-wide code of conduct.", category: "Compliance", country: "Global", tags: "code, conduct", visibility: "public", last_updated: Date.today }
]

policies.each { |attrs| Policy.create!(attrs) }

puts "Creating cases..."

normal_cases = [
  { employee: employees[0], category: "Payroll", description: "Question about US payroll cutoff.", status: :open, priority: :standard },
  { employee: employees[1], category: "Benefits", description: "IMSS eligibility question.", status: :open, priority: :standard },
  { employee: employees[2], category: "Leave", description: "Holiday allowance clarification.", status: :open, priority: :standard },
  { employee: employees[3], category: "Leave", description: "Sick leave documentation needed.", status: :open, priority: :standard },
  { employee: employees[4], category: "Contract", description: "Need contract copy.", status: :open, priority: :standard }
]

stakeholder_cases = [
  { employee: employees[6], category: "Contract Creation", description: "GTA submitted offer letter for contract creation.", status: :open, priority: :high },
  { employee: employees[7], category: "Payroll Correction", description: "Payroll team requests correction.", status: :open, priority: :high },
  { employee: employees[8], category: "Benefits Eligibility", description: "Benefits team requests eligibility review.", status: :open, priority: :standard },
  { employee: employees[9], category: "Workday Access", description: "HR_BT reports Workday access issue.", status: :open, priority: :high },
  { employee: employees[5], category: "Reporting Correction", description: "HR Reporting requests data fix.", status: :open, priority: :standard }
]

cases = (normal_cases + stakeholder_cases).map { |attrs| Case.create!(attrs) }

puts "Creating messages..."

messages = [
  { employee: employees[0], case: cases[0], content: "Hi HR, I have a question about payroll cutoff.", sender: "employee", channel: "teams" },
  { employee: employees[5], case: cases[0], content: "Hi John, I can help you with that.", sender: "hr_agent", channel: "teams" },
  { employee: employees[1], case: cases[1], content: "Do I qualify for IMSS?", sender: "employee", channel: "email" },
  { employee: employees[6], case: cases[5], content: "Submitting offer letter for contract creation.", sender: "gta", channel: "email" },
  { employee: employees[5], case: cases[5], content: "Received, starting contract process.", sender: "hr_agent", channel: "teams" },
  { employee: employees[7], case: cases[6], content: "Payroll correction needed ASAP.", sender: "payroll", channel: "email" },
  { employee: employees[5], case: cases[6], content: "We will review the correction.", sender: "hr_agent", channel: "teams" }
]

messages.each { |attrs| Message.create!(attrs) }

puts "Seeding complete!"
