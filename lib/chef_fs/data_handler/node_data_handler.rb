require 'chef_fs/data_handler/data_handler_base'
require 'chef/node'

module ChefFS
  module DataHandler
    class NodeDataHandler < DataHandlerBase
      def normalize(node, name)
        result = super(node, {
          'name' => name,
          'json_class' => 'Chef::Node',
          'chef_type' => 'node',
          'chef_environment' => '_default',
          'override' => {},
          'normal' => {},
          'default' => {},
          'automatic' => {},
          'run_list' => []
        })
        result['run_list'] = normalize_run_list(result['run_list'])
        result
      end

      def chef_class
        Chef::Node
      end

      # Nodes do not support .rb files
    end
  end
end
