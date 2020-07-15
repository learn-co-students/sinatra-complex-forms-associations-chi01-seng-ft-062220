class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(name: params["pet_name"])
    if params["owner_name"] != nil
      @owner = Owner.find_by(name: params["owner_name"])
      
    elsif params["owner"]["name"].empty? == false
      @owner = Owner.create(name: params["owner"]["name"])
      
    end
    @pet.update(owner_id: @owner.id)
    redirect to "/pets/#{@pet.id}"
  end
  
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner = Owner.find_by_id("#{@pet.owner_id}")
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  
  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    
    if params["owner"]["name"].empty? == false
      @owner = Owner.create(name: params["owner"]["name"])
      params["pet"]["owner_id"] = @owner.id
      @pet.update(params["pet"])
    else
      @pet.update(params["pet"])
    end
    redirect to "pets/#{@pet.id}"
  end
end