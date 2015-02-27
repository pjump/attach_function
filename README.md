# AttachFunction

AttachFunction defines new methods that are partial applications of a target function where the first argument to the target function gets fixed to self.

The name of the newly defined method will be the basename of the target function (the module path gets stripped) or a user-specified name.
The receiver of relatively specified parameter functions will be the current module, if a user-specified name is given and 
the user-specified name is not the same as the basename of the target function, or the enclosing module, if no-user specified name is provided or 
if the user-specified name is the same as the basename of the parameter.

## Usage: 

    module MyModule
     def function_method1(arg1, arg2); end
     def function_method2(arg1); end

       module MethodVersions
         extend Attachmethod
         attach_function :function_method1
         attach_function :function_method2
       end
     end

   
See the specs and the example folder for more examples.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'attach_function'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attach_function

## Usage

User it in any way you like.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/i_rewriter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
