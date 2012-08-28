# encoding: utf-8
class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :message, type: String
  field :name, type: String
  field :subject, type: String
  #field :created_at, type: DateTime
  #field :updated_at, type: DateTime

  def to_s
    #"Contact Us message from %{self.email.present? ? self.email : self.name rescue self.created_at.strftime('%Y-%m-%d %H:%M:%S')}"
    "Contact Us message from #{self.email.present? ? self.email : (self.name || self.created_at.strftime('%c') ) rescue self.created_at.strftime('%c')}"
  end
end
