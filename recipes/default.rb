package "git"

git "#{node[:ruby_build][:install_path]}" do
  action           node[:ruby_build][:action]
  repository       node[:ruby_build][:repo_uri]
  revision         node[:ruby_build][:revision]
  depth            node[:ruby_build][:depth]            if node[:ruby_build][:depth]
  destination      node[:ruby_build][:destination]      if node[:ruby_build][:destination]
  enable_checkout  node[:ruby_build][:enable_checkout]  if node[:ruby_build][:enable_checkout]
  enable_submodule node[:ruby_build][:enable_submodule] if node[:ruby_build][:enable_submodule]
  user             node[:ruby_build][:user]             if node[:ruby_build][:user]
  group            node[:ruby_build][:group]            if node[:ruby_build][:group]
  provider         node[:ruby_build][:provider]         if node[:ruby_build][:provider]
  remote           node[:ruby_build][:remote]           if node[:ruby_build][:remote]
  ssh_wrapper      node[:ruby_build][:ssh_wrapper]      if node[:ruby_build][:ssh_wrapper]
  timeout          node[:ruby_build][:timeout]          if node[:ruby_build][:timeout]
end

install_ruby_build_env = {}

node[:ruby_build_env][:default].map do |key, value|
  install_ruby_build_env[key] = value unless value.nil?
end

ruby_build_bin = "#{node[:ruby_build_env][:default]['PREFIX']}/bin/ruby-build"

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

bash "install ruby" do
  environment make_ruby_env
  creates     "#{install_ruby_path}"
  
  code        <<-EOC
  #{ruby_build_bin} #{node[:ruby_build][:ruby_version]} #{install_ruby_path}
EOC
end
