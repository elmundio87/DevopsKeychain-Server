class SecureContentController < ApplicationController

  skip_before_filter :verify_authenticity_token

def get

	user = User.find_by(email: params[:email])
	content = SecureContent.find_by_name_and_owner(params[:securecontent], user[:id])[:content]
	public_key = user[:pub_key]

  keychain_auth = params[:auth]

  if(keychain_auth.blank?)
    render :file => "public/500", :status => :unauthorized
    return
  end


  if( user[:email] == public_decrypt(public_key,keychain_auth))
      send_data public_encrypt(public_key,content)
  else
    render :file => "public/401", :status => :unauthorized
  end

end

def public_encrypt(key, plaintext_string)

	require 'openssl'
	require 'base64'

	public_key_file = Base64.decode64(key)

	public_key = OpenSSL::PKey::RSA.new(public_key_file)
	encrypted_string = Base64.encode64(public_key.public_encrypt(plaintext_string))

	return encrypted_string

end

def private_encrypt(key, plaintext_string)

    require 'openssl'
    require 'base64'

    private_key_file = Base64.decode64(key)

    password = "password"
    private_key = OpenSSL::PKey::RSA.new(public_key_file,password)
    encrypted_string = Base64.encode64(private_key.private_encrypt(plaintext_string))

    return encrypted_string

  end


def private_decrypt (key, encrypted_string)

	require 'openssl'
	require 'base64'

	password = 'password'
	private_key = OpenSSL::PKey::RSA.new(key,password)

	return private_key.private_decrypt(Base64.decode64(encrypted_string))

end

def public_decrypt (key, encrypted_string)

  require 'openssl'
  require 'base64'

  public_key_file = Base64.decode64(key)
  public_key = OpenSSL::PKey::RSA.new(public_key_file)
  encrypted_string = Base64.decode64(encrypted_string)

  return public_key.public_decrypt(encrypted_string)

end

def update


    puts params

  if params[:commit] == "Update"
    flash[:notice] = "#{params[:secure_content][:name]} has been successfully updated."
    SecureContent.where(:name => params[:secure_content][:name]).update_all(:content => params[:secure_content][:content])
  elsif params[:commit] == "Delete"
    flash[:notice] = "#{params[:secure_content][:name]} has been successfully deleted."
    SecureContent.where(:name => params[:secure_content][:name]).delete_all()
  else
    flash[:alert] = "Invalid request"
  end

  redirect_to :back
end


end
