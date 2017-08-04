require 'docking_station.rb'

describe DockingStation do
  let(:bike) { double :bike }
  # If you try to create a broken bike you'll need to create
  # another let. See below.
  let(:broken_bike) { double :bike }

  it {expect(subject).to respond_to :release_bike}

  it 'gets a bike' do
    # Can out it into a kind of hash
    allow(bike).to receive_messages(
    #  :report_broken => nil,
      :working? => true,
      :class => Bike)
    # or
    # allow(bike).to receive(:report_broken)
    # allow(bike).to receive(:working?).and_return(true)
    # allow(bike).to receive(:class).and_return(Bike)

    subject.dock(bike)
    expect(subject.release_bike).to be_truthy
  end

  it 'can dock a bike' do
    expect(subject).to respond_to :dock
  end

  it 'docks specific bike' do
    bike = double(:bike)
    expect(subject.dock(bike)). to eq(bike)
  end

  it {expect(subject).to respond_to :show_bikes}

  it 'shows a bike' do
    allow(bike).to receive_messages(
      :class => Bike
    )
    subject.dock(bike)
    expect(subject.show_bikes).to include bike
  end

  it 'shows all bikes' do
    allow(bike).to receive_messages(
      # :report_broken => nil,
      # :working? => true,
      :class => Bike)
    10.times {subject.dock bike}
    expect(subject.show_bikes.length).to eq(10)
  end

  it 'does not release bikes from an empty station' do
    expect{subject.release_bike}.to raise_error('No bikes available')
  end

  it 'can not dock when station is full' do
    allow(bike). to receive_messages(
      :class => Bike
    )
    20.times {subject.dock bike}
    expect{subject.dock(bike)}.to raise_error('Docking Station full')
  end

  it "can release multiple bikes" do
    allow(bike). to receive_messages(
      :class => Bike,
      :working? => true
    )
    3.times {subject.dock bike}
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

  it "can have two parameters" do
    expect(subject).to respond_to(:dock).with(2).arguments
  end

  it 'can report a bike as broken' do
    allow(bike). to receive_messages(
      :report_broken => nil,
      :class => Bike
    )
    # bike = double(:bike)
    expect(bike).to respond_to :report_broken
  end

  it 'does not release broken bikes' do
    allow(bike). to receive_messages(
    :class => Bike,
    :working? => true,
    :report_broken => nil
    )
    subject.dock(bike, true)
    expect{subject.release_bike}.to raise_error('No bikes available')
  end


end
