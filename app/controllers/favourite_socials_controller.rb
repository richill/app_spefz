class FavouriteSocialsController < ApplicationController
end


class FavouriteCompaniesController < ApplicationController
  before_action :set_company
  
  def create
    if Favourite.create(favourited: @company, userj: current_userj)
      redirect_to @company, notice: 'Company has been Saved'
    else
      redirect_to @company, alert: 'Something went wrong...*sad panda*'
    end
  end
  
  def destroy
    Favourite.where(favourited_id: @company.id, userj_id: current_userj.id).first.destroy
    redirect_to @company, notice: 'Company has been removed from Saved List'
  end
  
  private
  
  def set_company
    @company = Company.find(params[:company_id] || params[:id])
  end
end
