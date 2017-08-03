class DockingStation
  attr_reader :bikes

  # constants

  def initialize(cap = 20)
    @bikes = []
    @capacity = cap
  end

  def release_bike(count = 1)

    released_bikes = []

    @bikes.each_with_index do |bike, index|
      raise 'No bikes available' if empty?
      if bike.working?
        released_bikes << bike
        @bikes.delete_at index

        if released_bikes.length == count
          puts "#{released_bikes.length} bikes released from the station"
          puts "#{@bikes.length} bikes left in the sation"
          return released_bikes
        end
      end
    end
    raise 'No bikes available'
  end

  def dock(bike)
    raise 'Docking Station full' if full?

    @bikes << bike if bike.class == Bike
    return bike
  end


  def show_bikes
    @bikes
  end

  def stock_bikes(n = @capacity)
    n = available_space if (n+@bikes.length) > @capacity
    n.times {@bikes << Bike.new}
    "#{n} new bike#{"s" if n>1} have been stocked into the docking station"
  end

private

  def full?
    @bikes.length == @capacity
  end

  def empty?
    @bikes.length == 0
  end

  def available_space
    @capacity - @bikes.length
  end
end
