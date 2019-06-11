module Washbullet
  class Pushable
    class PushList

      RETRIEVED_FIELDS = [:active, :iden, :created_at, :modified, :dismissed, :title, :url]
      PushedNote = Struct.new(*RETRIEVED_FIELDS, keyword_init: true)

      attr_reader :cursor, :pushes

      def initialize(parsed_response_body)
        @pushes = [].tap do |ary|
          parsed_response_body.fetch('pushes').each do |push|
            converted = convert_push_hash(push.with_indifferent_access)
            ary << converted
          end
        end
        @cursor = parsed_response_body['cursor']
      end

      private
      def convert_push_hash(push_hash)
        # {"active"=>false, "iden"=>"ujDxQkRQayqsjAkaGXvUl2", "created"=>1524220449.9982212, "modified"=>1560202385.450857, "dismissed"=>false}
        # {
        #             "active": true,
        #             "iden": "ujDxQkRQayqsx518153dbf72a97236c60019eea4e550affee64207f01254449096019df9c5cf7x",
        #             "created": 1526601808.409743,
        #             "modified": 1526628889.999557,
        #             "type": "link",
        #             "dismissed": true,
        #             "direction": "incoming",
        #             "sender_name": "Hacker News 500",
        #             "channel_iden": "ujxPklLhvyKsjAlhw4X3xA",
        #             "title": "LocationSmart Leaked Location Data for All Major U.S. Carriers in Real Time",
        #             "url": "https://news.ycombinator.com/item?id=17094213"
        #         }
        push_hash.slice(*RETRIEVED_FIELDS).symbolize_keys
      end
    end
  end
end
