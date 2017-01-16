class SessionsController < Devise::SessionsController
# class Devise::SessionsController < DeviseController

  def edit
    # add custom logic here
    @cards = Card.all
    super
  end

end 