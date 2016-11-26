class StaticPagesController < ApplicationController
  # before_filter :user_not_allowed_to_view, only: [:homepg]

  def aboutpg
  end

  def accountpg 
  end

  def cancellationsrefundpg
  end

  def cookiepg  
  end

  def errorpermissionpg
  end
  
  def errorpg
  end

  def faqspg
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

  def membershippg
  end

  def notepg 
  end

  def partnerspg 
  end

  def paymentqueriespg
  end

  def privacypg 
  end

  def termspg
  end

  # def user_not_allowed_to_view
  #   redirect_to root_path
  # end
end
