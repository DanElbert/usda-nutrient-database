module UsdaNutrientDatabase
  module Import
    module FootnotesCommon
      def filename
        'FOOTNOTE.txt'
      end

      def columns
        @columns ||= [
            :nutrient_databank_number, :footnote_number, :footnote_type,
            :nutrient_number, :footnote_text
        ]
      end

      def log_import_started
        UsdaNutrientDatabase.log 'Importing footnotes'
      end
    end

    class Footnotes < Base
      include FootnotesCommon

      def find_or_initialize(row)
        UsdaNutrientDatabase::Footnote.find_or_initialize_by(
            nutrient_databank_number: row[0], footnote_number: row[1],
            nutrient_number: row[2]
        )
      end
    end

    class FastFootnotes < FastBase
      include FootnotesCommon

      def klass
        UsdaNutrientDatabase::Footnote
      end
    end
  end
end
