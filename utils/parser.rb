class Parser

  def self.parse(obj)
    begin
      JSON.parse(obj)
    rescue
      halt 400, { message:'Invalid JSON' }.to_json
    end
  end
end