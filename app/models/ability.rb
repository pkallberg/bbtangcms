class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    alias_action :index, :show, :to => :read
    alias_action :new, :to => :create
    alias_action :edit, :to => :update

    #destroy, update ,create
    @user = user || User.new # for guest

    case controller_namespace
      when 'auth'
        #can :manage, :all if self.limit_admin_group?
        can :read, :all if @user.limit_admin_group?
      else
        # rules for non-admin controllers here
    end

    @user.cms_roles.each { |role| send(role.name.downcase) if self.respond_to? role.name.downcase }

    @user.cms_roles.each do |cr|
      cr.cms_role_permits.each do |crp|
        send(crp.permit.name.downcase) if self.respond_to? crp.permit.name.downcase
      end
    end

    @user.permits.each { |permit| send(permit.name.downcase) if self.respond_to? permit.name.downcase }


    #if @user.cms_roles.size == 0
    if @user.cms_roles.empty?
      #can :read, :all #for guest without roles
      cannot :manage, :all
    end
  end
##################create ##########################
  def create_profile
    can :create, Profile
  end

  def create_knowledge
    can :create, Knowledge
  end

  def create_category_base
    can :create, CategoryBase
  end

  def create_question
    can :create, Question
  end


  def create_question_answer
    can :create, Answer#, :question => Question.new
  end

  def create_tag_identity
    can :create, Identity
  end

  def create_tag_identities_timeline
    # can :manage, Category, :restaurant => {:user_id => user.id}
    can :create, Timeline
  end

  def create_tag_identities_timelines_category
    #debugger
    can :create, Category#, :identity => Identity.new, :timeline => Timeline.new
  end

  def create_recommend_recommend_event
    can :create, Recommend::RecommendEvent
  end

  def create_recommend_recommend_mtool
    can :create, Recommend::RecommendMtool
  end

  def create_recommend_recommend_product
    can :create, Recommend::RecommendProduct
  end

  def create_recommend_recommend_question
    can :create, Recommend::RecommendQuestion
  end

  def create_recommend_recommend_quiz
    can :create, Recommend::RecommendQuiz
  end

  def create_recommend_recommend_subject
    can :create, Recommend::RecommendSubject
  end

  def create_recommend_recommend_tag
    can :create, Recommend::RecommendTag
  end

  def create_recommend_recommend_user
    can :create, Recommend::RecommendUser
  end

  def create_recommend_recommend_hindex
    can :create, Recommend::RecommendHindex
  end
##################update ##########################
  def update_profile
    can :update, Profile
  end

  def update_knowledge
    can :update, Knowledge
  end

  def update_category_base
    can :update, CategoryBase
  end

  def update_question
    can :update, Question
  end

  def update_question_answer
    can :update, Answer#, :question => Question.new
  end

  def update_tag_identity
    can :update, Identity
  end

  def update_tag_identities_timeline
    can :update, Timeline#, :identity => Identity.new
  end

  def update_tag_identities_timelines_category
    can :update, Category#, :identity => Identity.new, :timeline => Timeline.new
  end

  def update_recommend_recommend_event
    can :update, Recommend::RecommendEvent
  end

  def update_recommend_recommend_mtool
    can :update, Recommend::RecommendMtool
  end

  def update_recommend_recommend_product
    can :update, Recommend::RecommendProduct
  end

  def update_recommend_recommend_question
    can :update, Recommend::RecommendQuestion
  end

  def update_recommend_recommend_quiz
    can :update, Recommend::RecommendQuiz
  end

  def update_recommend_recommend_subject
    can :update, Recommend::RecommendSubject
  end

  def update_recommend_recommend_tag
    can :update, Recommend::RecommendTag
  end

  def update_recommend_recommend_user
    can :update, Recommend::RecommendUser
  end

  def update_recommend_recommend_hindex
    can :update, Recommend::RecommendHindex
  end
##################read ##########################
  def read_profile
    can :read, Profile
  end

  def read_knowledge
    can :read, Knowledge
  end

  def read_category_base
    can :read, CategoryBase
  end

  def read_question
    can :read, Question
  end

  def read_question_answer
    can :read, Answer#, :question => Question.new
  end

  def read_tag_identity
    can :read, Identity
  end

  def read_tag_identities_timeline
    can :read, Timeline#, :identity => Identity.new
  end

  def read_tag_identities_timelines_category
    can :read, Category#, :identity => Identity.new, :timeline => Timeline.new
  end

  def read_recommend_recommend_mtool
    can :read, Recommend::RecommendMtool
  end

  def read_recommend_recommend_product
    can :read, Recommend::RecommendProduct
  end

  def read_recommend_recommend_question
    can :read, Recommend::RecommendQuestion
  end

  def read_recommend_recommend_quiz
    can :read, Recommend::RecommendQuiz
  end

  def read_recommend_recommend_subject
    can :read, Recommend::RecommendSubject
  end

  def read_recommend_recommend_tag
    can :read, Recommend::RecommendTag
  end

  def read_recommend_recommend_user
    can :read, Recommend::RecommendUser
  end

  def read_recommend_recommend_hindex
    can :read, Recommend::RecommendHindex
  end
##################destroy ##########################
  def destroy_profile
    can :destroy, Profile
  end

  def destroy_knowledge
    can :destroy, Knowledge
  end

  def destroy_category_base
    can :destroy, CategoryBase
  end

  def destroy_question
    can :destroy, Question
  end

  def destroy_question_answer
    can :destroy, Answer#, :question => Question.new
  end

  def destroy_tag_identity
    can :destroy, Identity
  end

  def destroy_tag_identities_timeline
    can :destroy, Timeline#, :identity => Identity.new
  end

  def destroy_tag_identities_timelines_category
    can :destroy, Category#, :identity => Identity.new, :timeline => Timeline.new
  end

  def destroy_recommend_recommend_mtool
    can :destroy, Recommend::RecommendMtool
  end

  def destroy_recommend_recommend_product
    can :destroy, Recommend::RecommendProduct
  end

  def destroy_recommend_recommend_question
    can :destroy, Recommend::RecommendQuestion
  end

  def destroy_recommend_recommend_quiz
    can :destroy, Recommend::RecommendQuiz
  end

  def destroy_recommend_recommend_subject
    can :destroy, Recommend::RecommendSubject
  end

  def destroy_recommend_recommend_tag
    can :destroy, Recommend::RecommendTag
  end

  def destroy_recommend_recommend_user
    can :destroy, Recommend::RecommendUser
  end

  def destroy_recommend_recommend_hindex
    can :destroy, Recommend::RecommendHindex
  end
  ##############other permit

  def resetscore_question
    can :resetscore, Question
  end

##################other ##########################
  #def editor
  #  can :manage, Employee
  #end

  #def operatoradmin
  #  can :manage, Employee
  #end

  #def operator
  #  can :manage, Employee
  #end

  def admin
    #manager
    #include User,CmsRole
    can :manage, :all
  end

  def guest
    basic_ability
  end

  protected
  def basic_ability

    #can [:index,:destroy,:show] , User
    #can :index, Product
    #can :show, Product

    can :index, :dashboard
    # bellow is defining for "Tag::DashboardController " any it work as follow line(cancan 1.6.7)
    #and also shuld same with auth/dashboard but I filter, with another method
    can :show, :dashboard
    can :search, :common
  end

  #def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  #end
end
