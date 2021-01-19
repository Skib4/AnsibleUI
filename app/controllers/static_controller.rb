class StaticController < ApplicationController
  before_action :authenticate_user!
#  before_action :authenticate

  def terms
  end

  def privacy
  end

  def howto
  end

  def docs
  end

  def about
  end
end
