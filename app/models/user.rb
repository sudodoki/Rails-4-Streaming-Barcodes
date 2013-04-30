class User < ActiveRecord::Base
  validates :login, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_blank: false

  has_one :role_attachment
  has_one :role, through: :role_attachment

  def self.create_by_attr_and_role(login = 'Lolka', password = '123456', role = 'user')
    user = User.new(login: login, password: password)
    role = Role.where(name: role).first
    user.build_role_attachment(role: role)
    user.save
    user
  end

  def near_admin?
    self.role.read_admin
  end
  def can_write?
    self.role.write_admin
  end
end
