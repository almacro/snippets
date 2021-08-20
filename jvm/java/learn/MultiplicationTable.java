package learn;

public class MultiplicationTable {
	private static int multiplyNumbers(int num1, int num2) {
		return num1 * num2;
	}

	private static void renderTable(int xDim, int yDim) {
		// print header row
		System.out.print("\t|");
		for (int i = 1; i <= xDim; i++) {
			System.out.printf("\t%3d",i);
		}
		System.out.println();
		for (int i = 1; i <= xDim; i++) {
			System.out.print("---------");
		}
		System.out.println();
		
		// print table
		for (int i = 1; i <= xDim; i++) {
			// print header column
			System.out.print(i+"\t|");
			for (int j = 1; j <= yDim; j++) {
				System.out.printf("\t%3d", multiplyNumbers(i, j));
			}
			System.out.println();
		}

	}

	public static void main(String[] args) {
		renderTable(12, 12);
	}

}
