class UsersController < ApplicationController

    def show
        
        name = params[:user]
        data = {id: User.all.find_by(name: name).id, name: name, status: 200 }
        if User.all.find_by(name: name)
            render json: data
        else
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
