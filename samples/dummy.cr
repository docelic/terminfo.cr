#!/usr/bin/env crystal

require "../src/terminfo"

ti = Terminfo::Database.new_empty

ti.set_boolean "has_meta_key", true
pp ti.get_boolean? "has_meta_key"

ti.set_boolean "xon_xoff", false
pp ti.get_boolean? "xon_xoff"

pp ti.get_boolean? "invalid_key"
