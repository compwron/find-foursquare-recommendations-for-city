require 'json'

in_texas = {}
to_s = File.read("checkins.json").to_s
JSON.parse(to_s).each { |c|
  response = c["response"]
  checkins = response["checkins"]
  items = checkins["items"]

  items.each { |e|
    if e.keys.include?("venue")
      venue = e["venue"]
      location = venue["location"]
      state = location["state"]
      if state == "TX" && location["city"] == "Dallas"
        name = venue["name"]
        in_texas[name] = location["formattedAddress"]
      end
    end
  }
}

in_texas.sort_by { |name, address| name }.each { |name, address|
  puts name + ", " + address[0] + ","
}
