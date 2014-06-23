class SecureContentController < ApplicationController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

  def show

    begin
      deployment = Deployment.find_by(name: params[:deployment])
      environment = Environment.find_by_name_and_deployment_id(params[:environment], deployment.id)
      content = SecureContent.find_by_name_and_environment_id(params[:securecontent], environment.id)[:encrypted_content]
      if(params[:auth].nil?)
        raise "Missing auth header"
      end  
    rescue
      render :file => "public/400", :status => 400
     return
    end

    keychain_auth = params[:auth]
    public_key = environment[:public_key]

    if( params[:securecontent] === public_decrypt(public_key,keychain_auth))
      send_data public_encrypt(public_key,SymmetricEncryption.decrypt(content))
    else
      render :file => "public/401", :status => :unauthorized
    end

  end

  def update

   password = SecureContent.find_by(:id => params[:secure_content][:id])

   if params[:commit] == "Update"
    flash[:notice] = "#{password[0][:name]} has been successfully updated for the environment #{password.environment.name}."
    password.update_all(:encrypted_content => SymmetricEncryption.encrypt(params[:secure_content][:content]))
  elsif params[:commit] == "Delete"
    flash[:notice] = "#{params[:secure_content][:name]} has been successfully deleted."
    password.destroy()
  else
     render :file => "public/400", :status => 400
     return
  end

  redirect_to :back

end

def create

  flash[:notice] = "Added the password: #{params[:environment][:name]}."
  SecureContent.create(:name => params[:environment][:name], :content => params[:environment][:content], :environment_id => params[:environment][:environment_id])

  redirect_to :back

end


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
  rescue
    return nil
  end

end
