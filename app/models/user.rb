class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :trackable
  #validates :email, uniqueness: true
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
