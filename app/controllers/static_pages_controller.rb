class StaticPagesController < ApplicationController
  def landingpg
    @signup = Signup.new
  end
end
