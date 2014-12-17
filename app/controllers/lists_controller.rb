class ListsController < ApplicationController
before_action :find_list, only: [:show, :edit, :update, :destroy]

	def index
		@lists= List.all.order("created_at DESC")
		render json: @lists, :include => [:tasks]
	end
	
	def show
		render json: @list, :include => [:tasks]
	end
	
	def new
		@list = List.new
		render json: @list
	end


	def create
		@list = List.new(list_params)
		if 	@list.save
			render json: @list, status: :created, location: @list
		else
			render json: @list.errors, status: :unprocessable_entity
		end

	end

	def edit

	end

	def update
		if @list.update(list_params)
			render json: @list
		else
			render json: @list.errors, status: :unprocessable_entity
		end
		head :no_content
	end

	def destroy
		@list.destroy
		head :no_content
	end


	private
	def find_list
		@list = List.find(params[:id])
	end

	def list_params
		params.require(:list).permit(:title)
	end
end
