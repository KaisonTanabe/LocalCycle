module Extensions
  module Authenticatable
    def self.included(base)
      base.class_eval do
        
        ############# CONFIGURATION #############

        # Include default devise modules. Others available are:
        #   :token_authenticatable, :omniauthable
        devise :database_authenticatable, :registerable, :confirmable, 
          :lockable, :timeoutable, :recoverable, :rememberable, 
          :trackable, :validatable

        ## ATTRIBUTE PROTECTION

        attr_accessible :password, :password_confirmation, 
          :remember_me, :confirmation_token


        ############ PUBLIC METHODS #############

        # Don't require password if not confirmed
        def password_required?
          super if confirmed?
        end
                
        # Ensure passwords match
        def password_match?
          self.errors[:password] << "can't be blank" if password.blank?
          self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
          self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
          password == password_confirmation && !password.blank?
        end        
        
      end
    end
  end
end



