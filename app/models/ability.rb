class Ability
  include CanCan::Ability

  def initialize(user)

    # Define abilities for the passed in user here. 

    if user and user.admin?
      can :manage, [User, Product, Category, Good, Network, Market]
=begin
      can :manage, [Agreement, AgreementChange]
=end
    end

    if user and (user.market_manager?)
      can :manage, Good do |good|
         user.markets.includes? good.market
      end
      can :manage, Market  do |market|
         user.markets.includes? market
      end
      can :manage, User, id: user.id
      #can :manage, User, market_id: user.market_id
    end

    if user and (user.buyer? or user.producer?)
      can :manage, Good, creator_id: user.id
      can [:index, :show], Good do |good|
         user.markets.includes? good.market
      end
      can [:show], Market do |market|
         user.markets.includes? market
      end
      can :manage, User, id: user.id
      #can [:show, :modal], User, market_id: user.market_id
      

=begin
      can :manage, Agreement, creator_id: user.id
      can [:index, :marketplace, :pic, :show, :modal, :root_agreement_changes], Agreement
      can :manage, AgreementChange, user_id: user.id
      can [:show, :chain], AgreementChange
=end
    end
    if user and (user.buyer?)
      can :manage, Cart, user_id: user.id
    end
  end
end
