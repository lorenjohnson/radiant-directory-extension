class OrganizationsController < ApplicationController
  # layout "main"
  # no_login_required
  
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
      redirect_to organizations_url
    else
      flash[:notice] = ""
      @organization.errors.each_full { |e| flash[:notice] << e << ". " }
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
      redirect_to organizations_url
    else
      flash[:notice] = ""
      @organization.errors.each_full { |e| flash[:notice] << e << ". " }
      render :action => "new"
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to organizations_url
  end
        
end
