require 'rails_helper'

describe BackgroundService do
  let(:params) {
    {location: 'denver,co'}
  }

  let(:background_service) {
    BackgroundService.new(params[:location])
  }

  it 'receives list of popular photos from flickr' do
    expected = {
                "photos": {
                    "page": 1,
                    "pages": 1009786,
                    "perpage": 1,
                    "total": "1009786",
                    "photo": [
                        {
                            "id": "33433751038",
                            "owner": "62401943@N06",
                            "secret": "1ccce834d9",
                            "server": "7884",
                            "farm": 8,
                            "title": "Denver skyline",
                            "ispublic": 1,
                            "isfriend": 0,
                            "isfamily": 0
                        }
                    ]
                },
                "stat": "ok"
            }

    expect(background_service.get_photos).to eq(expected)
  end
end
