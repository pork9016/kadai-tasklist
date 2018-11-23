class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy] 
  before_action :correct_user, only: [:destroy  ]

 
  def index
  @tasks = current_user.tasks.all
  end

  def show
    
  end

  def new
    @tasks = current_user.tasks.build
    
  end

  def create
   @tasks = current_user.tasks.build(tasks_params)
    if @tasks.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  

  def edit
  end

  def update
    

    if @tasks.update(tasks_params)
      flash[:success] = 'task は正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'task は更新されませんでした'
      render :edit
    end
  end
  
  

  def destroy
    @tasks.destroy
    
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

 def set_task
    @tasks = Task.find(params[:id])
 end

def tasks_params
  params.require(:task).permit(:content,)
end


  def correct_user
    @tasks = current_user.tasks.find_by(id: params[:id])
    unless @tasks
      redirect_to root_url
    end
  end
  
end
  
