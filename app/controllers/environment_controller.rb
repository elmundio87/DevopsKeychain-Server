class EnvironmentController < ApplicationController

	def update

		require 'base64'

		key_pair = generate_keys()

		environment = Environment.find_by(id: params[:environment][:id])
		environment.update(public_key: Base64.encode64(key_pair[0]))

		filename = "#{environment.deployment.name}-#{environment.name}.pem"

		send_data key_pair[1], :filename => filename

	end


	def generate_keys()

		require 'openssl'
		rsa_key = OpenSSL::PKey::RSA.new(2048)

		cipher =  OpenSSL::Cipher::Cipher.new('des3')

		private_key = rsa_key.to_pem(cipher,'password')
		public_key = rsa_key.public_key.to_pem
		key_pair = [public_key,private_key]

		return key_pair
		
	end

	def create

		if(!has_permission?(current_user.id,params[:deployment_id]))
			forbidden
			return
		end

		if(params[:name].strip() === "")
			flash[:alert] = "An environment name cannot be blank"
			redirect_to :back
			return
		end

		@environment = Environment.new(name: params[:name], deployment_id: params[:deployment_id])

		begin
			@environment.save
		rescue ActiveRecord::RecordNotUnique => e
			flash[:alert] = "An environment called '#{params[:name]}' already exists."
		end

		redirect_to :back
	end


end
