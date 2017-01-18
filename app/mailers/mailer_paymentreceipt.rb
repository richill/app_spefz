class MailerPaymentreceipt < ApplicationMailer
  def paymentreceipt_content(@payment)
    @payment = payment
    mail( to: "info@spefz.com",
          subject: "Spefz | <Report> Ref: #{payment.reference}", 
          from: "<no-reply@spefz.com>")
  end
end
