require "docking_station.rb"

describe DockingStation do
  it {expect(subject).to respond_to :release_bike}

  it "gets a bike" do
    bike = subject.release_bike
    expect(bike).to be_truthy
  end

  it "can dock a bike" do
    expect(subject).to respond_to :dock
  end

  it "docks specific bike" do
    bike = Bike.new
    expect(subject.dock(bike)). to eq(bike)
  end

  it {expect(subject).to respond_to :show_bikes}

  it "shows a bike" do
    bike = Bike.new
    subject.dock(bike)
    expect(subject.show_bikes).to include bike
  end

  it "shows all bikes" do
    10.times {subject.dock(Bike.new)}
    expect(subject.show_bikes.length).to eq(10)
  end

  


end
