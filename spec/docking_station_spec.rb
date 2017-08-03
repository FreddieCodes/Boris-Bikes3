require 'docking_station.rb'

describe DockingStation do
  it {expect(subject).to respond_to :release_bike}

  it 'gets a bike' do
    subject.dock(Bike.new)
    bike = subject.release_bike
    expect(bike).to be_truthy
  end

  it 'can dock a bike' do
    expect(subject).to respond_to :dock
  end

  it 'docks specific bike' do
    bike = Bike.new
    expect(subject.dock(bike)). to eq(bike)
  end

  it {expect(subject).to respond_to :show_bikes}

  it 'shows a bike' do
    bike = Bike.new
    subject.dock(bike)
    expect(subject.show_bikes).to include bike
  end

  it 'shows all bikes' do
    10.times {subject.dock(Bike.new)}
    expect(subject.show_bikes.length).to eq(10)
  end

  it 'does not release bikes from an empty station' do
    expect{subject.release_bike}.to raise_error('No bikes available')
  end

  it 'can not dock when station is full' do
    20.times {subject.dock(Bike.new)}
    expect{subject.dock(Bike.new)}.to raise_error('Docking Station full')
  end

  it "can release multiple bikes" do
    3.times {subject.dock(Bike.new)}
    subject.release_bike(2)
    expect(subject.bikes.length).to eq(1)
  end

  it 'has a default capacity of 20' do
    expect(subject.capacity).to eq(20)
  end

  it 'can have a custom capacity' do
    big_station = DockingStation.new(100)
    expect(big_station.capacity).to eq(100)
  end
end
