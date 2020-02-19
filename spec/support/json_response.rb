module Support
  module JSONResponse
    def json_response
      JSON.parse(response.body).with_indifferent_access
    end
  end
end
