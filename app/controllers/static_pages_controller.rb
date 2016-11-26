class StaticPagesController < ApplicationController
  # before_filter :user_not_allowed_to_view, only: [:homepg]

  def aboutpg
  end

  def accountpg 
  end

  def cookiepg  
  end

  def errorpermissionpg
  end
  
  def errorpg
  end

  def helppg
  end

  def homepg
  end

  def imagepg
  end

  def landingpg
    @signup = Signup.new
  end

  def membership
    
  end

  def notepg 
  end

  def privacypg 
  end

  def termspg
  end

  # def user_not_allowed_to_view
  #   redirect_to root_path
  # end
end
