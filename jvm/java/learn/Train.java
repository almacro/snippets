package learn;

public class Train {
	private String name;
	private boolean isDiesel;
	private int numPassengers;
	public Train(String name, boolean isDiesel) {
		this.name = name;
		this.isDiesel = isDiesel;
		numPassengers = 0;
	}
	public String getName() {
		return name;
	}

	public boolean isDiesel() {
		return isDiesel;
	}

	public int getNumPassengers() {
		return numPassengers;
	}

	public void addPassengers(int numPassengersToAdd) {
		numPassengers += numPassengersToAdd;
	}
	public void unloadPassengers() {
		numPassengers = 0;

	}
	public static void main(String[] args) {
		Train train = new Train("Thomas", false);
		System.out.println("\ncreated new train named "+train.getName());
		System.out.println("\nthis train is "+ (train.isDiesel() ? "":"not") +" a diesel train.");
		for(int i = 0; i < 3; i++) {
			int num = (int) (Math.random() * 20);
		
			train.addPassengers(num);
			System.out.println("\ntrain stopped and picked up "+num+" passengers.\nThere are now "+train.getNumPassengers()+" aboard.");
		}
		train.unloadPassengers();
		System.out.println("\ntrain unloaded passengers.\nThere are now "+train.getNumPassengers()+" aboard.");
	}
}

