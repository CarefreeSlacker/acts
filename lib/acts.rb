require_relative 'acts/create.rb'
require 'thor'
require 'fileutils'

module Acts
  class Main < Thor
    @@path = File.dirname(__FILE__)
    @@new_project_path = @@path + '/acts/new_project'
    @@framework_templates_path = @@path + '/acts/frameworks_templates'

    desc 'new <project_name>', 'Create new empty project'
    def new(name)
      create_file("#{name}/Gemfile", read_from_file("#{new_project_path}/Gemfile"))
      create_file("#{name}/Rakefile", read_from_file("#{new_project_path}/Rakefile"))
      create_file("#{name}/spec/init_utils.rb", read_from_file("#{new_project_path}/spec/init_utils.rb"))
      create_file("#{name}/spec/spec_helper.rb", read_from_file("#{new_project_path}/spec/spec_helper.rb"))
      create_file("#{name}/spec/feature/test_autotest_en.feature", read_from_file("#{new_project_path}/spec/feature/test_autotest_en.feature"))
      create_file("#{name}/spec/feature/test_autotest_ru.feature", read_from_file("#{new_project_path}/spec/feature/test_autotest_ru.feature"))
      create_file("#{name}/spec/steps/test_autotest_steps_en.rb", read_from_file("#{new_project_path}/spec/steps/test_autotest_steps_en.rb"))
      create_file("#{name}/spec/steps/test_autotest_steps_ru.rb", read_from_file("#{new_project_path}/spec/steps/test_autotest_steps_ru.rb"))
      create_file("#{name}/spec/support/test_page.rb", read_from_file("#{new_project_path}/spec/support/test_page.rb"))
      puts("-- Project with name #{name} has been created --")
    end

    desc 'create [step|feature] (-l) <args>', 'Allow to create new feature or steps.'
    subcommand "create", Acts::Create

    private

    def new_project_path
      @@new_project_path
    end

    def framework_templates_path
      @@framework_templates_path
    end

    def path
      @@path
    end

    def create_file(name, content)
      dirname = File.dirname(name)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
      File.new("#{name}", 'w').close
      IO.write(name, content)
      puts("create #{name}")
    end

    def read_from_file(path)
      File.open(path).read
    end
  end
end
