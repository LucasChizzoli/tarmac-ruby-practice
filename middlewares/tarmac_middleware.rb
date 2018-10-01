class TarmacMiddleware

  TARMAC_HEADER = 'TARMAC_HEADER'

  def initialize(app)
    @app = app
  end

  def call(env)
    if env["HTTP_TARMAC_HEADER"] == TARMAC_HEADER
      @app.call(env)
    else
      Rack::Response.new(['Tarmac Header Not Present'], 401, {}).finish
    end
  end
end