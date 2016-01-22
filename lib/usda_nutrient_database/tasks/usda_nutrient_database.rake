namespace :usda do
  desc 'Import the latest USDA nutrition data'
  task import: :environment do
    UsdaNutrientDatabase::Importer.new('tmp/usda', 'sr27').import
  end

  desc 'Fast Import the latest USDA nutrition data, clearing the tables first and skipping validations'
  task fast_import: :environment do
    UsdaNutrientDatabase::Importer.new('tmp/usda', 'sr27').fast_import
  end

  [
    'Weights', 'Footnotes', 'FoodGroups', 'Foods', 'FoodsNutrients',
    'Nutrients', 'SourceCodes'
  ].each do |importer_name|
    desc "Import the USDA #{importer_name} table"
    task "import_#{importer_name.downcase}" => :environment do
      download_and_import(importer_name)
    end

    desc "Fast Import the USDA #{importer_name} table"
    task "fast_import_#{importer_name.downcase}" => :environment do
      download_and_import(importer_name, true)
    end
  end

  def download_and_import(importer_name, is_fast = false)
    UsdaNutrientDatabase::Import::Downloader.new('tmp/usda', 'sr27').
      tap do |downloader|
      downloader.download_and_unzip
      "UsdaNutrientDatabase::Import::#{is_fast ? 'Fast' : ''}#{importer_name}".constantize.
        new('tmp/usda/sr27').import
      downloader.cleanup
    end
  end
end