
require 'toto'
require "rack/pygments"

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

#if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
#end

use Rack::Pygments, :html_tag => "code",
                    :html_attr => "lang"

class Toto::Site
  def log *args
    index *args
  end
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
  set :author,    "Carter Allen"                              # blog author
  set :title,     "Carter Allens Blog"                   	  # site title
  # set :root,      "index"                                   # page to load on /
  set :date do |now|
      now.strftime("%B #{now.day.ordinal} %Y")
  end
  set :url,       "http://blog.cartera.me"
  set :markdown,  :smart                                    # use markdown + smart-mode
  set :disqus,    "cartera"                                   # disqus id, or false
  set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  set :ext,       'md'                                     # file extension for articles
  set :cache,      28800                                    # cache duration, in seconds
end

run toto

