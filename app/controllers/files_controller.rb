class FilesController < ApplicationController
  before_filter :signed_in_user, only: [:index, :update, :destroy]

  def show    
    @file = Document.find_by_key(params[:key])
  end

  def destroy
    @file = Document.find(params[:id])
    if @file.destroy
      redirect_to files_path :notice => "Document removed!"
    end
  end

  def download
    @file = Document.find_by_key(params[:key])
    send_file @file.file_src, :type => @file.content_type, :disposition => 'inline'
  end

  def index
    @documents = current_user.documents
  end

  private
   # Redirects to `signin_path` if the user hasn't signed in yet
    def signed_in_user
      redirect_to sign_in_path, :status => 302 unless signed_in?
    end
end
