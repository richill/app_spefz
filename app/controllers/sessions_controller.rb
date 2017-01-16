class SessionsController < Devise::SessionsController

  def edit
    # add custom logic here
    @cards = Card.all
    super
  end

end 