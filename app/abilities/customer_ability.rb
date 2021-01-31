class CustomerAbility 
  include CanCan::Ability

  def initialize(user)
    can :manage, Customer
  end
end
