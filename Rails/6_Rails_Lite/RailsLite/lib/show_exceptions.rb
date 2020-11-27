require 'erb'

class ShowExceptions
  attr_reader :app
  
  def initialize(app)
    @app = app
  end

  def call(env)
    app.call(env)
  rescue Exception => e
    render_exception(e)
  end

  private

  def render_exception(e)
    res = Rack::Response.new
    res.status = '500'
    res['Content-type'] = 'text/html'

    puts "Error happened in: #{stack_trace(e)}"
    puts error_lines(e)
    
    [res.status, {'Content-type' => 'text/html'}, e.to_s]
  end

  def stack_trace(e)
    e.backtrace[0]
  end

  def error_lines(e)
    path = stack_trace(e).split(':')[0]
    line_num = stack_trace(e).split(':')[1].to_i
    file = File.open(path, 'r')
    source_lines = file.readlines
    
    lines = source_lines[line_num - 3..line_num + 3]
    lines.flatten
  end

end
