module KpJwt
  class Engine < ::Rails::Engine
    config.eager_load_paths += Dir["#{config.root}/lib/**/"]
    isolate_namespace KpJwt
  end
end
