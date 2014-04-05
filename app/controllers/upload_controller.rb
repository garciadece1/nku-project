class UploadController < ApplicationController
  def index
  end

  def import
    doc = Document.import(params[:file])
    if doc
      redirect_to file_path(doc), :notice => "Doc uploaded!"
    else
      flash[:error] = "Something went wrong! Try to reupload the docs"
    end
  end
end
