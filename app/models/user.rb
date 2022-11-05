# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]

  has_many :spendings

  validates :username, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_\.]+\z/ }

  after_create -> { self.update(uuid: SecureRandom.uuid) }

  def filtered_spendings(params)
    case params[:filter]
    when 'amount'
      spendings.order(amount_cents: :desc)
    when 'category'
      spendings.with_category(params[:category])
    else
      spendings
    end
  end

  # Allow to sign in with email or username
  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                    { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end
end
