module Api::Flickr
  private
    def conn
      Faraday.new('https://api.flickr.com/services/rest/') do |f|
        f.headers['Content-Type'] = 'application/json'
        f.adapter  Faraday.default_adapter
      end
    end

    def get_json(options)
      response = conn.get(url=nil, options)
      JSON.parse(response, symbolize_names: true)
    end
end
