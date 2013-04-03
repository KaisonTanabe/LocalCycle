class Ability
  include CanCan::Ability

  def initialize(user)

    # Define abilities for the passed in user here. 

    if user and user.admin?
      can :manage, User
      can :manage, Agreements
      can :manage, Products
    end

    if user and user.buyer?
      can :manage, User, id: user.id
      can :manage, BuyerProfile, user_id: user.buyer_profile.id
    end

  end
end
