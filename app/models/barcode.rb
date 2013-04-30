class Barcode < ActiveRecord::Base
  belongs_to :user
  validates :code, length: {is: 13} , allow_blank: false, format: /\A\d+\Z/
  include Rails.application.routes.url_helpers


  def for_handlebars(current_user)
    {
      id: self.id,
      code: self.code,
      user: self.user_id,
      near_admin: current_user.near_admin?,
      can_write: current_user.can_write?,
      edit_path: edit_barcode_path(self),
      delete_path: barcode_path(self)
    }
  end
end
