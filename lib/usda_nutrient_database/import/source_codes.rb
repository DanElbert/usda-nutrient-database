module UsdaNutrientDatabase
  module Import
    module SourceCodesCommon

      def columns
        [:code, :description]
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Source code import started'
      end

      def filename
        'SRC_CD.txt'
      end
    end

    class SourceCodes < Base
      include SourceCodesCommon

      def find_or_initialize(row)
        UsdaNutrientDatabase::SourceCode.find_or_initialize_by(code: row[0])
      end
    end

    class FastSourceCodes < FastBase
      include SourceCodesCommon

      def klass
        UsdaNutrientDatabase::SourceCode
      end
    end
  end
end
