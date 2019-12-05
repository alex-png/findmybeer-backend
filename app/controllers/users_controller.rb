class UsersController < ApplicationController

    def show
        
        # name = params[:user]
        # user = 
        # data = {id: User.all.find_by(name: name).id, name: name, status: 200 }
        if User.find_by(name: params[:user])
            data = User.find_by(name: params[:user])
            render json: data, include: [:liked_beers, :reviews]
        else
            data = User.find_by(name: params[:user])
            render json: data.errors
        end
        

    end

   


    def create
        user = User.new(user_params)
        if user.save
            render json: user, status: :created
        else
            render json: user.errors, status: :unprocessable_entity
        end

    end


    private

    def user_params
        params.require(:user).permit(:name)
    end
    

end
