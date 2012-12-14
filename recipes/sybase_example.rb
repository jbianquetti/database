#
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Cookbook Name:: database
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
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
gem_package  "tiny_tds" do
  action :install
end


# attributes from sybase's cookbook 
sybase_ase_connection_info = {
  :host => node['ipaddress'], 
  :port => node['sybase']['server_port'],
  :username => 'sa', 
  :password => node['sybase']['sa_pass'],
  :tds_version => '100'
}


sybase_ase_database 'test' do
  connection sybase_ase_connection_info 
  provider Chef::Provider::Database::SybaseAse
  action :create 
end 

sybase_ase_database 'run_query' do 
  connection sybase_ase_connection_info 
  provider Chef::Provider::Database::SybaseAse
  sql "sp_databases"
  action :query
end
