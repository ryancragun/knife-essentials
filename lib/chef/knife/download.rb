require 'chef_fs/knife'
require 'chef_fs/command_line'

class Chef
  class Knife
    class Download < ChefFS::Knife
      banner "download PATTERNS"

      option :recurse,
        :long => '--[no-]recurse',
        :boolean => true,
        :default => true,
        :description => "List directories recursively."

      option :purge,
        :long => '--[no-]purge',
        :boolean => true,
        :default => false,
        :description => "Delete matching local files and directories that do not exist remotely."

      def run
        patterns = pattern_args_from(name_args.length > 0 ? name_args : [ "" ])

        # Get the matches (recursively)
        patterns.each do |pattern|
          ChefFS::FileSystem.copy_to(pattern, chef_fs, local_fs, config[:recurse] ? nil : 1, config[:purge])
        end
      end
    end
  end
end

