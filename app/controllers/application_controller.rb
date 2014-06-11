class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  def public_encrypt(key, plaintext_string)

  	require 'openssl'
  	require 'base64'

  	public_key_file = Base64.decode64(key)

  	public_key = OpenSSL::PKey::RSA.new(public_key_file)
  	encrypted_string = Base64.encode64(public_key.public_encrypt(plaintext_string))

  	return encrypted_string

  end

  def public_decrypt (key, encrypted_string)

  	require 'openssl'
  	require 'base64'

  	public_key_file = Base64.decode64(key)
  	public_key = OpenSSL::PKey::RSA.new(public_key_file)
  	encrypted_string = Base64.decode64(encrypted_string)

  	return public_key.public_decrypt(encrypted_string)

  end


end
