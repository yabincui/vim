# SPDX-FileCopyrightText: Copyright 2011-present Greg Hurrell and contributors.
# SPDX-License-Identifier: BSD-2-Clause

module CommandT
  class Scanner
    # Returns a list of files in the jumplist.
    class JumpScanner < Scanner
      include PathUtilities

      def paths
        @paths ||= paths!
      end

    private

      def paths!
        jumps_with_filename = jumps.lines.select do |line|
          line_contains_filename?(line)
        end
        filenames = jumps_with_filename[1..-2].map do |line|
          relative_path_under_working_directory line.split[3]
        end

        filenames.sort.uniq
      end

      def line_contains_filename?(line)
        line.split.count > 3
      end

      def jumps
        VIM::capture 'jumps'
      end
    end
  end
end
