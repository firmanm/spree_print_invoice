module Spree
  module Admin
    module Orders
      class BookkeepingDocumentsController < ResourceController
        before_action :load_order
        before_action :load_document, :only => [:show]
        before_action :load_documents, :only => [:index, :destroy]

        def show
          respond_with(@bookkeeping_document) do |format|
            format.pdf do
              send_data @bookkeeping_document.pdf, type: 'application/pdf', :x_sendfile => false, disposition: 'inline'
            end
          end
        end

        def index
        end

        def create
          @order.invoice_for_order!

          respond_with(@order) do |format|
            format.html { redirect_to spree.admin_order_bookkeeping_documents_path(@order.number) }
          end
        end

        def destroy
          @bookkeeping_documents.each { |bd| bd.destroy }

          respond_with(@order) do |format|
            format.html { redirect_to spree.admin_order_bookkeeping_documents_path(@order.number) }
          end
        end

        private

        def model_class
          @model_class ||= Spree::BookkeepingDocument
        end

        def load_order
          @order = Spree::Order.find_by(number: params[:order_id])
        end

        def load_document
          @bookkeeping_document = Spree::BookkeepingDocument.find(params[:id])
        end

        def load_documents
          @bookkeeping_documents = Spree::BookkeepingDocument.where(printable: @order)
        end
      end
    end
  end
end
