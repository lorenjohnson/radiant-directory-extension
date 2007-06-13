namespace :radiant do
  namespace :extensions do
    namespace :church_finder do
      
      desc "Runs the migration of the Church Finder extension"
      task :migrate do
        require 'extension_migrator'
        if ENV["VERSION"]
          ChurchFinderExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ChurchFinderExtension.migrator.migrate
        end
      end
    
    end
  end
end