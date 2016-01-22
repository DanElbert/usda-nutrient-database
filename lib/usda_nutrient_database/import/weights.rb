module UsdaNutrientDatabase
  module Import
    module WeightsCommon

      def filename
        'WEIGHT.txt'
      end

      def columns
        @columns ||= [
            :nutrient_databank_number, :sequence_number, :amount,
            :measurement_description, :gram_weight, :num_data_points,
            :standard_deviation
        ]
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Importing weights'
      end
    end

    class Weights < Base
      include WeightsCommon

      def find_or_initialize(row)
        UsdaNutrientDatabase::Weight.find_or_initialize_by(
            nutrient_databank_number: row[0],
            sequence_number: row[1]
        )
      end
    end

    class FastWeights < FastBase
      include WeightsCommon

      def klass
        UsdaNutrientDatabase::Weight
      end
    end
  end
end
