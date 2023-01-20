# SPDX-FileCopyrightText: Copyright 2010-present Greg Hurrell and contributors.
# SPDX-License-Identifier: BSD-2-Clause

require 'spec_helper'

describe CommandT::Scanner::FileScanner do
  before do
    dir = File.join(File.dirname(__FILE__), '..', '..', '..', 'fixtures')
    @scanner = CommandT::Scanner::FileScanner.new(dir)
  end

  describe 'flush method' do
    it 'forces a rescan on next call to paths method' do
      expect { @scanner.flush }.
        to change { @scanner.instance_variable_get('@paths').object_id }
    end
  end
end
