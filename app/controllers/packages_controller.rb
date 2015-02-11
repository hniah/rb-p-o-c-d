class PackagesController < ApplicationController

  def buy_package
    @packages = Package.all_packages_in_array

    @sessions_type_list = Package::SESSION_TYPE_LIST
    @packages_follow_session = []
    @sessions_type_list.each do |session_type|
      @index = 0
      @packages[session_type].each do |package|
        if @packages_follow_session[@index].nil?
          @packages_follow_session[@index] = []
        end
        @packages_follow_session[@index] << package
        @index+=1;
      end
    end
  end

end
