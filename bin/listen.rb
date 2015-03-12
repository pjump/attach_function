#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'listen'

listener = Listen.to('.') do |modified, added, removed|
  puts "modified absolute path: #{modified}"
  puts "added absolute path: #{added}"
  puts "removed absolute path: #{removed}"
  system 'rake'
end
listener.start # not blocking
sleep
