#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
module AttachFunction
  #
  #attach_function defines new methods that are partial applications of a target function where the first argument to the target function gets fixed to self.
  #
  #The name of the newly defined method will be the basename of the target function (the module path gets stripped) or a user-specified name.
  #The receiver of relatively specified parameter functions will be the current module, if a user-specified name is given and 
  #the user-specified name is not the same as the basename of the target function, or the enclosing module, if no-user specified name is provided or 
  #if the user-specified name is the same as the basename of the parameter.
  #
  #Usage: 
  #
  #module MyModule
  #   def function_method1(arg1, arg2); end
  #   def function_method2(arg1); end
  #
  #   module MethodVersions
  #     extend Attachmethod
  #     attach_function :function_method1
  #     attach_function :function_method2
  #   end
  #   
  #See the specs and the example folder for more examples.
  
  def _receiver_and_message(method_name, function_symbol)
    #Parse the function symbol to get the receiver and the function's basename
    if function_symbol.match(/(.*)(?:::|\.)([^:.]*)$/)
      receiver, function_method = $1, $2
      receiver = receiver != "" && eval(receiver) || Object
    else
      #No explicit receiver
      function_method = function_symbol
      #If no receiver is specified, send it to self
      receiver = self
      #Can't send to self if method_name == function_method (or it will recurse and crash):
      #   send it to the outer module/class, if there's no outer module, send it to Object
      if (method_name ||= function_method) == function_method
        receiver = self.name
        outer_module = receiver.rpartition('::').first
        receiver = outer_module == "" ? Object : eval(outer_module)
      end
    end
    
    return [ receiver, function_method ]
  end

  def attach_function(method_name = nil, function_symbol)
    receiver, message = _receiver_and_message(method_name, function_symbol)

    #If no method_name is given, use the basename of the function being attached
    method_name ||= message

    #The core functionality
    define_method method_name do |*args|
      receiver.send(message, self, *args)
    end
  end
end
