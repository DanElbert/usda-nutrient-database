require 'activerecord-import'

module UsdaNutrientDatabase
  module Import
    class FastBase < Base

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

      def klass
        raise NotImplementedError
      end
    end
  end
end
