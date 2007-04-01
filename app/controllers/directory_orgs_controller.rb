class DirectoryOrgsController < ApplicationController
  # layout "main"
  # no_login_required
  
  def index  
    @organizations = DirectoryOrg.find(:all, :order => "name")
  end

  def show 
    @organization = DirectoryOrg.find(params[:id])
  end
  
  def edit
    @organization = DirectoryOrg.find(params[:id])
  end

  def update
    @organization = DirectoryOrg.find(params[:id])
    if @organization.update_attributes(params[:directory_org])
      redirect_to directory_orgs_url
    else
      render :action => "edit"
    end
  end
  
  def new
    @organization = DirectoryOrg.new
  end
  
  def create
    @organization = DirectoryOrg.new(params[:directory_org])    
    if @organization.save
      flash[:notice] = 'Organization was successfully created.'        
      redirect_to directory_orgs_url
    else
      render :action => "new"
    end
  end

  def destroy
    @organization = DirectoryOrg.find(params[:id])
    @organization.destroy
    redirect_to directory_orgs_url
  end

end
