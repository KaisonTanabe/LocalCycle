class PreferredProducerAgreement < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :agreement
  belongs_to :producer_profile

  attr_accessible :agreement_id, :producer_profile_id
end
