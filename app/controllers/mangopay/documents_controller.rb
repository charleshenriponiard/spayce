require "base64"

module Mangopay
  class DocumentsController < MangopaysController
    
    def new
      raise MangopayError.new(message: "#mp_user_id can't be blank") if current_user.mp_user_id.blank?
      @mp_document = Mangopay::Document.new()
    end

    def create
      @mp_document = Mangopay::Document.new(mangopay_document_params)
      @mp_document.mp_user_id = current_user.mp_user_id
      @mp_document.save
      if @mp_document.valid? 
        redirect_to root_path
      else
        render :new
      end
    end

    private 

    def mangopay_document_params
      params.require(:mangopay_document).permit(:type)
    end 

  end
end

