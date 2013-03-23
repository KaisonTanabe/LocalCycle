class Attachment < ActiveRecord::Base

  ################ MODULES ################


  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  belongs_to :attachable, polymorphic: true

  has_attached_file :attachment


  ## ATTRIBUTE PROTECTION

  attr_accessible :attachment, :attachable_id, :attachable_type


  #########################################



  ################ FILTERS ################

  #########################################




  ############ PUBLIC METHODS #############


  ############ PRIVATE METHODS #############
  private
end
