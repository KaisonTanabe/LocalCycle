require 'open-uri'
require 'json'
require 'yaml'

results = Hash.new
1..1000.times do |i|
  url = "https://www.farmersweb.com/svc/Category/getChildren?parent_id=#{i}"
  puts url
  begin
    json = open(url) {|io| io.read}
  rescue OpenURI::HTTPError
    next
  end
  hash = JSON.parse(json)
  results[i] = hash
end

File.open('farmers.json','w') {|file| file.write(results.to_json) }
