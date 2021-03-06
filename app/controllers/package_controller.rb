

class PackageController < ApplicationController
  def index
    distributions = Packager::Application.config.distributions
    base = Packager::Application.config.base_name
    port = request.port == 80 ? "" : ":#{request.port}"
    url = "http://#{request.host}#{port}/#{base}"
    @urls = []
    distributions.each do |dist|
      @urls << "deb #{url} #{dist['codename']} #{dist['components']}"
    end
  end
  
  def list
    resp = {}
    base_dir = Packager::Application.config.base_dir
    reprepro = Packager::Application.config.reprepro
    if reprepro
      distributions = Packager::Application.config.distributions
      distributions.each do |dist|
        code = dist['codename']
        resp[code] = `#{reprepro} -b #{base_dir} list #{code}`.chomp
      end
    end
    render :json => {:okay => true, :resp => resp}
  end
  
  require 'fileutils'
  
  def upload
    # Auth Here.
    unless params['key'] == Packager::Application.config.auth_key
      raise "Auth Key is not matched"
    end
    
    code = params['code'] || "trunk"
    logger.debug "Code: #{code}"
    
    uploaded_file = params['package']
    path = File.join("/tmp", uploaded_file.original_filename)
    File.open(path, "wb") { |f| f.write(uploaded_file.read) }
    
    # Register 
    logger.debug "Path: #{path}"
    file_info = `file #{path}`
    raise "Not Debian Package" unless file_info =~ /Debian\sbinary\spackage/

    reprepro = Packager::Application.config.reprepro
    base_dir = Packager::Application.config.base_dir
    
    if reprepro
      command = "#{reprepro} -b #{base_dir} includedeb #{code} #{path}"
      logger.info "Command: #{command}"
      logger.info `#{reprepro} -b #{base_dir} includedeb #{code} #{path}`
    end
    
    # Delete Uploaded package.
    FileUtils.rm_f path
    
    render :json => {:okay => true, :file => uploaded_file.original_filename }
  rescue => e
    render :json => {:okay => false, :msg => e.message }, :status => 401
  end

end


