module TimeHelper
  def time_with_zone(options = nil)
    if options.is_a?(Hash)
      Time.zone.now.change(options)
    else
      Time.zone.now
    end
  end
end
