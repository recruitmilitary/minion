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

subscribe "unsubscribes", queue do |args|
  puts "unsubscribes"
  puts args.inspect
end

subscribe "bounces", queue do |args|
  puts "bounces"
  puts args.inspect
end

publish("unsubscribes", :email => "foo@bar.com")
publish("bounces", :email => "bounce@bar.com")
