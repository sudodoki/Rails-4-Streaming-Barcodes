# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ADMIN_ROLE = {
  name: 'admin',
  read_admin: true,
  write_admin: true
}
MODERATOR_ROLE = {
  name: 'moderator',
  read_admin: true,
  write_admin: false
}
USER_ROLE = {
  name: 'user',
  read_admin: false,
  write_admin: false
}

def seed_roles
  print "Creating roles: \n"
  if Role.any?
    print "Deleting previous roles \n"
    Role.delete_all
  end
  [ADMIN_ROLE, MODERATOR_ROLE, USER_ROLE].each do |role|
    role = Role.create(role)
  end
  print "#{Role.pluck(:name).join(',')} created successfully \n"
end

def seed_admin
  return(print "Already have an admin \n") if User.where(login: 'Admin').any?
  admin = User.create_by_attr_and_role('Admin', 'Admin1', 'admin')
  print "Created #{admin.inspect} with role of #{admin.role.inspect} \n"
end
def seed_moderator
  moderator = User.create_by_attr_and_role('Moderator', 'Moderator', 'moderator')
  print "Created #{moderator.inspect} with role of #{moderator.role.inspect} \n"
end
def seed_plain_user
  user = User.create_by_attr_and_role('John', 'Johny1', 'user')
  print "Created #{user.inspect} with role of #{user.role.inspect} \n"
end

seed_roles
User.delete_all
seed_admin
seed_moderator
seed_plain_user