module Spree
  module Admin
    class BookkeepingDocumentsController < ResourceController

      def index
        # Massaging the params for the index view like Spree::Admin::Orders#index
        params[:q] ||= {}
        @search = Spree::BookkeepingDocument.ransack(params[:q])
        @bookkeeping_documents = @search.result
        @bookkeeping_documents = @bookkeeping_documents.page(params[:page] || 1).per(10)
      end

    end
  end
end
