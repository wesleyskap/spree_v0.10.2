# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SiteExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/site"

  # Please use theme_default/config/routes.rb instead for extension routes.

  def self.require_gems(config)
    config.gem 'rack-rewrite', '0.2.1'
    require 'rack-rewrite' 
    config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
      r301 '/products',           '/produtos'
      r301 '/t',                  '/produtos'
    end
  end
  
  def activate
	if Spree::Config.instance
	  Spree::Config.set(:site_name => "Loja Virtual")
	  Spree::Config.set(:logo => "/images/maya_logo.png")
	  Spree::Config.set(:admin_interface_logo => "spree/spree.jpg")
	  Spree::Config.set(:allow_openid => false)
	  Spree::Config.set(:products_per_page=>100)
	  Spree::Config.set(:admin_products_per_page=>200)
	  Spree::Config.set(:cache_static_content => false)
	  Spree::Config.set(
	    :show_zero_stock_products => true,
	    :track_inventory_levels => true,
	    :allow_backorders => false
	  )
	end
    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
    
  end
end
