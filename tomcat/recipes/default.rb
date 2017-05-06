#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

group 'tomcat' do
  action :create
  gid '91'
end

user 'tomcat' do
  comment 'Apache Tomcat'
  uid '91'
  gid '91'
  group 'tomcat'
  home '/usr/share/tomcat'
  shell '/sbin/nologin'
end

execute "wget_tomcat" do
  command "wget -q https://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.77/bin/apache-tomcat-7.0.77.tar.gz -O /usr/share/apache-tomcat-7.0.77.tar.gz"
end

execute "extract_tomcat" do
  command "tar -xvf /usr/share/apache-tomcat-7.0.77.tar.gz -C /usr/share"
end

link '/usr/share/tomcat' do
  to '/usr/share/apache-tomcat-7.0.77'
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

execute "restart_daemon-reload" do
  command "systemctl daemon-reload"
end

service "tomcat" do
  action :start
end

service "tomcat" do
  action :enable
end
