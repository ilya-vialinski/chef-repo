#bamboo install recipe
service "iptables" do
  action :stop
end

directory "/etc/bamboo" do
  mode "0755"
  action :create
end

directory "/home/bamboo/bamboo_home" do
  mode "0755"
  action :create
  recursive true
end

bash "extract_module" do
  code <<-EOH
    cd /etc/bamboo
    #####
    if [ -e "atlassian-bamboo-5.9.4.tar.gz" ]
      then
        echo "Already downloaded!"
      else
        wget http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-5.9.4.tar.gz
        tar -xvf atlassian-bamboo-5.9.4.tar.gz
    fi
    #####
    if grep -xF "bamboo.home=/home/bamboo/bamboo_home" /etc/bamboo/atlassian-bamboo-5.9.4/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
      then
        echo "bamboo.home exist"
      else
        echo -e "\nbamboo.home=/home/bamboo/bamboo_home" >> /etc/bamboo/atlassian-bamboo-5.9.4/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
    fi
    EOH
end

template "/etc/init.d/bamboo" do
  source "bamboo_startup"
  mode "0755"
  action :create
end

bash "extract_module" do
  code <<-EOH
    chmod \+x /etc/init.d/bamboo
    /sbin/chkconfig --add bamboo
    EOH
end

service "bamboo" do
  action :start
end