# TOTALS
totals = []

# Subtotal
totals << [pdf.make_cell(content: Spree.t(:subtotal)), invoice.display_item_total.to_s]

# Adjustments
invoice.adjustments.each do |adjustment|
  totals << [pdf.make_cell(content: adjustment.label), adjustment.display_amount.to_s]
end

# Shipments
invoice.shipments.each do |shipment|
  totals << [pdf.make_cell(content: shipment.shipping_method.name), shipment.display_cost.to_s]
end

# Totals
totals << [pdf.make_cell(content: Spree.t(:order_total)), invoice.display_total.to_s]

# Payments
total_payments = 0.0
invoice.payments.each do |payment|
  totals << [
    pdf.make_cell(
      content: Spree.t(:payment_via,
      gateway: (payment.source_type || Spree.t(:unprocessed, scope: :print_invoice)),
      number: payment.number,
      date: I18n.l(payment.updated_at.to_date, format: :long),
      scope: :print_invoice)
    ),
    payment.display_amount.to_s
  ]
  total_payments += payment.amount
end

totals_table_width = [0.875, 0.125].map { |w| w * pdf.bounds.width }

pdf.table(totals, column_widths: totals_table_width) do
  row(0..6).style align: :right
  column(0).style borders: [], font_style: :bold
end


# stamp
pdf.create_stamp("approved") do
        pdf.line_width = 2
        pdf.rotate(30, :origin => [-5, -5]) do
            pdf.stroke_color "FF3333"
            pdf.stroke_ellipse [0, 0], 29, 15
            pdf.stroke_color "000000"
            pdf.fill_color "993333"
            pdf.font("Times-Roman") do
                if invoice.printable.payment_state == "paid"
                  pdf.draw_text "paid", :at => [-12,-3], :size => 15, :style => :bold
                else
                  pdf.draw_text "unpaid", :at => [-22,-3], :size => 15, :style => :bold
                end
            end
            pdf.fill_color "000000"
        end
    end

    pdf.stamp_at "approved", [550, 170]
