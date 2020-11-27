class NotesController < ApplicationController
    before_action :require_user!
    def create
        note = current_user.notes.new(note_params)
        note.save
        flash[:errors] = note.errors.full_messages
        redirect_to track_url(note.track_id)
    end

    def destroy
        # Only current_user can delete this note. If ID is not hers, can't delete
        if current_user_id != Note.find(params[:id]).user_id
            render json: "403: Forbidden: Not your note"
        else
            note = current_user.notes.find(params[:id])
            note.destroy
            redirect_to track_url(note.track_id)
        end
    end

    private
    def note_params
        params.require(:note).permit(:note, :track_id)
    end
end
