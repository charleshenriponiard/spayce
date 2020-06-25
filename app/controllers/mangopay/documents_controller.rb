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
      @mp_document.create_document
      # render :new unless @mp_document.valid?
      @mp_document.create_file
      @mp_document.submit_document
      @mp_document.get_docs

      if response["error"]
        @mp_document.errors.messages.merge!(response["errors"])
        render :new
      else
        redirect_to root_path
      end 
    end

    private 

    def mangopay_document_params
      params.require(:mangopay_document).permit(:type, :file)
    end 

  end
end

