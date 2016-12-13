class PhotosController < ApplicationController

  require 'json' 
  require 'rest_client'

  # base url of the API 
  API_BASE_URL = "http://localhost:3000/api/v1"		# used on localhost
  #API_BASE_URL = "https://aqueous-ocean-76425.herokuapp.com/api/v1"	# used on Heroku server
 
  # GET /photo.json
  # GET /photos.json
  def index
    if params[:single]
	  url = "#{API_BASE_URL}/photos/#{params[:id]}.json?token=#{ENV['API_KEY']}"
	  response = RestClient.get(url)
	  @photo = JSON.parse(response.body)
	else
	  url = "#{API_BASE_URL}/photos.json?token=#{ENV['API_KEY']}"
      response = RestClient.get(url)
      @photos = JSON.parse(response.body)		  
	end
  end
  
  def new
	url = "#{API_BASE_URL}/photos.json?token=#{ENV['API_KEY']}"
	response = RestClient.get(url)
	@photos = JSON.parse(response.body)    
  end

  def show
  	url = "#{API_BASE_URL}/photos/#{params[:id]}.json?token=#{ENV['API_KEY']}"
	response = RestClient.get(url)
	@photo = JSON.parse(response.body)
  end
  
  def create
    url = "#{API_BASE_URL}/photos.json?token=#{ENV['API_KEY']}"
    begin
	  RestClient.post(url, :photo => params, :headers => { 'Content-Type' => 'multipart/form-data' })	
	  flash[:success] = "Photo uploaded successfully"
	  redirect_to new_photo_path
	rescue Exception => e
	  flash[:danger] = "Photo failed to upload"
	  render :new
	end
  end
 
  def edit
	url = "#{API_BASE_URL}/photos/#{params[:id]}.json?token=#{ENV['API_KEY']}" 
    response = RestClient.get(url)
    @photo = JSON.parse(response.body)     
  end 
  
  def update
    url = "#{API_BASE_URL}/photos/#{params[:id]}.json?token=#{ENV['API_KEY']}"
    begin
	  RestClient.put(url, :photo => params, :headers => { 'Content-Type' => 'multipart/form-data' })
	  flash[:success] = "Photo updated successfully"
	  redirect_to new_photo_path
	rescue Exception => e
	  flash[:danger] = "Photo failed to update"
	  render :edit
	end
  end
  
  def destroy
    url = "#{API_BASE_URL}/photos/#{params[:id]}.json?token=#{ENV['API_KEY']}"
    begin
	  RestClient.delete(url)
	  flash[:success] = "Photo deleted successfully"
	  redirect_to new_photo_path
	rescue Exception => e
	  flash[:danger] = "Photo failed to delete"
	  render :edit
	end
  end  
  
  def photo_menu
  end

end


