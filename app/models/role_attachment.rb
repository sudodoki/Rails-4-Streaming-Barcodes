class RoleAttachment < ActiveRecord::Base
  belongs_to :role
  belongs_to :user
end
