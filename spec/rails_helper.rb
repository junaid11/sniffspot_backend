require 'support/api/v1/api_schema'

RSpec.configure do |config|
    config.include RequestHelpers, type: :request
end
