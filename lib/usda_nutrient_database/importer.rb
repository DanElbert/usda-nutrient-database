module UsdaNutrientDatabase
  class Importer
    attr_reader :directory, :version

    def initialize(directory = 'tmp/usda', version = 'sr25')
      @directory = directory
      @version = version
    end

    def import
      downloader.download_and_unzip
      importer_names.each { |importer_name| importer_for(importer_name).import }
    ensure
      downloader.cleanup
    end

    def fast_import
      downloader.download_and_unzip
      importer_names.each { |importer_name| puts importer_name; fast_importer_for(importer_name).import }
    ensure
      downloader.cleanup
    end

    private

    def importer_names
      [
        'Foods', 'Nutrients', 'FoodsNutrients', 'FoodGroups', 'Weights',
        'Footnotes', 'SourceCodes'
      ]
    end

    def importer_for(importer_name)
      "UsdaNutrientDatabase::Import::#{importer_name}".constantize.
        new("#{directory}/#{version}")
    end

    def fast_importer_for(importer_name)
      "UsdaNutrientDatabase::Import::Fast#{importer_name}".constantize.
          new("#{directory}/#{version}")
    end

    def downloader
      UsdaNutrientDatabase::Import::Downloader.new(directory, version)
    end
  end
end
