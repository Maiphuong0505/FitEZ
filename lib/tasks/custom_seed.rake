namespace :db do
  namespace :seed do

    Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb').intern

      # Create multiple tasks by each file name inside db/seeds directory.

      task task_name => :environment do
        load(filename)
      end
    end

    # This is for running all seeds inside db/seeds directory
    # :environment helps rake task to be aware of the models in this app
    task :all => :environment do
      Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |filename|
        load(filename)
      end
    end

  end
end
