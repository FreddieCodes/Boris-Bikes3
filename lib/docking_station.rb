class DockingStation

  attr_reader :bikes

  def initialize
    @bikes = []
  end

  def release_bike
    Bike.new
  end

  def dock(bike)
    @bikes << bike
   return bike
  end

  def show_bikes
    @bikes
  end

end
