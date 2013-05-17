class PreferredBuyerAgreement < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :agreement
  belongs_to :buyer_profile

  attr_accessible :agreement_id, :buyer_profile_id

end
