require 'bundler/cli'
require 'bundler/cli/gem'
require 'bundler/vendored_thor'
require 'thor/actions'

module Bundler
  class Norelease::CLI < ::Thor
    include Thor::Actions

    def self.start(*)
      super
    end

    default_task :gem
    desc "gem GEM [OPTIONS]", "Creates a skeleton for creating a rubygem"
    method_option :bin, :type => :boolean, :default => false, :aliases => '-b', :banner => "Generate a binary for your library."
    method_option :edit, :type => :string, :aliases => "-e",
                  :lazy_default => [ENV['BUNDLER_EDITOR'], ENV['VISUAL'], ENV['EDITOR']].find{|e| !e.nil? && !e.empty? },
                  :required => false, :banner => "/path/to/your/editor",
                  :desc => "Open generated gemspec in the specified editor (defaults to $EDITOR or $BUNDLER_EDITOR)"
    method_option :ext, :type => :boolean, :default => false, :banner => "Generate the boilerplate for C extension code"
    method_option :test, :type => :string, :lazy_default => 'rspec', :aliases => '-t', :banner =>
      "Generate a test directory for your library: 'rspec' is the default, but 'minitest' is also supported."
    def gem(name)
      underscored_name = name.tr('-', '_')
      namespaced_path = name.tr('-', '/')
      constant_name = name.split('_').map{|p| p[0..0].upcase + p[1..-1] }.join
      constant_name = constant_name.split('-').map{|q| q[0..0].upcase + q[1..-1] }.join('::') if constant_name =~ /-/
      constant_array = constant_name.split('::')

      opts = {
        :name             => name,
        :underscored_name => underscored_name,
        :namespaced_path  => namespaced_path,
        :makefile_path    => "#{underscored_name}/#{underscored_name}",
        :constant_name    => constant_name,
        :constant_array   => constant_array,
        :test             => options[:test],
        :ext              => options[:ext]
      }

      Bundler::Norelease::CLI.source_root(File.join(Gem::Specification.find_by_path('bundler').full_gem_path, 'lib/bundler/templates'))
      bundler = ::Bundler::CLI::Gem.new(options, name, self)
      bundler.run
      Bundler::Norelease::CLI.source_root(File.join(File.expand_path('../', __dir__), 'templates'))
      opts[:force] = true
      template("newgem/Rakefile.tt", File.join(bundler.target, "Rakefile"), opts)
    end

    private

    def source_paths
      self.class.source_paths_for_search
    end

  end
end
