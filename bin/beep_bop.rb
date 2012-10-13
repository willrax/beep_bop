#!/usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path('../../lib/beep_bop/',__FILE__)
require 'beep_bop'

beep_bop = BeepBop.new
while command = gets.chomp
  response = beep_bop.execute(command)
  puts response if response.class == String
end