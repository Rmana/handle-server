module HandleServer
  class HandleNotFound < Exception ; end
  class URLNotFound < Exception ; end
  class MalformedURI < Exception ; end
  class Unauthorized < Exception ; end
  class BadGateway < Exception ; end
  class UnexpectedResponse < Exception ; end
end