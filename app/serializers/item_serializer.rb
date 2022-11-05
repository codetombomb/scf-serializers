class ItemSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper
  attributes(:id, :name, :desc, :price, :status)
  belongs_to :seller


  def price
    # "$" + '%.2f' % self.object.price
    number_to_currency(self.object.price)
  end


  def status
    if self.object.sold
      "Sold"
    else
      'Buy Now'
    end
  end
end
