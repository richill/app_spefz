class MailerContactus < ApplicationMailer
  def contact_us(contact)
    @contact = contact
    mail( to: "info@spefz.com",
          subject: "Spefz | <Client Enquiries> Ref: #{contact.reference} - #{contact.category_enquiry.name}", 
          from: "<no-reply@spefz.com>")
  end
end

