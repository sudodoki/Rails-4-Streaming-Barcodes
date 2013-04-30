class Role < ActiveRecord::Base
  has_many :role_attachments
  has_many :users, through: :role_attachments
end
