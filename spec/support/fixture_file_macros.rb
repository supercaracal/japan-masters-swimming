module FixtureFileMacros
  def read_fixture_file(file_name)
    File.open(Rails.root.join('spec', 'fixtures', file_name), &:read)
  end
end
