class Tenant < ActiveRecord::Base
  has_many :subjects
  after_create :prepare_tenant

  private

  def prepare_tenant
    create_schema
    create_tenant
    load_tables
    grant_permissions
  end

  def create_schema
  	PgTools.create_schema subdomain
  end
  
  def create_tenant
  	password = Base64.encode64(Digest::SHA1.digest("#{rand(1<<64)}/#{Time.now.to_f}/#{Process.pid}/#{userid}"))[0..7]
  	PgTools.create_tenant(userid, password)
  end
  
  def grant_permissions
  	PgTools.grant_permissions(userid, subdomain)
  end

  def load_tables
    return if Rails.env.test?
    PgTools.set_search_path userid
    load "#{Rails.root}/db/schema.rb"
    PgTools.restore_default_search_path
  end
  
end
