class UsersController < ApplicationController

    def show
        
        # name = params[:user]
        # user = 
        # data = {id: User.all.find_by(name: name).id, name: name, status: 200 }
        if User.find_by(name: params[:user])
            data = User.find_by(name: params[:user])
            
            render json: data
        else
            data = User.find_by(name: params[:user])
            render json: data.errors
        end
        

    end

    def beers
        if User.find(params[:id])
            user = User.find(params[:id])
            data = user.beers
            
            render json: data
        else
            data = User.find_by(name: params[:user])
            render json: data.errors
        end
 end
   


    def create
        user = User.new(user_params)
        if user.save
            user.beers = Beer.all
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
