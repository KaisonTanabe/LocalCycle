class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. 

    if user and user.admin?
      can :manage, User
      can :manage, Form
    end

    if user and user.cm?
      can :manage, User, id: user.id
      cannot :index, User
      can :manage, Form
      cannot :destroy, Form
      can :destroy, Form, user_id: user.id
    end

    if user and user.educator?
      can :manage, User, id: user.id
      cannot :index, User
      can :manage, Form, user_id: user.id
    end

  end
end
