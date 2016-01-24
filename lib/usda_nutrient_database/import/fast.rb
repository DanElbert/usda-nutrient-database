require 'activerecord-import'

module UsdaNutrientDatabase
  module Import
    module Fast

      BATCH_SIZE = 1000

      def import
        log_import_started
        clear_table
        batch = []
        CSV.open(file_location, 'r:iso-8859-1:utf-8', csv_options) do |csv|
          csv.each do |row|
            batch << apply_typecasts(row).slice(0, columns.length)

            if batch.length >= BATCH_SIZE
              process_batch(batch)
              batch = []
            end
          end
        end

        process_batch(batch) unless batch.empty?
      end

      def process_batch(batch)
        klass.import columns, batch, validate: false
      end

      def clear_table
        klass.delete_all
      end
    end

    class FastFoodGroups < FoodGroups
      include Fast
    end

    class FastFoods < Foods
      include Fast
    end

    class FastFootnotes < Footnotes
      include Fast
    end

    class FastNutrients < Nutrients
      include Fast
    end

    class FastSourceCodes < SourceCodes
      include Fast
    end

    class FastWeights < Weights
      include Fast
    end
  end
end
