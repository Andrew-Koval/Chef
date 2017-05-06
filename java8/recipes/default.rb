#
# Cookbook:: java8
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

yum_package 'java-1.8.0-openjdk.x86_64' do
  action :install
end

template '/etc/environment' do
  source 'environment.erb'
end
