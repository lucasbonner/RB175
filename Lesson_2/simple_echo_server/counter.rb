require "socket"

def parse_request(request_line)
  split_up = request_line.split

  http_method = split_up[0]
  path = split_up[1][0]
  params = {}
  arr = (split_up[1][2..-1] || "").split('&')

  arr.each do |elem|
    key, value = elem.split('=')
    params[key] = value
  end

  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  next unless request_line

  http_method, path, params = parse_request(request_line)

  client.puts "HTTP/1.0 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"

  client.puts "<h1>Counter</h1>"

  number = params["number"].to_i

  client.puts "<p>The current number is #{number}.</p>"

  client.puts "<a href='?number=#{number + 1}'>Click to increase number!</a>"
  client.puts "<a href='?number=#{number - 1}'>Click to decrease number!</a>"
  client.puts "</body"
  client.puts "</html>"
  client.close
end