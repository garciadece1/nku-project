class FileController < ApplicationController
  def show
    @file = Document.find(params[:id])
  end

  def download
    @file = Document.find(params[:file_id])
    send_file @file.file_src, :type => @file.content_type, :disposition => 'inline'
  end
end
