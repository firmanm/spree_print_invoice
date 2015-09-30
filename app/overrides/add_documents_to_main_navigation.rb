Deface::Override.new(
  virtual_path:  'spree/layouts/admin',
  insert_bottom: '#main-sidebar',
  name:          'documents_tab',
  partial:       'spree/admin/shared/menu/documents_tab'
)
