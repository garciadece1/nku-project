class VerificationsController < ApplicationController
  def show
    @verification = Verification.find_by_key(params[:key])
    if @verification.nil?
      redirect_to root_path
    else
      @verification.verify
    end
    
  end
end