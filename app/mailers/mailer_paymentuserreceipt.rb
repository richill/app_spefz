class MailerPaymentuserreceipt < ApplicationMailer
  def paymentreceipt(payment)
    @payment = payment
    mail( to: "#{payment.email}",
          subject: "Spefz | Your Spefz Receipt", 
          from: "<no-reply@spefz.com>")
  end
end
