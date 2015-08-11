require 'spec_helper'

describe SoportesEnviadoController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
