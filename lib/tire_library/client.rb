class TireLibrary::Client
  include HTTParty
  base_uri 'https://api.tirelibrary.com'

  def initialize(api_key, version = 'v1')
    @version = version
    self.class.headers('X-API-KEY' => api_key)
  end

  def search(params)
    handle_response do
      self.class.get(build_path("search", params[:type]), query: {q: params[:query] , page: params[:page]})
    end
  end

  def sizes(params)
    nested_filter = "otherSizes" if params[:other_sizes] == true
    data_request(type: 'sizes', id: params[:id], page: params[:page], nested_filter: nested_filter)
  end

  def models(params)
    nested_filter = "sizes" if params[:sizes] == true
    data_request(type: 'models', id: params[:id], page: params[:page], nested_filter: nested_filter)
  end

  def makes(params)
    nested_filter = "models" if models == true
    data_request(type: 'makes', id: params[:id], page: params[:page], nested_filter: nested_filter)
  end

  def classes(params)
    nested_filter = "subclasses" if subclasses == true
    data_request(type: 'classes', id: params[:id], page: params[:page], nested_filter: nested_filter)
  end

  def subclasses(params)
    nested_filter = "models" if models == true
    data_request(type: 'subclasses', id: params[:id], page: params[:page], nested_filter: nested_filter)
  end

  def datasheets(id)
    handle_response do
      self.class.get(build_path("templates", 'datasheets', id))
    end
  end

  protected

  def data_request(params)
    query = {page: params[:page]} unless params[:id]
    handle_response do
      self.class.get(
        build_path("data", params[:type], params[:id], params[:nested_filter]),
        query: params[:query]
      )
    end
  end

  def handle_response(&block)
    response = block.call
    result = MultiJson.load(response.body, symbolize_keys: true)
    case response.code
    when 200..299 #Success
      result
    when 400 #BadRequest
      fail TireLibrary::Errors::BadRequest, result[:message]
    when 401 #Unauthorized
      fail TireLibrary::Errors::Unauthorized, result[:message]
    when 403 #Forbidden
      fail TireLibrary::Errors::Forbidden, result[:message]
    when 404 #NotFound
      fail TireLibrary::Errors::NotFound, result[:message]
    when 422 #UnprocessableEntity
      fail TireLibrary::Errors::UnprocessableEntity, result[:message]
    when 500..599 #InternalServerError
      fail TireLibrary::Errors::InternalServerError, result[:message]
    end
  rescue MultiJson::ParseError => exception
    fail TireLibrary::Errors::MalformedJSONResponse , exception.cause
  end

  def build_path(*resources)
    "/#{@version}/#{resources.compact.join("/")}"
  end
end
