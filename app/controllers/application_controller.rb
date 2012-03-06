class ApplicationController < ActionController::Base
  require 'PgTools'
  protect_from_forgery
  before_filter :load_tenant

private  

  def load_tenant
  	if request.subdomain#Check this condition
  	  @current_tenant ||= Tenant.find_by_subdomain(request.subdomain) #Uses ActiveRecord::Base's connection.
  	  if !TenantManager.connection
  	  TenantManager.establish_connection(  :adapter => "postgresql",
  											:encoding => "unicode",
  											:database => "multitenants",
  											:pool => 5,
  											:username => @current_tenant.userid,
  											:password => @current_tenant.userid,
  											:port => 5433)
  	  end
  	  if !TenantManager.connection.schema_search_path 
        TenantManager.connection.schema_search_path = @current_tenant.userid#Uses Tenantmanger's connection 
      end
  	end
  end


end
