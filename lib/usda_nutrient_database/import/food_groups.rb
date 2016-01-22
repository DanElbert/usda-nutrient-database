module UsdaNutrientDatabase
  module Import
    module FoodGroupsCommon

      def columns
        @columns ||= %w(code description)
      end

      def filename
        'FD_GROUP.txt'
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Importing food groups'
      end
    end

    class FoodGroups < Base
      include FoodGroupsCommon

      def find_or_initialize(row)
        UsdaNutrientDatabase::FoodGroup.find_or_initialize_by(code: row[0])
      end
    end

    class FastFoodGroups < FastBase
      include FoodGroupsCommon

      def klass
        UsdaNutrientDatabase::FoodGroup
      end

    end
  end
end
