# SPDX-FileCopyrightText: Copyright 2011-present Greg Hurrell and contributors.
# SPDX-License-Identifier: BSD-2-Clause

module CommandT
  class Scanner
    class HistoryScanner < Scanner
      def initialize(history_command)
        @history_command = history_command
      end

      def paths
        @paths ||= paths!
      end

    private

      def paths!
        VIM.capture(@history_command).split("\n")[2..-1].map do |line|
          line.sub(/\A>?\s*\d+\s*(.+)/, '\1').strip
        end.uniq
      end
    end
  end
end
