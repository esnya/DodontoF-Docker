#!/usr/bin/ruby
#--*-config:utf-8-*--
Encoding.default_external='utf-8' if defined?(Encoding) && Encoding.respond_to?('default_external')

require 'fcgi'
require 'logger'

$logger = Logger.new('/var/log/fcgi.log')
$logger.level = Logger::INFO
$logger.info('FCGI started')

load '/usr/local/src/DodontoF_WebSet/public_html/DodontoF/DodontoFServer.rb'

FCGI.each do |fcgi|
    begin
        $stdout = fcgi.out
        $stdin = fcgi.in

        ENV.replace(fcgi.env)

        $logger.info("Execute DodontoF")

        executeDodontoServerCgi()

        fcgi.finish
        $logger.info("DodontoF Finished")
    rescue Exception => e
        $logger.fatal(e)
    end
end
