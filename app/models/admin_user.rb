class AdminUser < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_email_field = false
  end

  strip_attributes

  attr_accessible :name, :email, :password, :password_confirmation

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :format => { :with => RubyRegex::Email }

  def send_reset_password_email
    reset_perishable_token!
    Notifier.admin_user_reset_password(self).deliver
  end
end
