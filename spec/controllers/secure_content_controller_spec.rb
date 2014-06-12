require 'spec_helper'

describe SecureContentController, :type => :controller do

	before(:each) do
		sign_in User.all[0]
	end


	test_auth_header = "ItTnVYOezoLcjT1HBdmQCARuyWXbTDpkV+/v5tDL4253lL3U7VNzYLfYRyCd\nSko7yXawow/lHL+Io+dAc/ZtQpokFUm/+1OVT2CfYyJ+/78oLOmiyEG9XQJZ\nni6tLnXqyJ/Dw/QkNC7mZ8WwyZFIyRVl1RYPlozSLHW3dEuziYujdhdwh5z0\nlAT6KJtKhCjVOCnekrjoEuxoUmsJRGT75mA0zHUMjpbPFp2ph2MWmNuMxxFp\nHaPo7RJPcLSnArSHuSbfVvMR7U8CBMGAXWJZzSRpeI/JPK5FIRQHOAOTBkIS\nT/Ye+i6Tnlxm2Acq3NVCLZFP4pczts80Gc3FGSgd0Q=="
	
	describe "get password" do
		it "has a 400 status code if no parameters are passed in" do
			post :show
			expect(response.code).to match "400"
		end

		it "has a 400 status code if some parameters are missing" do
			post :show, 
			:deployment => "Deployment1", 
			:environment => "QA", 
			:securecontent => "Password1"

			expect(response.code).to match "400"
		end

		it "has a 401 status code if the auth header is incorrect" do
			post :show, 
			:deployment => "Deployment1", 
			:environment => "QA", 
			:securecontent => "Password1",
			:auth => "ITTnVYOezoLcjT1HBdmQCARuyWXbTDpkV+/v5tDL4253lL3U7VNzYLfYRyCd\nSko7yXawow/lHL+Io+dAc/ZtQpokFUm/+1OVT2CfYyJ+/78oLOmiyEG9XQJZ\nni6tLnXqyJ/Dw/QkNC7mZ8WwyZFIyRVl1RYPlozSLHW3dEuziYujdhdwh5z0\nlAT6KJtKhCjVOCnekrjoEuxoUmsJRGT75mA0zHUMjpbPFp2ph2MWmNuMxxFp\nHaPo7RJPcLSnArSHuSbfVvMR7U8CBMGAXWJZzSRpeI/JPK5FIRQHOAOTBkIS\nT/Ye+i6Tnlxm2Acq3NVCLZFP4pczts80Gc3FGSgd0Q=="

			expect(response.code).to match "401"
		end

		it "has a 200 status code if the auth header is valid" do
			post :show, 
			:deployment => "Deployment1", 
			:environment => "Staging", 
			:securecontent => "Password1",
			:auth => <<-EOH
2nMD984CbTmiTwPKNMn5c3lZKq+n9ynn0ShHIAFIxvwXGCxslUsdYukGpGFN
HRamzQdG0R6+S1BKiNIB70nr9kij2+Krap1m18aq9+3RL4Qq9D4wmxDuNMJx
A2K07zAs68GTabuSrP1I6MO8VRhNP3zewG9i2bP5mjyYJMwx1+4oSGJ8S3h8
R9a5vCd6pC/+fw2iRWGaFWgHw7C4hxzHsxRmniBLhHed//lrrtofQitEo8fo
icxhtLp0RjOtkMJpkVw70x2o7HT/s2L2RMPOAHxYyIuMIO0+dLVY9kLksL/g
bQGyXElf8Q6hZ8VABKVpjmWsVriGWkYaXQI28bBGLA==
EOH

			expect(response.code).to match "200"
		end
	end

	describe "new password" do
		it "redirects to previous page upon completion" do
			request.env["HTTP_REFERER"] = "http://test.host"
			get :new
			expect(response.code).to match "302"
			expect(response).to redirect_to :back
		end

	end

end
