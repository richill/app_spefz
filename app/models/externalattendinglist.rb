class Externalattendinglist < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event

  before_create :generate_reference_number

  scope :events_with_cards, -> { select {|attendinglist| attendinglist.event.card.present? }} #[3]

  # scope :events_with_cards, -> { select {|attendinglist| attendinglist.event.card.present? }} #[3]

  # scope :booked_events_with_cards, -> (user) { joins(:card, payments: :user).where(users: { id: user.id }) }

  scope :events_without_cards, -> { select {|attendinglist| attendinglist.event.card.nil? }} #[1: event_id:4]

  def generate_reference_number
    begin
      reference_length = 6
      self.reference = "SPz_" + Devise.friendly_token.first(reference_length)
    end while self.class.exists?(reference: reference)
  end
end
