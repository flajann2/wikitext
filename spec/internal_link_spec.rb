#!/usr/bin/env ruby
# Copyright 2007-2008 Wincent Colaiuta
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require File.join(File.dirname(__FILE__), 'spec_helper.rb')
require 'wikitext'

describe Wikitext::Parser, 'internal links' do
  before do
    @parser = Wikitext::Parser.new
  end

  it 'should pass through unexpected link end tokens literally' do
    @parser.parse('foo ]] bar').should == "<p>foo ]] bar</p>\n"                                     # in plain scope
    @parser.parse("foo '']]'' bar").should == "<p>foo <em>]]</em> bar</p>\n"                        # in EM scope
    @parser.parse("foo ''']]''' bar").should == "<p>foo <strong>]]</strong> bar</p>\n"              # in STRONG scope
    @parser.parse("foo ''''']]''''' bar").should == "<p>foo <strong><em>]]</em></strong> bar</p>\n" # in STRONG_EM scope
    @parser.parse('foo <tt>]]</tt> bar').should == "<p>foo <tt>]]</tt> bar</p>\n"                   # in TT scope
    @parser.parse('= foo ]] bar =').should == "<h1>foo ]] bar</h1>\n"                               # in H1 scope
    @parser.parse('== foo ]] bar ==').should == "<h2>foo ]] bar</h2>\n"                             # in H2 scope
    @parser.parse('=== foo ]] bar ===').should == "<h3>foo ]] bar</h3>\n"                           # in H3 scope
    @parser.parse('==== foo ]] bar ====').should == "<h4>foo ]] bar</h4>\n"                         # in H4 scope
    @parser.parse('===== foo ]] bar =====').should == "<h5>foo ]] bar</h5>\n"                       # in H5 scope
    @parser.parse('====== foo ]] bar ======').should == "<h6>foo ]] bar</h6>\n"                     # in H6 scope
    @parser.parse('> ]]').should == "<blockquote><p>]]</p>\n</blockquote>\n"                        # in BLOCKQUOTE scope
  end
end