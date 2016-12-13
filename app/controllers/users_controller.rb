class UsersController < ApplicationController

  require 'json' 
  require 'rest_client'

  # base url of the API
  API_BASE_URL = "http://localhost:3000" 		# used on localhost
  #API_BASE_URL = "https://aqueous-ocean-76425.herokuapp.com"		# used on Heroku server
  
  # GET /user.json
  # GET /users.json
  def index
    if params[:single]
	  url = "#{API_BASE_URL}/users/#{params[:id]}.json"
	  response = RestClient.get(url)
	  @user = JSON.parse(response.body)
	else
	  url = "#{API_BASE_URL}/users.json"	  
      response = RestClient.get(url)
      @users = JSON.parse(response.body)		  
	end
  end

  def new
	url = "#{API_BASE_URL}/users.json" 
    response = RestClient.get(url)
    @users = JSON.parse(response.body)     
  end

  def create
    url = "#{API_BASE_URL}/users.json"
    begin
	  RestClient.post(url, :user => params, :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'} )
	  flash[:success] = "User created successfully"
	  redirect_to new_user_path
	rescue Exception => e
	  flash[:danger] = "User failed to create"
	  render :new
	end
  end
 
  def edit
	url = "#{API_BASE_URL}/users/#{params[:id]}.json" 
    response = RestClient.get(url)
    @user = JSON.parse(response.body)     
  end 
  
  def update
    url = "#{API_BASE_URL}/users/#{params[:id]}.json"
    begin
	  RestClient.put(url, :user => params, :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'} )
	  flash[:success] = "User updated successfully"
	  redirect_to new_user_path
	rescue Exception => e
	  flash[:danger] = "User failed to update"
	  render :edit
	end
  end
  
  def destroy
    url = "#{API_BASE_URL}/users/#{params[:id]}.json"
    begin
	  RestClient.delete(url)
	  flash[:success] = "User deleted successfully"
	  redirect_to new_user_path
	rescue Exception => e
	  flash[:danger] = "User failed to delete"
	  render :edit
	end
  end  
  
  def user_menu
  end
  
  def about
  end  
  
end


