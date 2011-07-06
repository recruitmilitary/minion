#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'minion'

include Minion

queue = ARGV[0] || 'board'

error do |exception,queue,message,headers|
  puts "got an error processing queue #{queue}"
  puts exception.message
  puts exception.backtrace
end

logger do |msg|
  puts "--> #{msg}"
end

subscribe "unsubscribe", queue do |args|
  puts args.inspect
end

publish("unsubscribe", :email => "foo@bar.com")
