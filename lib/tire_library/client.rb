class TireLibrary::Client
  include HTTParty
  base_uri 'api.stackexchange.com'

  def initialize(api_key, version = 'v1')
    @version = version
    self.class.headers = {'X-API-KEY' => @api_key}
  end

  def search(:type, :query, :page = 1)
    handle_request do
      self.class.get(build_path("search", type), query: {q: query , page: page})
    end
  end

  def sizes(:id, :page = 1, :other_sizes = false)
    nested_filter = "otherSizes" if other_sizes == true
    data_request(type: 'sizes', id: id, page: page, nested_filter: nested_filter)
  end

  def models(:id, :page = 1, :sizes = false)
    nested_filter = "sizes" if sizes == true
    data_request(type: 'models', id: id, page: page, nested_filter: nested_filter)
  end

  def makes(:id, :page = 1, :models = false)
    nested_filter = "models" if models == true
    data_request(type: 'makes', id: id, page: page, nested_filter: nested_filter)
  end

  def classes(:id, :page = 1, :subclasses = false)
    nested_filter = "subclasses" if subclasses == true
    data_request(type: 'classes', id: id, page: page, nested_filter: nested_filter)
  end

  def subclasses(:id, :page = 1, :models = false)
    nested_filter = "models" if models == true
    data_request(type: 'subclasses', id: id, page: page, nested_filter: nested_filter)
  end

  def datasheets(id)
    handle_request do
      self.class.get(build_path("templates", 'datasheets', id))
    end
  end

  protected

  def data_request(:type, :id, :page, :nested_filter)
    query = {page: page} unless id
    handle_request do
      self.class.get(build_path("data", type, id, nested_filter), query: query)
    end
  end

  def handle_request(&block)
    response = block.call
    result = MultiJson.load(response.body, symbolize_keys: true)
    case response.status
    when 200..299 #Success
      result
    when 400 #BadRequest
      result
    when 401 #Unauthorized
    when 403 #Forbidden
    when 404 #NotFound
    when 422 #Unprocessable Entity
    when 500..599 #InternalServerError
    end
  #rescue MultiJson::ParseError => exception
  end

  def build_path(*resources)
    @version << resources.compact.join("/")
  end
end
