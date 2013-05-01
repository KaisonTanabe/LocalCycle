class Ability
  include CanCan::Ability

  def initialize(user)

    # Define abilities for the passed in user here. 

    if user and user.admin?
      can :manage, [User, Agreement, Product, Category]
    end

    if user and user.buyer?
      can :manage, Agreement
      can [:index, :marketplace, :pic], Product
      can :manage, User, id: user.id
      can :create, BuyerProfile
    end

    if user and user.producer?
      can :manage, Agreement
      can [:index, :marketplace, :pic], Product
      can :manage, User, id: user.id
      can :create, ProducerProfile
    end

  end
end
