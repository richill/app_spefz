class Management < ActiveRecord::Base
  belongs_to :event

  def ticket_sales
    self.event.payments.count * self.event.price
  end

  def cost_host
    self.event.host.users.count * 50
  end

  def vat
    ticket_sales * 0.20
  end

  def revenue
    ticket_sales - (self.venuecost + cost_host + vat)
  end

  def deposit
    1000
  end

  def profit
    revenue - deposit
  end
end
