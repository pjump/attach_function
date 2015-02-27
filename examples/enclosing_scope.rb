#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'attach_function'

module Math
  module MethodVersions
    extend AttachFunction
    (Math.methods - Object.methods).each do |m|
      puts "Attaching #{m}"
      attach_function m
    end
  end
end

Numeric.include(Math::MethodVersions)
p "3.14.sin = #{3.14.sin}"
p "10.log  = #{10.log10}"
p "4.sqrt  = #{4.sqrt}"
