RSpec.shared_examples 'a valid JSON schema' do |schema|
  it 'validates the JSON response against the schema' do
    expect(response).to match_response_schema(schema)
  end
end
