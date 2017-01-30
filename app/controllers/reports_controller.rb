class ReportsController < ApplicationController
  before_action :authenticate_user!, :set_report, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      @reports = Report.all
    else
      redirect_to errorpermission_path
    end
  end

  def show
    unless current_user.admin_pa_management_group || current_user.pa_administration_group
      redirect_to errorpermission_path
    end
  end

  def new
    @report = Report.new
  end

  def edit
    unless current_user.admin_pa_management_group || current_user.pa_administration_group
      redirect_to errorpermission_path
    end
  end

  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        MailerReport.report_content(@report).deliver
        format.html { redirect_to :back, notice: 'Report was successfully sent.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { redirect_to :back, alert: 'Report was not sent.' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user.admin_pa_management_group || current_user.pa_administration_group
      respond_to do |format|
        if @report.update(report_params)
          format.html { redirect_to :back, notice: 'Report was successfully updated.' }
          format.json { render :show, status: :ok, location: @report }
        else
          format.html { render :edit }
          format.json { render json: @report.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to errorpermission_path
    end
  end

  def destroy
    if current_user.admin_pa_management_group ||
      @report.destroy
      respond_to do |format|
        format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to errorpermission_path
    end
  end

  private
  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:content, :category_report_id, :event_id, :social_id, :user_id, :reference, :reporter_id)
  end
end
