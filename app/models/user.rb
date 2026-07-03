class User < ApplicationRecord
  has_secure_password

  # #VALIDATIONS
  validates_presence_of :first_name, :last_name, :email, :password
  validates_uniqueness_of :email

  ## Methods
  def name
    first_name + " " + last_name
  end
end
