class MetersController < ApplicationController
  def index
  	# rest
  	# routes
    @meters = Meter.limit(30)
    # respond_to do |format|
    #   format.html #index.html.erb
    #   format.xml { render :xml => @meters}
    # end 
  end

  def short
  	render :text => params[:id]
  end

  def edit
  	@meter = Meter.find(params[:id])
  end

  def update
    @meter = Meter.find(params[:id])
    if @meter.update_attributes(params[:id])
      flash[:notice] = 'Meter was successfully updated.'
      # redirect_to :action => 'show', :id => @person
    else
      render :action => 'edit'
    end
  end

  def destroy
    Meter.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def list
    # wants is determined by the http Accept header in the request
    @meters = Meter.limit(10)
    # respond_to do |format|
    #   index.html.erb
    #   format.xml { render :xml => @meters.to_xml }
    # end    
  end
end