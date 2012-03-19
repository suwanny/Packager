class PackageController < ApplicationController
  def index
  end
  
  def list
    render :json => {:okay => true}
  end
  
  def upload
    logger.debug params
    logger.debug "Code: #{params['code']}"
    logger.debug "Key : #{params['key']} and AuthKey: #{Packager::Application.config.auth_key}"
    
    # ActionDispatch::Http::UploadedFile
    uploaded_file = params['package']
    logger.debug "File: #{uploaded_file.original_filename}"
    logger.debug "Size: #{uploaded_file.size}"
    # path = File.join("/tmp", uploaded_file.original_filename)
    # File.open(path, "wb") { |f| f.write(uploaded_file.read) }
    render :json => {:okay => true}
  end

end


