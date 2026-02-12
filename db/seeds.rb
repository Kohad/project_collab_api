puts "Seeding users..."

admin = User.create!(
  name: "Admin User",
  email: "admin@example.com",
  role: "admin"
)

manager = User.create!(
  name: "Manager User",
  email: "manager@example.com",
  role: "manager"
)

member = User.create!(
  name: "Member User",
  email: "member@example.com",
  role: "member"
)

puts "Seeding projects..."

project1 = Project.create!(
  title: "Internal Tool",
  description: "Company internal tool",
  owner: manager
)

project2 = Project.create!(
  title: "Website Redesign",
  description: "Marketing website revamp",
  owner: manager
)

puts "Seeding memberships..."

ProjectMembership.create!(
  user: member,
  project: project1,
  role: "viewer"
)

puts "Done."
