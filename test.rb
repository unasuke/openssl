require 'socket'
require 'openssl'
include OpenSSL

# soc = UDPSocket.new('www.example.com', 443)
soc = UDPSocket.new
cert = OpenSSL::X509::Certificate.new(File.binread('tmp/rootcert.pem'))
pkey = OpenSSL::PKey.read(File.binread('tmp/rootkey.pem'))
ctx = OpenSSL::SSL::SSLContext.new
ctx.add_certificate(cert, pkey)
# binding.irb
# soc.connect('nghttp2.org', 443)
soc.bind('localhost', 0)
soc.connect('localhost', 6121)
# pp soc.addr
pp "connect done"
ssl = SSL::SSLSocket.new(soc, ctx)
# pp "ssl sockert #{ssl.inspect}"
pp ssl
# pp ssl.context.options
ssl.connect
pp "ssl connect done"
# ssl.post_connection_check('www.example.com')
# # raise "verification error" if ssl.verify_result != OpenSSL::X509::V_OK
# # ssl.write('hoge')
print ssl.peer_cert.to_text
ssl.close
soc.close
