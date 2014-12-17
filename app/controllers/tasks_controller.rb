class TasksController < ApplicationController
	def create
		@task = Task.new(task_params)
		if @task.save
			render json: @task, status: :created, location: @task
		else
			render json: @task.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy

		head :no_content
	end

	private
		def find_task
			@task = Task.find(params[:id])
		end

		def task_params
			params.require(:task).permit(:title)
	end

end
