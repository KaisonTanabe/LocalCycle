class PreferredUserAgreement < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :agreement
  belongs_to :preferred_user, class_name: "User", foreign_key: :user_id

  attr_accessible :agreement_id, :user_id

end
