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

The important classes are HandleServer::Client and HandleServer::URLClient.
Instantiate these with the correct host, port, username, and password.

The basic client has retrieve_raw, retrieve, exists?, create, update, and delete methods to operate on handles.

retrieve_raw takes a handle and returns an HTTParty::Response. The raw XML is available from this via the body method.

retrieve takes a handle and returns HTTParty::Response.parsed_response, which is the result of parsing the raw XML
into a hash. Note that some of the element names may be altered (e.g. handle-value in xml goes to handle_value as
a hash key).

exists? takes a handle and returns whether or not the handle exists.

The other methods require basic authentication parameters to have been supplied.

delete takes a handle and deletes it from the handle server.

create takes a handle and a hash and creates the requested handle. Valid parameters (hash keys) are:

update takes a handle and a hash and updates the handle. The same parameters are available as in create.

The URLClient adds some convenience methods when we only care about the URL for a handle.

retrieve_url takes a handle and returns the corresponding URL.

create_from_url takes a handle and url and creates a handle with that url.

update_url takes a handle and url and updates the handle with the new url.

The following exceptions (in the HandleServer namespace) may be raised as appropriate:

HandleNotFound
URLNotFound
MalformedURI
Unauthorized
BadGateway
UnexpectedResponse