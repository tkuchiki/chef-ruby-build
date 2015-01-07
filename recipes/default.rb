package "git"

git node[:ruby_build][:install_path] do
  action           node[:ruby_build][:action]
  repository       node[:ruby_build][:repo_uri]
  revision         node[:ruby_build][:revision]
  depth            node[:ruby_build][:depth]            unless node[:ruby_build][:depth].nil?
  destination      node[:ruby_build][:destination]      unless node[:ruby_build][:destination].nil?
  enable_checkout  node[:ruby_build][:enable_checkout]  unless node[:ruby_build][:enable_checkout].nil?
  enable_submodule node[:ruby_build][:enable_submodule] unless node[:ruby_build][:enable_submodule].nil?
  user             node[:ruby_build][:user]             unless node[:ruby_build][:user].nil?
  group            node[:ruby_build][:group]            unless node[:ruby_build][:group].nil?
  provider         node[:ruby_build][:provider]         unless node[:ruby_build][:provider].nil?
  remote           node[:ruby_build][:remote]           unless node[:ruby_build][:remote].nil?
  ssh_wrapper      node[:ruby_build][:ssh_wrapper]      unless node[:ruby_build][:ssh_wrapper].nil?
  timeout          node[:ruby_build][:timeout]          unless node[:ruby_build][:timeout].nil?
end

install_ruby_build_env = {}

node[:ruby_build_env][:default].map do |key, value|
  install_ruby_build_env[key] = value unless value.nil?
end

ruby_build_bin = "#{node[:ruby_build_env][:default]['PREFIX']}/bin/ruby-build"

directory node[:ruby_build][:versions_path] do
  owner     "root"
  group     "root"
  mode      0755
  recursive true
end

bash "install ruby-build" do
  cwd         node[:ruby_build][:install_path]
  environment install_ruby_build_env
  creates     ruby_build_bin
  
  code        <<-EOC
bash ./install.sh
EOC
end

make_ruby_env = {}

node[:ruby_build_env][:make].map do |key, value|
  make_ruby_env[key] = value unless value.nil?
end

install_ruby_path = "#{node[:ruby_build][:versions_path]}/#{node[:ruby_build][:ruby_version]}"

bash "install ruby #{node[:ruby_build][:ruby_version]}" do
  environment make_ruby_env
  creates     "#{install_ruby_path}"
  
  code        <<-EOC
  #{ruby_build_bin} #{node[:ruby_build][:ruby_version]} #{install_ruby_path}
EOC
end
