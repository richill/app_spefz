class StaticPagesController < ApplicationController
  # before_filter :user_not_allowed_to_view, only: [:homepg]

  def errorpermissionpg
  end
  
  def errorpg
  end

  def homepg
  end

  def imagepg
  end

  def landingpg
    @signup = Signup.new
  end

  def notepg 
  end

  # def user_not_allowed_to_view
  #   redirect_to root_path
  # end
end
