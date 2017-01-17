class MailerReport < ApplicationMailer
  def report_content(report)
    @report = report
    mail( to: "info@spefz.com",
          subject: "Spefz | <Report> Ref: #{report.reference} - #{report.category_report.name}", 
          from: "<no-reply@spefz.com>")
  end
end
