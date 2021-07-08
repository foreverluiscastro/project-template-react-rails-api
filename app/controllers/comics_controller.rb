class ComicsController < ApplicationController
    
    # GET /comics
    def index
        # byebug
        if !session[:user_id] == false
            user = User.find(session[:user_id])
            # byebug
            comics = user.comics
            render json: comics, include: :user
        else
            render json: { errors: []}, status: :unauthorized
        end
    end

    # POST /comics
    def create
        if !session[:user_id] == false
            user = User.find(session[:user_id])
            comic = user.comics.create(comic_params)
            # byebug
            if comic.valid?
                render json: comic, include: :user, status: :created
            else
                render json: { errors: []}, status: :unprocessable_entity
            end
        else
            render json: { errors: []}, status: :unauthorized
        end
    end

    private

    def comic_params
        params.permit(:user_id, :title, :publisher, :creators, :img_url, :price)
    end
end
