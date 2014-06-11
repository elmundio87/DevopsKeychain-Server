class SecureContentController < ApplicationController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

def get

  deployment = Deployment.find_by(name: params[:deployment])
	environment = Environment.find_by_name_and_deployment_id(params[:environment], deployment.id)
	content = SecureContent.find_by_name_and_environment_id(params[:securecontent], environment.id)[:encrypted_content]
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

def update

   password = SecureContent.find_by_id(:id => params[:secure_content][:id])

  if params[:commit] == "Update"
    flash[:notice] = "#{password[0][:name]} has been successfully updated for the environment #{password.environment.name}."
    password.update_all(:encrypted_content => SymmetricEncryption.encrypt(params[:secure_content][:content]))
  elsif params[:commit] == "Delete"
    flash[:notice] = "#{params[:secure_content][:name]} has been successfully deleted."
    password.destroy()
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
