# AttachFunction

AttachFunction defines new methods that are partial applications of a target function where the first argument to the target function gets fixed to self.

The name of the newly defined method will be the basename of the target function (the module path gets stripped) or a user-specified name.
The receiver of relatively specified parameter functions will be the current module, if a user-specified name is given and 
the user-specified name is not the same as the basename of the target function, or the enclosing module, if no-user specified name is provided or 
if the user-specified name is the same as the basename of the parameter.

## Usage Example: 
```ruby
require 'attach_function'

module Math

  #This will contain the method versions of the functions defined in the Math module
  module MethodVersions
    #Get the attach_function macro
    extend AttachFunction
    #Apply it to all methods of the Math module that aren't Object methods
    (Math.methods - Object.methods).each do |m|
      puts "Attaching #{m}"
      attach_function m
    end
  end
end

#Now we include the Math::MethodVersions in Numeric
Numeric.include(Math::MethodVersions)
#And now we can do this:
p "3.14.sin = #{3.14.sin}"
p "10.log  = #{10.log10}"
p "4.sqrt  = #{4.sqrt}"
```

#The functionality that has been added to Numeric in this way is contained in the Math::MethodVersions mixin.
#I consider this much nicer than rudely monkepatching methods right onto a core class.
#This way, library users can see (in pry, for example, or via introspection) where a certain added method came from, and possibly filter it out.
#(Ruby doesn't currently support unmixing).

   
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
