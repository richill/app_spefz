class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  extend FriendlyId
  friendly_id :slug_users, use: :slugged

  ratyrate_rateable "looks", "personality"
  ratyrate_rater

  acts_as_reader
  acts_as_taggable
  acts_as_messageable
  is_impressionable

  validates_presence_of :firstname, presence: true, message: "can't be blank"
  validates_presence_of :lastname, presence: true, message: "can't be blank"
  validates_presence_of :birthdate, presence: true, message: "can't be blank"
  validates_presence_of :category_gender, presence: true, message: "please select a category"
  validates_presence_of :category_country, presence: true, message: "please select a category"

  has_one :preference, dependent: :destroy

  belongs_to :category_gender 
  belongs_to :category_role 
  belongs_to :category_managementgroup 
  belongs_to :category_inviteoption 
  belongs_to :category_country 
  
  has_and_belongs_to_many :externalattendinglists
  has_and_belongs_to_many :hosts
  has_and_belongs_to_many :socials 

  has_many :payments
  has_many :blogs
  has_many :reports
  has_many :events
  has_many :socials, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourite_socials, through: :favourites, source: :favourited, source_type: 'Social', dependent: :destroy
  has_many :favourite_events, through: :favourites, source: :favourited, source_type: 'Event', dependent: :destroy

  has_many :attendances, dependent: :destroy
  has_many :attending_socials, through: :attendances, source: :attendable, source_type: 'Social', dependent: :destroy

  # acts_as_commentable
  has_many :comments, as: :commentable, dependent: :destroy

  #users main_user is following / main_user here is follower_id - main_user is the followed_id
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  
  #users following main_user / main_user here is followed_id - other_user is the follower_id
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where(friendships: { status: "accepted"}) }, through: :friendships
  has_many :requested_friends, -> { where(friendships: { status: "requested"}) }, through: :friendships, source: :friend #this is like recieved_request
  has_many :pending_friends, -> { where(friendships: { status: "pending"}) }, through: :friendships, source: :friend #this is like sent_request

  has_many :invites, dependent: :destroy
  has_many :sent_invites, -> { where(invites: { status: "pending"}) }, through: :invites, source: :invitee
  has_many :recieved_invites, -> { where(invites: { status: "pending"}) }, class_name: "Invite", foreign_key: "invitee_id", dependent: :destroy
  has_many :declined_invites, -> { where(invites: { status: "declined"}) }, through: :invites, source: :invitee

  has_many :invite_requests, dependent: :destroy
  has_many :sent_invite_requests, -> { where(invite_requests: { status: "pending"}) }, through: :invite_requests, source: :inviter
  has_many :recieved_invite_requests, -> { where(invite_requests: { status: "pending"}) }, class_name: "InviteRequest", foreign_key: "inviter_id", dependent: :destroy
  has_many :declined_invite_requests, -> { where(invite_requests: { status: "declined"}) }, through: :invite_requests, source: :inviter

  mount_uploader :image, ImageUploader
  before_destroy :delete_activities
  before_create :generate_reference_number
  before_create :assign_user_to_role_and_group
  before_create :assign_user_to_invitationoption
  before_create :dob_check


  # ---- gender -----
  scope :males, ->() { joins(:category_gender).where('category_genders.name' => "Male") } 
  scope :females, ->() { joins(:category_gender).where('category_genders.name' => "Female") } 


  # ---- roles & groups -----
  scope :admins, ->() { joins(:category_role).where('category_roles.name' => "Admin") }                                                                                       
  # all users in admin role

  scope :primary_admins, ->() { joins(:category_role).where('category_roles.name' => "Primary Admin") }                                                                                       
  # all users in primary_admin role

  scope :admins_and_primaryadmins, -> { joins(:category_role).where("category_roles.name IN (?)", ["Admin", "Primary Admin"]) }

  scope :clients, ->() { joins(:category_role).where('category_roles.name' => "Client") }                                                                                       
  # all users in client role

  scope :account_group, ->() { joins(:category_managementgroup).where('category_managementgroups.name' => "Account Group") }                                                                                       
  # all users in account_group

  scope :adminstration_group, ->() { joins(:category_managementgroup).where('category_managementgroups.name' => "Administration Group") }                                                                                       
  # all users in adminstration_group

  scope :client_group, ->() { joins(:category_managementgroup).where('category_managementgroups.name' => "Client Group") }                                                                                       
  # all users in client_group

  scope :client_guest_group, ->() { joins(:category_managementgroup).where('category_managementgroups.name' => "Client Guest Group") }                                                                                       
  # all users in client_group

  scope :development_group, ->() { joins(:category_managementgroup).where('category_managementgroups.name' => "Development Group") }                                                                                       
  # all users in development_group

  scope :dummy_group, ->() { joins(:category_managementgroup).where('category_managementgroups.name' => "Dummy Group") }                                                                                       
  # all users in development_group

  scope :users_not_in_dummy_group, -> { joins(:category_managementgroup).where("category_managementgroups.name IN (?)", ["Account Group", "Administration Group", "Client Group", "Client Guest Group", "Development Group", "Event Management Group", "Management Group", "Sales/Marketing Group"]) }
  # all users not in dummy_group

  scope :event_mgt_group, ->() { joins(:category_managementgroup).where('category_managementgroups.name' => "Event Management Group") }                                                                                       
  # all users in event_mgt_group

  scope :management_group, ->() { joins(:category_managementgroup).where('category_managementgroups.name' => "Management Group") }                                                                                       
  # all users in management_group

  scope :sales_mrkt_group, ->() { joins(:category_managementgroup).where('category_managementgroups.name' => "Sales/Marketing Group") }                                                                                       
  # all users in sales_marketing_group

  scope :spefz_team, -> { joins(:category_role).where("category_roles.name IN (?)", ["Admin", "Primary Admin"]) }

  scope :subcribed_users, -> () {where(["stripe_subscription_pymt_id IS NOT NULL or CAST(stripe_subscription_pymt_id as text) = ''"])}

  scope :unsubcribed_users, -> () {where(["stripe_subscription_pymt_id IS NULL or CAST(stripe_subscription_pymt_id as text) = ''"])}

  scope :live_socials, -> { joins(:socials).where(['socials.date >= ?', Date.current])}

  scope :open_socials, -> { joins(:socials).where(['socials.close = ? OR close IS ?', false, nil])}

  scope :hosts, -> { joins(:category_managementgroup).where("category_managementgroups.name IN (?)", ["Management Group", "Event Management Group"]) }                                                                                    
  # display users that are in charge of hosting speed-events

  scope :hosts_client_users_with_active_socials, -> { joins(:socials, :category_role).clients.uniq.live_socials.open_socials}
  # displays host in role: client who have created live_open socials

  scope :hosts_spefz_team_active_socials, -> { joins(:socials, :category_role).admins_and_primaryadmins.uniq.live_socials.open_socials }
  # displays host in role: admin & primary_admin role who have created live_open socials
  # scope :hosts_client_users_with_active_socials, -> { joins(:socials, :category_role).clients.uniq.live_socials.open_socials.map(&:socials)}
  # above displays live socials created by host in role: admin & primary_admin

  scope :users_with_no_ratings, -> { select {|user| user.overall_ratings == 0 }}
  # users_with_no_ratings = users.select {|user| user.overall_ratings == 0 }.count

  scope :users_with_ratings, -> { select {|user| user.overall_ratings > 0 }}
  # users_with_ratings = users.select {|user| user.overall_ratings > 0 }.count

  scope :random, -> { order(Arel::Nodes::NamedFunction.new('RANDOM', [])) }
  # users are displayed randomly each time the page is refereshed

  def slug_users
    [
      :firstname
    ]
  end

  def should_generate_new_friendly_id?
    slug.blank? || self.firstname_changed?
  end

  def admin_pa_management_group
    self.category_role.name == "Admin" && self.category_managementgroup.name == "Account Group" || 
    self.category_role.name == "Admin" && self.category_managementgroup.name == "Administration Group" || 
    self.category_role.name == "Admin" && self.category_managementgroup.name == "Client Group" || 
    self.category_role.name == "Admin" && self.category_managementgroup.name == "Development Group" || 
    self.category_role.name == "Admin" && self.category_managementgroup.name == "Event Management Group" || 
    self.category_role.name == "Admin" && self.category_managementgroup.name == "Management Group" || 
    self.category_role.name == "Admin" && self.category_managementgroup.name == "Sales/Marketing Group" || 
    self.category_role.name == "Primary Admin" && self.category_managementgroup.name == "Management Group"
    # Group_A & Group_B | admins & primary_admins in management_group
  end

  def pa_administration_group
    self.category_role.name == "Primary Admin" && self.category_managementgroup.name == "Administration Group"
    # Group_C | primary_admins in administration_group
  end

  def pa_event_mgt_group
    self.category_role.name == "Primary Admin" && self.category_managementgroup.name == "Event Management Group"
    # Group_D | primary_admins in event_mgt_group
  end

  def pa_acct_client_dev_sales_group
    self.category_role.name == "Primary Admin" && self.category_managementgroup.name == "Account Group" ||
    self.category_role.name == "Primary Admin" && self.category_managementgroup.name == "Client Group" ||
    self.category_role.name == "Primary Admin" && self.category_managementgroup.name == "Development Group" ||
    self.category_role.name == "Primary Admin" && self.category_managementgroup.name == "Sales/Marketing Group"
    # Group_E | primary_admins in account, client development & sales group
  end

  def client_group
    self.category_role.name == "Client" && self.category_managementgroup.name == "Account Group" ||
    self.category_role.name == "Client" && self.category_managementgroup.name == "Administration Group" ||
    self.category_role.name == "Client" && self.category_managementgroup.name == "Client Group" ||
    self.category_role.name == "Client" && self.category_managementgroup.name == "Development Group" ||
    self.category_role.name == "Client" && self.category_managementgroup.name == "Event Management Group" ||
    self.category_role.name == "Client" && self.category_managementgroup.name == "Management Group" ||
    self.category_role.name == "Client" && self.category_managementgroup.name == "Sales/Marketing Group"
    # Group_F | client in account, adminstration, client, development, event mgt, management, sales group
  end

  def client_guest_group
    self.category_role.name == "Client" && self.category_managementgroup.name == "Client Guest Group" 
    # Group_G | clients in client guest group: users here do not have to subscribe to fully use the site - this acts as a free subscription for users
  end

  def dummy_group
    self.category_role.name == "Client" && self.category_managementgroup.name == "Dummy Group"
    # Group_H | clients in dummy group: 
  end

  def subscribed?
    stripe_subscription_pymt_id?
  end

  def subscribed_access?
    self.subscribed? || self.admin_pa_management_group || self.pa_event_mgt_group || self.client_guest_group || self.dummy_group
  end

  def subscribed_social_access?(social_id)
    social = Social.find(social_id)
    self.subscribed? || self.id == social.user.id || self.admin_pa_management_group || self.pa_event_mgt_group || self.client_guest_group
    # eg: give access to certain pages if [eg: give access to current_user to view a social page]:
    # current_user has subscribed
    # current_user created the event [eg: current_user can only view socials they've created if they are not subscribed]
    # current_user belongs to the admin_pa_management_group
    # current_user belongs to the pa_event_mgt_group
  end

  #displays the overall avaerage rating for an user looks & personality
  def overall_ratings
    array = Rate.where(rateable_id: id, rateable_type: 'User')
    stars = array.map {|user| user.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end

  #displays the overall avaerage rating for an user looks
  def ratings_dimension_looks
    array = Rate.where(rateable_id: id, rateable_type: 'User').where(dimension: "looks")
    stars = array.map {|user| user.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end

  #displays the overall avaerage rating for an user personality
  def ratings_dimension_personality
    array = Rate.where(rateable_id: id, rateable_type: 'User').where(dimension: "personality")
    stars = array.map {|user| user.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end

  def uninvited_friends(social)
    friends = Set.new((self.friends.joins(:category_inviteoption).where("category_inviteoptions.name IN (?)", ["Only members in my network", "Every member"])).to_a)
    friends_already_invited_to_social = Set.new(Invite.where(social_id: social).flat_map(&:invitee))
    friends_not_yet_invited_to_social = friends.difference(friends_already_invited_to_social)
    invited_friends = Set.new(self.invites.where(invitee: nil, social: social).flat_map(&:users))
    uninvited_friends = friends_not_yet_invited_to_social.difference(invited_friends)
  end

  def assign_user_to_role_and_group
    self.category_role = CategoryRole.where(name: 'Client').first
    self.category_managementgroup = CategoryManagementgroup.where(name: 'Client Group').first
  end

  def assign_user_to_invitationoption
    self.category_inviteoption = CategoryInviteoption.where(name: 'Every member').first
  end

  def profile_image?
    self.image?
  end

  def event_paid?
    stripe_event_pymt_id?
  end

  def mailboxer_name
    self.firstname
  end

  def mailboxer_email(object)
    self.email
  end

  #follow a user
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  #unfollow a user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  #returns true if user is following a user
  def following?(other_user)
    followings.include?(other_user)
  end
  
  #returns true if user has sent a friend request
  def friended?(other_user)
    pending_friends.include?(other_user)
  end

  #returns true if both users are friends
  def friends?(other_user)
    friends.include?(other_user)
  end

  #displays user full name if both users are friends
  def name_shortner(other_user)
    if friends.include?(other_user) || self.lastname == other_user.lastname
      "#{other_user.firstname} #{other_user.lastname}"
    else
      "#{other_user.firstname} " + "#{other_user.lastname}"[0,1] + "."
    end
  end

  #returns true if user has sent an invite to other_user
  def invited?(other_user)
    sent_invites.include?(other_user)
  end

  #returns true if user has sent an invite request to event_organizer for an event/social
  def requested_invite?(event_organizer)
    sent_invite_requests.include?(event_organizer)
  end

  def self.desc_order
    order('created_at DESC')
  end

  def delete_activities
    acts = PublicActivity::Activity.where(owner_id: self.id, owner_type: "User")
    acts.delete_all
    # when a user deletes their account all their activities also gets deleted.
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - (birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  # def dob_check
  #   (self.birthdate.to_date + 18.years) < Date.today
  # end

  def old_enough?
    (self.birthdate.to_date + 18.years) < Date.today
  end

  def dob_check
    if old_enough?
      return true
    else
      errors.add(:birthdate, "must be older than 18 years")
      return false
    end
  end

  def self.platform_sufficient_users
    users = User.all
    users.females.count > 2 && users.males.count > 2
  end

  def matching(other_user)
    pref_seeking(other_user) &&
    pref_age(other_user) &&
    pref_relationship(other_user) &&
    pref_smoke(other_user)
    pref_religion(other_user) &&
    pref_parentstatus(other_user) &&
    pref_children(other_user) &&
    pref_ethnicity(other_user) &&
    pref_status(other_user) &&
    pref_bodytype(other_user) &&
    pref_education(other_user) &&
    pref_height(other_user)
  end

  def pref_age(other_user)
    current_user_age = self.age #eg displays: "36" 
    other_user_age   = other_user.age #eg displays "40"

    if (other_user_age >= self.preference.idealage_start.to_i && other_user_age <= self.preference.idealage_end.to_i) && 
       (current_user_age >= other_user.preference.idealage_start.to_i && current_user_age <= other_user.preference.idealage_end.to_i)
      other_user
    end
  end


  def pref_seeking(other_user)
    #category_matchseeking
    if self.preference.present? && other_user.preference.present?
      if self.preference.category_matchseeking.name == "Male"
        users = User.find(other_user)
        other_user.preference.category_matchseeking.name == "Female"
      elsif self.preference.category_matchseeking.name == "Female"
        other_user.preference.category_matchseeking.name == "Male"
      end
    end
  end


  def pref_relationship(other_user)
    #category_matchrelationship
    if self.preference.present? && other_user.preference.present?
      current_user_relationship = self.preference.category_matchrelationship.name
      current_user_ideal_relationship = self.preference.category_idealrelationship.name
      other_user_relationship = other_user.preference.category_matchrelationship.name
      other_user_ideal_relationship = other_user.preference.category_idealrelationship.name
      if current_user_ideal_relationship == other_user_relationship && other_user_ideal_relationship == current_user_relationship
        other_user
      end
    end
  end


  def pref_status(other_user)
    #category_matchstatus [multiple]
    if self.preference.present? && other_user.preference.present?
      current_user_relationshipstatus = self.preference.category_matchstatus.name #eg displays: "Never Married" 
      other_user_relationshipstatus   = other_user.preference.category_matchstatus.name #eg displays "Seperated"

      #current_user preferred relationship status
      current_user_preferred_relationshipstatus = Array.new
      current_user_selected_relationshipstatus = self.preference.category_idealstatus
      current_user_selected_relationshipstatus.each do |status|
        current_user_preferred_relationshipstatus << status.name
      end
      current_user_preferred_relationshipstatus #eg displays: ["Never Married", "Seperated", "Divorce"]

      #current_user preferred relationship status
      other_user_preferred_relationshipstatus = Array.new
      other_user_selected_relationshipstatus = other_user.preference.category_idealstatus
      other_user_selected_relationshipstatus.each do |status|
        other_user_preferred_relationshipstatus << status.name
      end
      other_user_preferred_relationshipstatus #eg displays: ["Never Married", "Divorced"]

      #if other_user_relationshipstatus is included in current_user_preferred_relationshipstatus and vice versa, display other_user 
      if current_user_preferred_relationshipstatus.include?(other_user_relationshipstatus) && other_user_preferred_relationshipstatus.include?(current_user_relationshipstatus)
        other_user
      end
    end
  end


  def pref_parentstatus(other_user)
    #category_matchparent
    if self.preference.present? && other_user.preference.present?
      current_user_parentstatus = self.preference.category_matchparent.name
      current_user_ideal_parentstatus = self.preference.category_idealparent.name
      other_user_parentstatus = other_user.preference.category_matchparent.name
      other_user_ideal_parentstatus = other_user.preference.category_idealparent.name

      current_user_parentstatus_ys = self.preference.category_matchparent.name == "Yes"
      current_user_parentstatus_no = self.preference.category_matchparent.name == "No"

      current_user_ideal_parentstatus_ys = self.preference.category_idealparent.name == "Yes"
      current_user_ideal_parentstatus_no = self.preference.category_idealparent.name == "No"
      current_user_ideal_parentstatus_dm = self.preference.category_idealparent.name == "I Do Not Mind"

      other_user_parentstatus_ys = other_user.preference.category_matchparent.name == "Yes"
      other_user_parentstatus_no = other_user.preference.category_matchparent.name == "No"

      other_user_ideal_parentstatus_ys = other_user.preference.category_idealparent.name == "Yes"
      other_user_ideal_parentstatus_no = other_user.preference.category_idealparent.name == "No"
      other_user_ideal_parentstatus_dm = other_user.preference.category_idealparent.name == "I Do Not Mind"

      if current_user_ideal_parentstatus == other_user_parentstatus && other_user_ideal_parentstatus == current_user_parentstatus
        other_user
      elsif current_user_ideal_parentstatus == other_user_parentstatus && other_user_ideal_parentstatus_dm
        other_user
      elsif other_user_ideal_parentstatus == current_user_parentstatus && current_user_ideal_parentstatus_dm
        other_user

      elsif current_user_ideal_parentstatus_dm && other_user_parentstatus_ys && other_user_ideal_parentstatus_dm 
        other_user
      elsif current_user_ideal_parentstatus_dm && other_user_parentstatus_no && other_user_ideal_parentstatus_dm 
        other_user
      end
    end
  end


  def pref_children(other_user)
    #category_matchkid
    if self.preference.present? && other_user.preference.present?
      current_user_children = self.preference.category_matchkid.name
      current_user_ideal_children = self.preference.category_idealkid.name
      other_user_children = other_user.preference.category_matchkid.name
      other_user_ideal_children = other_user.preference.category_idealkid.name
      if current_user_ideal_children == other_user_children && other_user_ideal_children == current_user_children
        other_user
      end
    end
  end


  def pref_education(other_user)
    #category_matcheducation [multiple]
    if self.preference.present? && other_user.preference.present?
      current_user_educationlevel = self.preference.category_matcheducation.name #eg displays: "Masters" 
      other_user_educationlevel   = other_user.preference.category_matcheducation.name #eg displays "Associates Degree"

      #current_user preferred educationlevel
      current_user_preferred_educationlevels = Array.new
      current_user_selected_educationlevels = self.preference.category_idealeducation
      current_user_selected_educationlevels.each do |education|
        current_user_preferred_educationlevels << education.name
      end
      current_user_preferred_educationlevels #eg displays: ["Associates Degree", "Bachelors Degree", "Masters", "PHD / Post Doctoral"]

      #other_user preferred educationlevel
      other_user_preferred_educationlevels = Array.new
      other_user_selected_educationlevels = other_user.preference.category_idealeducation
      other_user_selected_educationlevels.each do |education|
        other_user_preferred_educationlevels << education.name
      end
      other_user_preferred_educationlevels #eg displays: ["Bachelors Degree", "Masters", "PHD / Post Doctoral"]

      #if other_user_educationlevel is included in current_user_preferred_educationlevels and vice versa, display other_user 
      if current_user_preferred_educationlevels.include?(other_user_educationlevel) && other_user_preferred_educationlevels.include?(current_user_educationlevel)
        other_user
      end
    end
  end


  def pref_height(other_user)
    #category_matchheight [multiple]
    if self.preference.present? && other_user.preference.present?
      current_user_height = self.preference.category_matchheight.name #eg displays: "5'7" 
      other_user_height   = other_user.preference.category_matchheight.name #eg displays "5'11"

      #current_user preferred height
      current_user_preferred_heights = Array.new
      current_user_selected_heights = self.preference.category_idealheight
      current_user_selected_heights.each do |height|
        current_user_preferred_heights << height.name
      end
      current_user_preferred_heights #eg displays: ["5'11", "5'12", "6"]

      #other_user preferred height
      other_user_preferred_heights = Array.new
      other_user_selected_heights = other_user.preference.category_idealheight
      other_user_selected_heights.each do |height|
        other_user_preferred_heights << height.name
      end
      other_user_preferred_heights #eg displays: ["5'7", "5'8", "5'9", "5'10"]

      if current_user_preferred_heights.include?(other_user_height) && other_user_preferred_heights.include?(current_user_height)
        other_user
      end
    end
  end


  def pref_bodytype(other_user)
    #category_matchbodytype [multiple]
    if self.preference.present? && other_user.preference.present?
      current_user_bodytype = self.preference.category_matchbodytype.name #eg displays: "Slim" 
      other_user_bodytype   = other_user.preference.category_matchbodytype.name #eg displays "Athletic"

      #current_user preferred bodytype
      current_user_preferred_bodytypes = Array.new
      current_user_selected_bodytypes = self.preference.category_idealbodytype
      current_user_selected_bodytypes.each do |bodytype|
        current_user_preferred_bodytypes << bodytype.name
      end
      current_user_preferred_bodytypes #eg displays: ["About Average", "Slim", "Athletic"]

      #other_user preferred bodytype
      other_user_preferred_bodytypes = Array.new
      other_user_selected_bodytypes = other_user.preference.category_idealbodytype
      other_user_selected_bodytypes.each do |bodytype|
        other_user_preferred_bodytypes << bodytype.name
      end
      other_user_preferred_bodytypes #eg displays: ["About Average", "Slim"]

      if current_user_preferred_bodytypes.include?(other_user_bodytype) && other_user_preferred_bodytypes.include?(current_user_bodytype)
        other_user
      end
    end
  end


  def pref_ethnicity(other_user)
    #category_matchethnicity [multiple]
    if self.preference.present? && other_user.preference.present?
      current_user_ethnic = self.preference.category_matchethnicity.name #eg displays: "Black / African Descent" 
      other_user_ethnic   = other_user.preference.category_matchethnicity.name #eg displays "White / Caucasian"

      #current_user preferred ethnicity
      current_user_preferred_ethicities = Array.new
      current_user_selected_ethnicities = self.preference.category_idealethnicity
      current_user_selected_ethnicities.each do |ethnic|
        current_user_preferred_ethicities << ethnic.name
      end
      current_user_preferred_ethicities #eg displays: ["White / Caucasian", "Black / African Descent"]

      #other_user preferred ethnicity
      other_user_preferred_ethicities = Array.new
      other_user_selected_ethnicities = other_user.preference.category_idealethnicity
      other_user_selected_ethnicities.each do |ethnic|
        other_user_preferred_ethicities << ethnic.name
      end
      other_user_preferred_ethicities #eg displays: ["White / Caucasian", "Mixed Race", "Mediterranean", "Black / African Descent"]

      #if other_user_ethnic is included in current_user_preferred_ethicities and vice versa, display other_user 
      if current_user_preferred_ethicities.include?(other_user_ethnic) && other_user_preferred_ethicities.include?(current_user_ethnic)
        other_user
      end
    end
  end


  def pref_religion(other_user)
    #category_matchreligion [multiple]
    if self.preference.present? && other_user.preference.present?
      current_user_religion = self.preference.category_matchreligion.name #eg displays: "Christian" 
      other_user_religion   = other_user.preference.category_matchreligion.name #eg displays "Jewish"

      #current_user preferred ethnicity
      current_user_preferred_religions = Array.new
      current_user_selected_religions = self.preference.category_idealreligion
      current_user_selected_religions.each do |religion|
        current_user_preferred_religions << religion.name
      end
      current_user_preferred_religions #eg displays: ["Christian", "Jewish"]

      #other_user preferred ethnicity
      other_user_preferred_religions = Array.new
      other_user_selected_religions = other_user.preference.category_idealreligion
      other_user_selected_religions.each do |religion|
        other_user_preferred_religions << religion.name
      end
      other_user_preferred_religions #eg displays: ["Christian", "Jewish", "Hindu"]

      #if other_user_religion is included in current_user_preferred_religions and vice versa, display other_user 
      if current_user_preferred_religions.include?(other_user_religion) && other_user_preferred_religions.include?(current_user_religion)
        other_user
      end
    end
  end


  def pref_smoke(other_user)
    #category_matchsmoke [multiple]
    if self.preference.present? && other_user.preference.present?
      current_user_smokestatus = self.preference.category_matchsmoke.name #eg displays: "No, Smoke Is Not A Problem" 
      other_user_smokestatus   = other_user.preference.category_matchsmoke.name #eg displays "Yes, Often"

      #current_user preferred smoke_status
      current_user_preferred_smokestatus = Array.new
      current_user_selected_smokestatus = self.preference.category_idealsmoke
      current_user_selected_smokestatus.each do |smokestatus|
        current_user_preferred_smokestatus << smokestatus.name
      end
      current_user_preferred_smokestatus #eg displays: ["Trying To Quit", "No, Smoke Is Not A Problem"]

      #other_user preferred smoke_status
      other_user_preferred_smokestatus = Array.new
      other_user_selected_smokestatus = other_user.preference.category_idealsmoke
      other_user_selected_smokestatus.each do |smokestatus|
        other_user_preferred_smokestatus << smokestatus.name
      end
      other_user_preferred_smokestatus #eg displays: ["Ocassionally / Socially", "Yes, Often", "No, Smoke Is Not A Problem"]

      #if other_user_smokestatus is included in current_user_preferred_smokestatus and vice versa, display other_user  
      if current_user_preferred_smokestatus.include?(other_user_smokestatus) && other_user_preferred_smokestatus.include?(current_user_smokestatus)
        other_user
      end
    end
  end

  def user_info
    data = "
      <span>#{firstname}</span> 
      <span>#{lastname}</span>
      [<span>Age: #{age}</span>]
    "
    data.html_safe
  end

  protected
  # deactivates confirmable
  def confirmation_required?
    false
  end
end

