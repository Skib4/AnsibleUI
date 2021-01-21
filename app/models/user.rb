class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :rememberable, :validatable, :trackable

	validates :email, presence: true
	 
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  def update_tracked_fields!(request)
    super(request) unless admin?
  end

end
