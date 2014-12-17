class NotesController < ApplicationController
	before_action :find_note, only: [:show, :edit, :update, :destroy]

	def index
		@notes = Note.all.order("created_at DESC")
		render json: @notes
	end

	def show
		render json: @notes
	end

	def new
		@note=Note.new
		render json: @notes
	end

	def edit
		@note = Note.find(params[:id])
	end

	def create
		@note = Note.new(note_params)
		if @note.save
			redirect_to @note, notice: "Succesfully created new note"
		else
			render json: @note.errors, status: :unprocessable_entity
		end
	end

	def update
		if @note.update(note_params)
			render json: @note
		else
			render json: @note.errors, status: :unprocessable_entity
		end
		head :no_content
	end

	def destroy
		@note.destroy
		head :no_content
	end


	private
	def find_note
		@note = Note.find(params[:id])
	end

	def note_params
		params.require(:note).permit(:title)
	end
end
