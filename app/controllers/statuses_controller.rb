class StatusesController < ApplicationController
  
  def index;end
  
  def update
    raise BadRequest unless params[:login]
    raise BadRequest unless params[:password]
    raise BadRequest unless params[:status]
    
    @response = Status.update(params[:login], params[:password], params[:status])
    headers['content-type'] = 'text/javascript'
    render :layout => false 
  end
  
  def preview
    @portunhol = Status.portunhol params[:status]
    render :layout => false
  end
end
