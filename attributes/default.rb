default[:ruby_build] = {
  :action           => :sync,
  :install_path     => "/usr/local/ruby-build",
  :repo_uri         => "https://github.com/sstephenson/ruby-build",
  :revision         => "master",
  :ruby_version     => "2.1.5",
  :depth            => nil,
  :destination      => nil,
  :enable_checkout  => nil,
  :enable_submodule => nil,
  :user             => nil,
  :group            => nil,
  :provider         => nil,
  :remote           => nil,
  :ssh_wrapper      => nil,
  :timeout          => nil,
}

default[:ruby_build][:versions_path] = "#{node[:ruby_build][:install_path]}/versions"

default[:ruby_build_env] = {
  :default => {
    "TMPDIR"                 => nil,
    "RUBY_BUILD_BUILD_PATH"  => nil,
    "RUBY_BUILD_CACHE_PATH"  => nil,
    "RUBY_BUILD_MIRROR_URL"  => nil,
    "RUBY_BUILD_SKIP_MIRROR" => nil,
    "RUBY_BUILD_ROOT"        => nil,
    "RUBY_BUILD_DEFINITIONS" => nil,
    "PREFIX"                 => "/usr/local",
  },
  :make => {
    "CC"                     => nil,
    "RUBY_CFLAGS"            => nil,
    "CONFIGURE_OPTS"         => nil,
    "MAKE"                   => nil,
    "MAKE_OPTS"              => nil,
    "MAKE_INSTALL_OPTS"      => nil,
    "RUBY_CONFIGURE_OPTS"    => nil,
    "RUBY_MAKE_OPTS"         => nil,
    "RUBY_MAKE_INSTALL_OPTS" => nil,
  }
}
