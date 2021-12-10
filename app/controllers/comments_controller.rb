class CommentsController < ApplicationController
    before_action :find_idiom

    def new
        @comment = Comment.new()
    end

    def create
        @idiom = Idiom.find(params[:idiom_id])
        @comment = @idiom.comments.create(body: params[:comments][:body], user: current_user,idiom: params[@idiom])
        redirect_to idiom_path(@idiom.id)
    end

    def destroy
        @idiom.comments.find(params[:id]).destroy
        redirect_to idiom_path(@idiom.id)
    end

    def edit
        @comment = Comment.find(params[:id])
    end

    def update
        @idiom = Idiom.find(params[:idiom_id])
        @comment = Comment.find(params[:id])

        if @comment.update(body: params[:comment][:body])
        flash[:success] = 'Edition réussie !'
        redirect_to idiom_path(@idiom.id)
        else
        flash[:error] = 'Commentaire trop petit ou trop grand !'
        render :edit
        end
    end

    private

    def find_idiom
        @idiom = Idiom.find(params[:idiom_id])
    end


end


