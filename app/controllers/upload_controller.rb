class UploadController < ApplicationController
  def index
  end

  def import
    email = signed_in? ? current_user.email : params[:email]
    doc = Document.import(params[:file], email)
    if doc
      redirect_to file_path(key: doc.key), :notice => "Documents uploaded!"
    else
      flash.now[:error] = "Something went wrong! Try to reupload the documents"
    end
  end
end
