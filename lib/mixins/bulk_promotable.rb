# frozen_string_literal: true

# Shares behavior with bulk-related promotions
module BulkPromotable
  BULK_QUANTITY = 3

  def applicable?(item)
    super(item.product) && item.quantity >= BULK_QUANTITY
  end
end
