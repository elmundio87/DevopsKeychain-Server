require 'spec_helper'

describe SecureContentController, :type => :controller do

test_auth_header = "ItTnVYOezoLcjT1HBdmQCARuyWXbTDpkV+/v5tDL4253lL3U7VNzYLfYRyCd\nSko7yXawow/lHL+Io+dAc/ZtQpokFUm/+1OVT2CfYyJ+/78oLOmiyEG9XQJZ\nni6tLnXqyJ/Dw/QkNC7mZ8WwyZFIyRVl1RYPlozSLHW3dEuziYujdhdwh5z0\nlAT6KJtKhCjVOCnekrjoEuxoUmsJRGT75mA0zHUMjpbPFp2ph2MWmNuMxxFp\nHaPo7RJPcLSnArSHuSbfVvMR7U8CBMGAXWJZzSRpeI/JPK5FIRQHOAOTBkIS\nT/Ye+i6Tnlxm2Acq3NVCLZFP4pczts80Gc3FGSgd0Q=="
	
	describe "get password" do
		it "has a 400 status code if no parameters are passed in" do
			post :show
			expect(response.code).to match "400"
		end

		it "has a 400 status code if some parameters are missing" do
			post :show, 
			:deployment => "R9 Web", 
			:environment => "QA", 
			:securecontent => "Domain Password"

			expect(response.code).to match "400"
		end

		it "has a 500 status code if the auth header is nonsense" do
			post :show, 
			:deployment => "R9 Web", 
			:environment => "QA", 
			:securecontent => "Domain Password",
			:auth => "wibble"

			expect(response.code).to match "500"
		end

		it "has a 401 status code if the auth header is incorrect" do
			post :show, 
			:deployment => "R9 Web", 
			:environment => "QA", 
			:securecontent => "Domain Password",
			:auth => "ITTnVYOezoLcjT1HBdmQCARuyWXbTDpkV+/v5tDL4253lL3U7VNzYLfYRyCd\nSko7yXawow/lHL+Io+dAc/ZtQpokFUm/+1OVT2CfYyJ+/78oLOmiyEG9XQJZ\nni6tLnXqyJ/Dw/QkNC7mZ8WwyZFIyRVl1RYPlozSLHW3dEuziYujdhdwh5z0\nlAT6KJtKhCjVOCnekrjoEuxoUmsJRGT75mA0zHUMjpbPFp2ph2MWmNuMxxFp\nHaPo7RJPcLSnArSHuSbfVvMR7U8CBMGAXWJZzSRpeI/JPK5FIRQHOAOTBkIS\nT/Ye+i6Tnlxm2Acq3NVCLZFP4pczts80Gc3FGSgd0Q=="

			expect(response.code).to match "401"
		end

		it "has a 200 status code if the auth header is valid" do
			post :show, 
			:deployment => "R9 Web", 
			:environment => "Staging", 
			:securecontent => "Domain Password",
			:auth => "ItTnVYOezoLcjT1HBdmQCARuyWXbTDpkV+/v5tDL4253lL3U7VNzYLfYRyCd\nSko7yXawow/lHL+Io+dAc/ZtQpokFUm/+1OVT2CfYyJ+/78oLOmiyEG9XQJZ\nni6tLnXqyJ/Dw/QkNC7mZ8WwyZFIyRVl1RYPlozSLHW3dEuziYujdhdwh5z0\nlAT6KJtKhCjVOCnekrjoEuxoUmsJRGT75mA0zHUMjpbPFp2ph2MWmNuMxxFp\nHaPo7RJPcLSnArSHuSbfVvMR7U8CBMGAXWJZzSRpeI/JPK5FIRQHOAOTBkIS\nT/Ye+i6Tnlxm2Acq3NVCLZFP4pczts80Gc3FGSgd0Q=="

			expect(response.code).to match "200"
		end
	end

end
