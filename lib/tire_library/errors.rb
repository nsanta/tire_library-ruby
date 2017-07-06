module TireLibrary
  module Errors
    class BaseError < StandardError; end
    class BadRequest < BaseError; end
    class Forbidden < BaseError; end
    class Unauthorized < BaseError; end
    class UnprocessableEntity < BaseError; end
    class NotFound < BaseError; end
    class InternalServerError < BaseError; end
    class MalformedJSONResponse < BaseError; end
  end
end
