class SubjectsController < ApplicationController
	
  def new
    @subject = Subject.new
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def index
    @subjects = Subject.all
  end
  
  def create
    @subject = Subject.new(params[:subject])
    if @subject.save
      redirect_to subjects_path, :notice => "Successfully deleted subject."
    else
      render :new
    end  	
  end
  
  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    redirect_to subjects_path, :notice => "Successfully deleted subject."
  end  

end
