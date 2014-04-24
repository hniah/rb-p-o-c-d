module TimeHelper
  def time_with_zone(options = nil)
    if options.is_a?(Hash)
      Time.zone.now.tomorrow.change(options)
    else
      Time.zone.now.tomorrow
    end
  end

  def TimeStub(date,month,year)
    Time.stub(:now).and_return(Time.mktime( year, month, date ))
  end
end
