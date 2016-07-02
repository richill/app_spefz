class StaticPagesController < ApplicationController
  def homepg
  end
  
  def landingpg
    @signup = Signup.new
  end
end
