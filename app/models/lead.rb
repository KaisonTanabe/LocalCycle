class Lead < ActiveRecord::Base

  # Temporary model to collect email addresses on BETA page

  attr_accessible :email

  validates :email, uniqueness: true, presence: true

end
