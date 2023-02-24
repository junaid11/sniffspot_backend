module Api
  module V1
    class ApiSchema
      include JSON::SchemaBuilder
    
      def self.definitions
        object do
          key :id, type: :integer, required: true
          key :title, type: :string, required: true
          key :description, type: :string, required: true
          key :images, type: :array, items: object do
            key :url, type: :string, required: true
          end
          key :price, type: :number, required: true
        end
      end

      def self.index_response_schema
        object do
          key :spots, type: :array, items: definitions
        end
      end

      def self.show_response_schema
        definitions
      end

      def self.create_request_schema
        object do
          key :title, type: :string, required: true
          key :description, type: :string, required: true
          key :images, type: :array, items: object do
            key :url, type: :string, required: true
          end
          key :price, type: :number, required: true
        end
      end

      def self.index_response_schema
        object do
          key :spots, type: :array, items: definitions
        end
      end

      def self.show_response_schema
        definitions
      end

      def self.create_request_schema
        object do
          key :title, type: :string, required: true
          key :description, type: :string, required: true
          key :images, type: :array, items: object do
            key :url, type: :string, required: true
          end
          key :price, type: :number, required: true
        end
      end

      def self.update_request_schema
        object do
          key :title, type: :string
          key :description, type: :string
          key :images, type: :array, items: object do
            key :url, type: :string
          end
          key :price, type: :number
        end
      end

      def self.review_request_schema
        object do
          key :rating, type: :integer, required: true
          key :comment, type: :string
        end
      end

      def self.review_response_schema
        object do
          key :id, type: :integer, required: true
          key :rating, type: :integer, required: true
          key :comment, type: :string
        end
      end
    end
  end
end
