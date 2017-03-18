class Management < ActiveRecord::Base
  belongs_to :event

  def ticket_sales
    self.event.payments.count * self.event.price
  end

  def host_count
    if self.event.host == nil
      0
    else
      self.event.host.users.count
    end
  end

  def host_cost
    if self.event.host == nil
      0 * 50
    else
      self.event.host.users.count * 50
    end
  end

  def vat
    ticket_sales * 0.20
  end

  def revenue
    ticket_sales - (self.venuecost + host_cost + vat)
  end

  def deposit
    1000
  end

  def profit
    revenue - deposit
  end
end
