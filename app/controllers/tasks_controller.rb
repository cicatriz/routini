class TasksController < ApplicationController

  def create 
    @task = Task.new(params[:task])
    @task.user = current_user

    if @task.save 
      redirect_to root_path, :notice => 'Task added.'
    else
      render 'pages/index'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to root_path, :notice => 'Removed task.'
  end

  def index
    tasks = current_user.tasks

    if tasks.empty?
      redirect_to root_path
    else
      @task = tasks[rand(tasks.count)]
      redirect_to task_path(@task)
    end
  end

  def show
    @task = Task.find(params[:id])
    @point = Point.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end
end
