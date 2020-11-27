class Static
  attr_reader :app

  $TYPES = {
    'jpg' => 'image/jpeg',
    'zip' => 'application/zip',
    'png' => 'image/png',
    'txt' => 'text/plain'
  }

  def initialize(app)
    @app = app
  end

  def call(env)
    app.call(env)
    req = Rack::Request.new(env)
    path = req.path

    # puts path
    content_regex = /.*\.(\w*)/
    content_type1 = path.match(content_regex).captures

    content_type = $TYPES[content_type1]

    body = get_file(path)
    
    res = Rack::Response.new

    if body
      res.status = '200'
      return [res.status, {'Content-type' => content_type}, body]
    else
      return ['404', {'Content-type'=>'text/plain'}, 'File not found']
    end

  end

  def get_file(path)
    dir_path = File.dirname(__FILE__)
    file = File.join(
      dir_path, '..', path
    )
    if File.exist?(file)
      content = File.read(file)
    else
      return false
    end
  end
end
