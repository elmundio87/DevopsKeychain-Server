class SecureContentController < ApplicationController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

def get

  deployment = Deployment.find_by(name: params[:deployment])
	environment = Environment.find_by_name_and_deployment(params[:environment], deployment.id)
	content = SecureContent.find_by_name_and_environment(params[:securecontent], environment.id)[:encrypted_content]
	public_key = environment[:public_key]

  keychain_auth = params[:auth]

  if(keychain_auth.blank?)
    render :file => "public/500", :status => :unauthorized
    return
  end


  if( params[:securecontent] == public_decrypt(public_key,keychain_auth))
      send_data public_encrypt(public_key,SymmetricEncryption.decrypt(content))
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

   password = SecureContent.where(:id => params[:secure_content][:id])
   environment = Environment.where(:id => password[0].environment)[0]

  if params[:commit] == "Update"
    flash[:notice] = "#{password[0][:name]} has been successfully updated for the environment #{environment.name}."
    password.update_all(:encrypted_content => SymmetricEncryption.encrypt(params[:secure_content][:content]))
  elsif params[:commit] == "Delete"
    flash[:notice] = "#{params[:secure_content][:name]} has been successfully deleted."
    password.delete_all()
  else
    flash[:alert] = "Invalid request"
  end

  redirect_to :back

end

def new

    flash[:notice] = "Added the password: #{params[:name]}."
    SecureContent.create(:name => params[:name], :content => params[:content], :owner => current_user.id)

    redirect_to :back

end



end
