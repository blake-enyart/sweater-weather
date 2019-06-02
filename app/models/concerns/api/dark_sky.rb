module Api::DarkSky
  private

    def self.conn
      Faraday.new('https://api.darksky.net/forecast/') do |f|
        f.adapter  Faraday.default_adapter
      end
    end

    def self.get_json(key, latitude, longitude)
      response = conn.get("#{key}/#{latitude},#{longitude}")
      JSON.parse(response.body, symbolize_names: true)
    end
end
