# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

file_path = Rails.root.join('db', 'seeds_data.json')
json_data = File.read(file_path)

begin
  data = JSON.parse(json_data)
rescue JSON::ParserError => e
  puts "Error parsing JSON: #{e.message}"
  exit
end

puts "Data length is: #{data.size}"

data.each do |registry_data|
  # Normalize status to lowercase and map it to enum
  status = registry_data['status'].downcase
  puts "registry status is #{status}"
  if Registry.statuses.key?(status)
    Registry.find_or_create_by(source: registry_data['source']) do |registry|
      registry.destination = registry_data['destination']
      registry.status = status
      registry.confidential = registry_data['confidential']
    end
  else
    puts "Invalid status '#{registry_data['status']}' for registry with source '#{registry_data['source']}'"
  end
end
