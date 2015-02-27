require 'spec_helper'

module Foo
  def self.add_foo(string)
    string + " foo"
  end

  #module MethodVersions
  #extend AttachFunction
  #attach_function :add_foo
  #end
end
module Three
  def self.add_three(number)
    number + 3
  end
  #module MethodVersions
  #extend AttachFunction
  #attach_function :add_three
  #end
end

module A; end
module ::A; module B; end; end

describe AttachFunction do
  it 'has a version number' do
    expect(AttachFunction::VERSION).not_to be nil
  end
  it "should define an instance method named 'attach_function'" do
    expect(subject.instance_methods(false)).to include(:attach_function)
  end

  describe "resolving receivers" do
    {
      '::A.m' => [::A, 'm'],
      '::A::m' => [::A, 'm'],
      'A.m' => [A, 'm'],
      'A::m' => [A, 'm'],
      '::A::B.m' => [::A::B, 'm'],
      '::A::B::m' => [::A::B, 'm'],
      '::A::B.m' => [::A::B, 'm'],
      '::A::B::m' => [::A::B, 'm'],
    }.each_pair do |k,answers|
      it "should resolve #{k} to #{answers.inspect}" do
        extend AttachFunction
        expect(_receiver_and_message('attach_here',k)).to eq(answers)
      end
    end

    context "same name and target in the same scope" do
      enclosing_scope = self
      #Don't know how to test this since it creates an unnamed scope
      xit "resolves relatively to the enclosing scope" do
        this_scope = self
        extend AttachFunction
        expect(this_scope).not_to eq(enclosing_scope)
        expect(_receiver_and_message(nil,'m')).to eq([ enclosing_scope, 'm'])
      end
    end


    class MyString < String; end
    class MyInt < Integer; end

    let(:my_string) { MyString.new("my string") }
    let(:my_int) { MyInt.new(7) }

    it "works with absolute names from a different scope" do
      module AddFooMethod; end
      expect {
        module AddFooMethod
          extend AttachFunction
          attach_function nil,"::Foo::add_foo"
        end
      }.not_to raise_error
      my_string.extend(AddFooMethod)
      expect(my_string).to respond_to(:add_foo)
      expect(my_string.add_foo).to eq("my string foo")
    end
    context "same scope" do 
      class TestClass
        def add_bar(obj)
          puts "#{obj} + bar"
        end
      end
      it "works with the same scope as long as we're using a different name" do
        TestClass.extend AttachFunction
        expect(TestClass.new).not_to respond_to(:add_bar_to_self) 
        class TestClass
          attach_function :add_bar_to_self, :add_bar
        end
        expect(TestClass.new).to respond_to(:add_bar_to_self) 
      end
    end
  end
end
