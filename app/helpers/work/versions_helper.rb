module Work::VersionsHelper
  def version_params(hash={})
    hash.delete_if {|key, value| !(Version.column_names.include? key.to_s) }
    Hash[:version, hash]
  end
end
