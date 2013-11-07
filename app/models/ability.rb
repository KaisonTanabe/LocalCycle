class Ability
  include CanCan::Ability

  def initialize(user)

    # Define abilities for the passed in user here. 

    if user and user.admin?
      can :manage, [User, Product, Category, Good, Network, Market, Order, SubOrder]
=begin
      can :manage, [Agreement, AgreementChange]
=end
    end

    if user and (user.market_manager?)
      can :manage, Good 
      can :manage, Order
      can :manage, SubOrder
      
      can :read, Market, :users=>{:id => user.id}
      can :create, Market
      can :update, Market, :users=>{:id => user.id}
      can :delete, Market, :users=>{:id => user.id}
      can :manage, User
      #can :manage, User, :markets => {:users =>{:id => user.id}}
    end

    if user and (user.buyer? or user.producer?)
      can :manage, Good, creator_id: user.id
      can :show, Good
      can :index, Good do |good|
         (user.markets & good.markets).count > 0
      end
      can [:show], Market do |market|
         user.markets.includes? market
      end
      can :show, User
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
      can [:show], Wishlist, user_id: user.id
      can [:edit, :show, :update], Order, user_id: user.id
      can [:index, :show], Order
      
    end
    
    if user and (user.producer?)
      can [:index], Wishlist
      can [:index, :show], SubOrder
      
      can :manage, Product, {:created_by => user.id}
    end
    
  end
end
