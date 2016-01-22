module UsdaNutrientDatabase
  module Import
    module NutrientsCommon

      def columns
        @columns ||= [
            :nutrient_number, :units, :tagname, :nutrient_description,
            :number_decimal_places, :sort_record_order
        ]
      end

      def filename
        'NUTR_DEF.txt'
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Importing nutrients'
      end
    end
    class Nutrients < Base
      include NutrientsCommon

      def find_or_initialize(row)
        UsdaNutrientDatabase::Nutrient.
            find_or_initialize_by(nutrient_number: row[0])
      end
    end

    class FastNutrients < FastBase
      include NutrientsCommon

      def klass
        UsdaNutrientDatabase::Nutrient
      end
    end
  end
end
