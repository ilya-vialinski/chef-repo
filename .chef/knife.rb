# See https://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "norb93"
client_key               "#{current_dir}/norb93.pem"
validation_client_name   "sap-web-validator"
validation_key           "#{current_dir}/sap-web-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/sap-web"
cookbook_path            ["#{current_dir}/../cookbooks"]
install_sh="https://www.opscode.com/chef/install.sh"