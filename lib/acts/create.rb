require 'thor'
require 'fileutils'

module Acts
  class Create < Thor
    RU_REGEX = /\s*(Допустим|И|Когда|Тогда).+/
    EN_REGEX = /\s*(Scenario|And|When|Then).+/
    STEP_FILE_HEADER_TEMPLATE = ["require 'spec_helper'\n", "module CrudForNewReasonSteps\n"]
    FEATURE_REGEX = /[\/]?(.+)\.feature/

    options c: :string

    method_option :language,
                  default: 'en',
                  banner: '<language>',
                  desc: 'Specify to choose ',
                  type: :string,
                  aliases: '-l'
    desc 'create feature <path>', 'Allow to create file with specified name. #TODO Checks if file exist.'
    def feature(*args)
      puts '-- feature   --'
    end

    method_option :language,
                  default: 'en',
                  banner: '<language>',
                  desc: 'Specify to choose ',
                  type: :string,
                  aliases: '-l'
    desc 'create steps <feature_path>', 'Create steps for given feature file. Checks for repeats. '
    def steps(*args)
      puts '-- steps     --'
      feature_path = args[0]
      return puts("Please specify feature file") unless feature_path
      destination_folder = args[1]
      return puts("Please specify destination folder") unless destination_folder


      file_text = File.open(feature_path).read
      file_text = file_text.gsub(/\n\r?/, "\n")
      regex = options['language'] == 'en' ? EN_REGEX : RU_REGEX
      step_strings = []
      file_text.each_line do |line|
        if line.match(regex)
          step_strings << line
        end
      end

      file_content = STEP_FILE_HEADER_TEMPLATE.join("\n")
      result = step_strings.map{ |name| write_step(name) }.join("\n")
      file_content.concat(result) if step_strings.any?
      file_content.concat("end\n")

      file_name = feature_path.match(FEATURE_REGEX)
      puts feature_path
      puts file_name
      return puts("Given file is not feature") unless file_name

      full_file_path = "#{destination_folder}/#{file_name[1]}.rb"
      create_file(full_file_path, file_content)
    end

    private

    def write_step(name)
      [
          "  step '#{name.strip}' do",
          "    # implement step here",
          "  end\n"
      ]
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
  end
end
