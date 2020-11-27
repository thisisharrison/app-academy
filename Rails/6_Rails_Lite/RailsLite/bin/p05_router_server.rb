require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'


$cats = [
  { id: 1, name: "Curie" },
  { id: 2, name: "Markov" }
]

$statuses = [
  { id: 1, cat_id: 1, text: "Curie loves string!" },
  { id: 2, cat_id: 2, text: "Markov is mighty!" },
  { id: 3, cat_id: 1, text: "Curie is cool!" }
]

class StatusesController < ControllerBase
  def index
    statuses = $statuses.select do |s|
      s[:cat_id] == Integer(params['cat_id'])
    end

    render_content(statuses.to_json, "application/json")
  end
end

class Cats2Controller < ControllerBase
  def index
    render_content($cats.to_json, "application/json")
  end
end

router = Router.new
router.draw do
  # path regex: begins (^) with / cat ends with s ($)
  get Regexp.new("^/cats$"), Cats2Controller, :index
  # path regex: capture cat_id
  get Regexp.new("^/cats/(?<cat_id>\\d+)/statuses$"), StatusesController, :index
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  # run method figures out what URL was requested
  # match to path regex
  # calls Route to instantiate Controller, call the method (eg. StatusesController, :index)
  router.run(req, res)
  res.finish
end

Rack::Server.start(
 app: app,
 Port: 3000
)
