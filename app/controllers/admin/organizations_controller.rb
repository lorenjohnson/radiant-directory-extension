class Admin::OrganizationsController < ApplicationController
  
  def index  
    @organizations = Organization.find(:all, :order => "name")
  end

  def show 
    @organization = Organization.find(params[:id])
  end
  
  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization]) and @organization.geocode
      redirect_to admin_organizations_path
    else
      render :action => "edit"
    end
  end
  
  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.new(params[:organization])    
    if @organization.save and @organization.geocode
      flash[:notice] = 'Organization was successfully created.'        
      redirect_to admin_organizations_url
    else
      render :action => "new"
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    flash[:notice] = "Organization successfully deleted."
    redirect_to admin_organizations_url
  end
        
end
