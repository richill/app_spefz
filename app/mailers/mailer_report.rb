class MailerReport < ApplicationMailer
  def report_content(report)
    @report = report
    mail( to: "info@africanjober.com",
          subject: "Spefz | <Report> Ref: #{report.reference} - #{report.category_report.name}", 
          from: "<no-reply@africanjober.com>")
  end
end
