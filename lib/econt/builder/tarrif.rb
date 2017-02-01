module Econt
  module Builder
    class Tarrif
      attr_accessor :path, :xml, :username, :password

      def initialize(username, password)
        @path = '/e-econt/xml_parcel_import2.php'
        @username = username
        @password = password
      end

      def build
        @xml = Nokogiri::XML::Builder.new { |x|
          x.parcels do
            x.system do
              x.validate 1
              x.response_type 'xml'
              x.only_calculate 1
              x.process_all_parcels 0
              x.email_errors_to 1
            end
            x.client do
              x.username username
              x.password password
            end
            x.loadings do
              x.row do
                x.sender do
                  x.country_code 'BUL'
                  x.city 'Пловдив'
                  x.post_code '4000'
                  x.office_code '4007'
                  x.name 'Дипол'
                  x.name_person 'Добромир Минчев'
                  x.phone_num '0888 111 222'
                end

                x.receiver do
                  x.country_code 'BUL'
                  x.city 'София'
                  x.post_code '1000'
                  x.office_code '1127'
                  x.name 'Иван'
                  x.name_person 'Иван Петров'
                  x.phone_num '0888 111 222'
                end

                x.shipment do
                  x.shipment_type 'PACK'
                  x.description 'Тест'
                  x.pack_count '1'
                  x.weight '1'
                  x.tariff_sub_code 'OFFICE_OFFICE'
                end
              end
            end
          end
        }
      end
    end
  end
end
