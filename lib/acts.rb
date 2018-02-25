require "acts/version"
require 'thor'
require 'fileutils'

class Acts < Thor
  @@path = File.dirname(__FILE__)
  @@templates_path = @@path + '/templates'
  @@framework_templates_path = @@path + '/frameworks_templates'

  desc 'new <project_name>', 'Create new empty project'
  method_option :with_rspec,
                default: false,
                required: false,
                desc: "Create necessary files for rspec",
                aliases: "-trs",
                type: :boolean
  def new(name)
    create_file("#{name}/first_file.rb", read_from_file("#{templates_path}/template#1.rb"))
    create_file("#{name}/folder/second_file.feature", read_from_file("#{templates_path}/template#2.feature"))
    if options[:with_rspec]
      create_file("#{name}/rspec/example_spec.rb", read_from_file("#{templates_path}/template#2.rb"))
    end
    puts("-- Project with name #{name} has been created --")
  end

  desc 'create_test_for <feature_path> <destination_folder>', 'Create test suite for given feature'
  def create_test_for(feature_path, destination_folder)
    step_strings = get_step_strings(feature_path)
    file_content = file_header_template
    file_content.concat(step_strings.map{ |name| write_step(name) }.join("\n")) if step_strings.any?
    file_content.concat("end\n")
    full_file_path = "#{destination_folder}/#{feature_path.match(/\/(\w+)(.\w+)?$/)[1]}.rb"
    create_file(full_file_path, file_content)
    puts "-- Test has been created --"
  end

  desc 'create_config <path>', 'Allow to create config according to your needs'
  method_option :framework,
                required: true,
                desc: "You need to choose which",
                type: :string,
                liases: "-fr"
  def create_config(path)
    file_content = nil
    file_name = 'config'
    if options["framework"] == "phoenix"
      file_content = read_from_file("#{framework_templates_path}/ph_template.exs")
      file_name.concat('.exs')
    elsif options["framework"] == "rails"
      file_content = read_from_file("#{framework_templates_path}/ror_template.rb")
      file_name.concat('.rb')
    else
      puts "Template for framework=#{options["framework"]} does not exist"
    end
    if file_content
      create_file("#{path}/#{file_name}", file_content)
    end
  end

  private

  def file_header_template
    [
        "require 'spec_helper'\n",
        "module CrudForNewReasonSteps\n"
    ].join("\n")
  end

  def write_step(name)
    [
        "  step '#{name.strip}' do",
        "    # implement step here",
        "  end\n"
    ].join("\n")
  end

  def get_step_strings(feature_name)
    file_text = File.open(feature_name).read
    file_text = file_text.gsub(/\n\r?/, "\n")
    steps = []
    file_text.each_line do |line|
      if line.match(/\s*(Допустим|Когда|Тогда).+/)
        steps << line
      end
    end
    steps
  end

  def templates_path
    @@templates_path
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
