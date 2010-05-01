#
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

provides "languages/perl"

require_plugin "languages"
output = nil

perl = Mash.new
status = popen4("perl -V:version -V:archname") do |pid, stdin, stdout, stderr|
  stdin.close
  stdout.each_line do |line|
    case line
    when /^version=\'(.+)\';$/
      perl[:version] = $1
    when /^archname=\'(.+)\';$/
      perl[:archname] = $1
    end
  end
end

if status == 0
  languages[:perl] = perl 
end
