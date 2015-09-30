Deface::Override.new(
  virtual_path: 'spree/admin/shared/_order_tabs',
  name:         'print_invoice_order_tab_links',
  insert_bottom: '[data-hook="admin_order_tabs"]',
  text: %q{
   <% if ((can? :show, Spree::Order) && (@order && @order.completed?)) %>
     <li<%== ' class="active"' if current == :documents %> data-hook='admin_order_tabs_documents'>
       <%= link_to_with_icon 'file', Spree.t('print_invoice.documents'), spree.admin_order_bookkeeping_documents_path(@order) %>
     </li>
   <% end %>
  }
)
