Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :orders do
      resources :bookkeeping_documents, controller: 'orders/bookkeeping_documents', only: [:index, :create, :show] do
        collection do
          delete 'destroy', to: 'orders/bookkeeping_documents#destroy', as: :destroy
        end
      end
    end
    resource :print_invoice_settings, only: [:edit, :update]
    resources :bookkeeping_documents, only: :index
  end
end
