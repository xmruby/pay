#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :page_session
  def page_session(param)
  	if (session[:id].to_s != param.to_s)
  	  session[:id] = nil
      flash[:notice] = 'session 失败，请重新填写查询条件！'
      redirect_to show_search_meters_path
  	end
  end
end
