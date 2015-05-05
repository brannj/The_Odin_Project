require 'socket'                # Get sockets from stdlib.

server = TCPServer.open(2000)   # Socket to listen on port 2000.
1.times do                         # Servers run forever.
  client = server.accept        # Wait for a client to connect.
  request = client.gets.split(" ")
  method, path, version = request[0..2]
  p method
  p path
  p version
  client.close                  # Disconnect from the client.
end
