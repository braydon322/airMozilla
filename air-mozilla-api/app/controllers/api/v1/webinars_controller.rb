module Api
  module V1
    class WebinarsController < ApplicationController

      # GET /webinars
     def index
       Booth.getData()
       # Booth.getUser()
       render :json => Webinar.all
     end

     def show
       @webinar = Webinar.find(params[:id])
       render json: @webinar, status: 201
     end

     # PUT /webinars/:id
     def update
       @webinar = Webinar.find(params["id"])
       Booth.getToken(@webinar)
       render json: Token.last, status: 201
     end

     private

     def webinar_params
       params.permit(:title, :url, :favicon, :date)
     end

    end
  end
end
