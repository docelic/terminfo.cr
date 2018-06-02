#!/usr/bin/env crystal

require "../src/terminfo"

alias TiBooleans = Terminfo::Keys::Booleans
alias TiNumbers = Terminfo::Keys::Numbers
alias TiStrings = Terminfo::Keys::Strings

ti = Terminfo::Database.new_empty

ti.set TiBooleans::HasMetaKey, true
pp ti.get! TiBooleans::HasMetaKey

ti.set TiBooleans::XonXoff, false
pp ti.get! TiBooleans::XonXoff

# NOTE: in the specs, don't forget to test key.valid? for the last key!
ti.set TiBooleans::ReturnDoesClrEol, true
pp ti.get! TiBooleans::ReturnDoesClrEol

invalid_bool_key = TiBooleans.new(9999)
pp ti.get? invalid_bool_key
pp invalid_bool_key.valid?


ti.set TiNumbers::Lines, 42_i16
pp ti.get! TiNumbers::Lines

ti.set TiStrings::CursorHome, Bytes[0, 1, 2]
pp ti.get! TiStrings::CursorHome
