class MessageEncryptor
  def initialize
    base = if Rails.env.development? || Rails.env.test?
             Rails.application.secrets.secret_key_base[0..31]
           else
             Rails.application.secret_key_base[0..31]
           end
    @crypt = ActiveSupport::MessageEncryptor.new(base)
  end

  def decrypt(uuid)
    JSON.parse(@crypt.decrypt_and_verify(uuid)).symbolize_keys
  end

  def encrypt_and_sign(message)
    @crypt.encrypt_and_sign(message)
  end
end
