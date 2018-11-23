class ToppagesController < ApplicationController
  def index
   if logged_in?
      @tasks = current_user.tasks.build
      @tasklists = current_user.tasks.order('created_at DESC').page(params[:page])
   end  
  end
  
  
  def new
    @tasks = Task.new
  end  
  
  def show
    @tasks = Task.find(params[:id])
  end
  
  def create
    @tasks = Task.new(tasks_params)
    
    if @tasks.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to @tasks
    else
       flash[:danger] = 'Taskが正常に投稿されませんでした'
       render :new
    end     
  end  
    
  def edit
    @tasks = Task.find(params[:id])
  end
  
  def update
    @tasks = Task.find(params[:id])

    if @tasks.update(tasks_params)
      flash[:success] = 'task は正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end  
    
  def destroy
    @tasks = Task.find(params[:id])
    @tasks.destroy

    flash[:success] = 'Tasks は正常に削除されました'
    redirect_to tasks_url
  end
    
  

  private
  

# Strong Parameter
  def task_params
    params.require(:task).permit(:content)
  end
  
end