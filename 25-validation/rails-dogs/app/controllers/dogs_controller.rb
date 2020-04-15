class DogsController < ApplicationController

    def index
        user = User.find(session[:user_id])
        @dogs = user.dogs
    end

    def show
        @dog = Dog.find_by({ id: params[:id] }) 
        @dog_name = @dog.name
    end

    def new 
        @error_messages = flash[:error_messages]
        @dog = Dog.new
        @breeds = Breed.all 
        @feeding_times = FeedingTime.all
    end

    def create 
       
        @dog = Dog.create({
            name: params[:dog][:name],
            img_url: params[:dog][:img_url],
            user_id: @current_user.id,
            breed_id: params[:dog][:breed_id],
            feeding_time_ids: params[:dog][:feeding_time_ids]
        })

        if( @dog.valid? )
            redirect_to("/dogs/#{@dog.id}")
        else
            flash[:error_messages] = @dog.errors.full_messages
            redirect_to("/dogs/new")
        end
        
    end

    def edit 
        @dog = Dog.find(params[:id])
        @breeds = Breed.all 
        @feeding_times = FeedingTime.all
    end

    def update 
        @dog = Dog.find(params[:id])
        @dog.update({
            name: params[:dog][:name],
            img_url: params[:dog][:img_url],
            breed_id: params[:dog][:breed_id],
            feeding_time_ids: params[:dog][:feeding_time_ids]
        })
        redirect_to("/dogs/#{@dog.id}")
    end

    def destroy
        @dog = Dog.find(params[:id])
        @dog.destroy()
        redirect_to("/dogs")
    end

end