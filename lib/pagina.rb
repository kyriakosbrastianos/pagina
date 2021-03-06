##
# Our own namespace
module Pagina
  
  require 'erb'
  require 'open-uri'
  require 'logger'
  require 'kramdown'
  require 'dalli'

  VERSION = '0.2'
  ROOT    = File.dirname __FILE__

  $LOAD_PATH.unshift(Pagina::ROOT)
  require 'pagina/app'
  require 'pagina/page'
  require 'pagina/pages'
  require 'pagina/assets'


  class << self
    attr_accessor :options
  end
  @options = {
    'title'             => 'Default Pagina Title',
    'description'       => 'Default Pagina Description',
    'dropbox_url'       => 'http://dl.dropbox.com/u/',
    'dropbox_id'        => 'Your DropBox ID comes here',
    'dropbox_folder'    => 'Your DropBox folder to be used for app',
    'page_extension'    => '.txt',
    'cache'             => false,
    'memcache_servers'  => ['An array of server IP:PORTs'],
    'memcache_user'     => 'Your memcache user',
    'memcache_password' => 'Your memcache password',
    'layout'            => 'Full path to your layout file',
    'public_folder'     => 'Full path to your css/js/images folder',
    'content_type'      => 'text/html',
    'e404_message'      => 'Sorry, not found!',
    'logger'            => Logger.new(STDOUT)
  }
  
  ##
  # Simple wrapper to ease access to our @options
  # If an argument is passed, the old value will be re-written
  def self.method_missing(method, *args)
    key = method.to_s
    new_value = args.first
    if @options.include? key
      @options[key] = new_value if !new_value.nil?
      # If caching value changed, try to enable caching
      return @options[key]
    else
      super
    end
  end

end #Pagina
