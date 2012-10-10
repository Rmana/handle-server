# Handle::Server

This is a very basic wrapper around the UIUC handle web service

## Installation

Add this line to your application's Gemfile:

    gem 'handle-server'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install handle-server

## Usage

The important class is HandleServer::URLClient. Instantiate this with the correct host, port, username, and password.

Then use the retrieve, create, update, and delete methods to operate on handles. Note that (as implied by the name)
this client only deals with setting and retrieving the URL value associated with a handle. HandleServer::Client is
left unused in case we ever need a client that deals with the rest of the web API.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
