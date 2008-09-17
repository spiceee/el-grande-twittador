# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


class NotAuthorized < StandardError 
end

class NotFound < StandardError 
end

class Forbidden < StandardError 
end

class BadRequest < StandardError 
end


class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  filter_parameter_logging :password
  rescue_from NotAuthorized, :with => :deny_access
  rescue_from NotFound, :with => :not_found
  rescue_from Forbidden, :with => :forbidden
  rescue_from BadRequest, :with => :badrequest
  
  layout 'standard'
  
  def deny_access
     head :unauthorized
   end

   def not_found
     head :not_found
   end

   def forbidden
     head :forbidden
   end

   def badrequest
     head :bad_request
   end
   
end
