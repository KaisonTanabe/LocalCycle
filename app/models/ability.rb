class Ability
  include CanCan::Ability

  def initialize(user)

    # Define abilities for the passed in user here. 

    if user and user.admin?
      can :manage, [User, Agreement, Product, Category]
    end

    if user and (user.buyer? or user.producer?)
      can :manage, Agreement, creator_id: user.id
      can [:index, :marketplace, :pic, :show, :modal, :root_agreement_changes], Agreement
      can :manage, AgreementChange, creator_id: user.id
      can [:show, :chain], AgreementChange
      can :manage, User, id: user.id
      can [:show, :modal], User
    end

  end
end
