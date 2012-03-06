class TenantsController < ApplicationController
  def new
    @tenant = Tenant.new
  end

  def index
  	@tenants=Tenant.all
  end
  
  def create
  	tenant = Tenant.find_by_subdomain(params[:tenant][:subdomain])
    if tenant
      flash[:error] =  "Subdomain has been taken already. Provide a different subdomain"
      redirect_to new_tenant_path
    else
      @tenant = Tenant.new(params[:tenant])
      @tenant.db_password = "password"
      if @tenant.save
       flash[:notice] = "Signed up!"
        redirect_to tenants_path
      else
        render :new
      end
    end
  end
  
  def destroy
    Tenant.find(params[:id]).destroy
    redirect_to tenants_path
  end
  
  def show
  	#ActiveRecord::Base.connection.schema_search_path="public"
  	@tenant = Tenant.find_by_subdomain(request.subdomain)
  end
end
