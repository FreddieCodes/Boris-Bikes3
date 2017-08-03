class DockingStation

  attr_reader :bikes

  def initialize
    @bikes = []
  end

  def release_bike
    raise 'No bikes available' if @bikes.empty?
    Bike.new
  end

  def dock(bike)
    @bikes << bike if bike.class == Bike
   return bike
  end

  def show_bikes
    @bikes
  end

end
