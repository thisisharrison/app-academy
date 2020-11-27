require 'rack'

app = Proc.new do |env|
    req = Rack::Request.new(env)
    res = Rack::Response.new

    string = 'i/love/app/academy'
    # http://0.0.0.0:3000/i/love/app/academy
    query_string = req.params['i/love/app/academy']
    # header Content-Type
    res['Content-Type'] = 'text/html'
    # Writes into the response body
    res.write(string) 
    res.finish
end

Rack::Server.start(
    app: app,
    Port: 3000
)