module Tournament
  module LineParsers
    class FindPlaceAndReward < LineParser
      def initialize(line, opts)
        super
        @nickname = opts[:nickname]
      end

      private

      def pattern
        /(?<place>\d+): (?<nickname>\w+) .+\), (\$(?<reward>\d+\,\d+))*/
      end

      def result_to_hash
        raise_wrong_user_error! unless @parse_result[:nickname] == @nickname
        super
        @formatted_result.delete(:nickname)
        @formatted_result[:reward] ||= '0,00'
      end

      def raise_wrong_user_error!
        error_text = "#{@line}: found #{@parse_result[:nickname]} expected #{@nickname}"
        raise Tournament::Parser::WrongUserException, error_text
      end
    end
  end
end
