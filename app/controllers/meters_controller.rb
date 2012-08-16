class MetersController < ApplicationController
  layout "meters"
  def index
  	# rest
  	# routes
    @meters = Meter.limit(30)
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

  def search_meter
    @meter_be_searched = Meter.search(params) if params_count >= 2
  end

  private
  def params_count
    count = 0
    if params[:user_id].blank? == false
      count = count + 1
    end
    if params[:user_name].blank? == false
      count = count + 1
    end
    if params[:user_phone].blank? == false
      count = count + 1
    end
    if params[:meter_id].blank? == false
      count = count + 1
    end
    count
  end
end