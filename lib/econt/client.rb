# demo user & pass 'iasp-dev'

module Econt
  class Client
    SERVICE_URL_DEMO = 'http://demo.econt.com'
    SERVICE_URL = 'http://www.econt.com'

    attr_accessor :username, :password, :service_url, :builder_obj

    def initialize(username, password, demo = true)
      @username = username
      @password = password
      @service_url = demo ? SERVICE_URL_DEMO : SERVICE_URL
    end

    def build(service)
      case service
      when :tarrif
        @builder_obj = Econt::Builder::Tarrif.new(username, password)
        @builder_obj.build
      end
    end

    def send
      conn = Faraday.new(url: service_url) do |c|
        c.request  :url_encoded
        c.response :xml, content_type: /\bxml$/
        c.adapter Faraday.default_adapter
      end

      response = conn.post( builder_obj.path, { xml: builder_obj.xml.to_xml } )
    end
  end
end
