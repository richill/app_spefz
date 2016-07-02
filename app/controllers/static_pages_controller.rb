class StaticPagesController < ApplicationController
  def homepg
    @signup = Signup.new
  end

  def landingpg
    @signup = Signup.new
  end
end
