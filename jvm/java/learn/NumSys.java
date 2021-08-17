package learn;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

@SuppressWarnings("serial")
class InvalidFormatException extends Exception {
	InvalidFormatException(String num, String type) {
		super(String.format("ERROR %s is not a %s number", num, type));
	}
}

public class NumSys {
	// final char[] DIGITS =
	// {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
	static final String TYPE_BINARY = "binary";
	static final String TYPE_DECIMAL = "decimal";
	static final String TYPE_HEXADECIMAL = "hexadecimal";
	static final String TYPE_OCTAL = "octal";

	static boolean compareDigits(List<Character> digits, String num) {
		Set<Character> digitSet = new HashSet<>(digits);
		boolean result = true;
		for (int i = 0; i < num.length(); i++) {
			if (!digitSet.contains(num.charAt(i))) {
				result = false;
				break;
			}
		}
		return result;
	}

	static boolean isBinary(String binaryNum) {
		final List<Character> DIGITS = Arrays.asList('0', '1');
		return compareDigits(DIGITS, binaryNum);
	}

	static boolean isDecimal(String decimalNum) {
		final List<Character> DIGITS = Arrays.asList('0', '1', '2', '3', '4', '5', '6', '7', '8', '9');
		return compareDigits(DIGITS, decimalNum);
	}

	static boolean isHexadecimal(String hexadecimalNum) {
		final List<Character> DIGITS = Arrays.asList('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C',
				'D', 'E', 'F');
		return compareDigits(DIGITS, hexadecimalNum);
	}

	static boolean isOctal(String octalNum) {
		final List<Character> DIGITS = Arrays.asList('0', '1', '2', '3', '4', '5', '6', '7');
		return compareDigits(DIGITS, octalNum);
	}

	static Map<String, String> getFormats(int n) {
		Map<String, String> formats = new HashMap<>();
		formats.put(TYPE_DECIMAL, "" + n);
		return formats;
	}

	static void convertFromBinary(String binaryNum) throws InvalidFormatException {
		final String TYPE = TYPE_BINARY;
		if (!isBinary(binaryNum)) {
			throw new InvalidFormatException(binaryNum, TYPE);
		}
		int asDecimal;
		// TODO compute asDecimal
		Map<String, String> formats = getFormats(asDecimal);
		for (String key : formats.keySet()) {
			if (!key.equals(TYPE)) {
				System.out.println(key + ":\t" + formats.get(key));
			}

		}
	}

	static void convertFromDecimal(String decimalNum) throws InvalidFormatException {
		if (!isDecimal(decimalNum)) {
			throw new InvalidFormatException(decimalNum, "decimal");
		}
	}

	static void convertFromHexadecimal(String hexadecimalNum) throws InvalidFormatException {
		if (!isHexadecimal(hexadecimalNum)) {
			throw new InvalidFormatException(hexadecimalNum, "hexadecimal");
		}
	}

	static void convertFromOctal(String octalNum) throws InvalidFormatException {
		if (!isOctal(octalNum)) {
			throw new InvalidFormatException(octalNum, "octal");
		}
	}

	public static void main(String[] args) {
		try (Scanner sc = new Scanner(System.in)) {
			String num = sc.next();
			String type = sc.next();
			// System.out.println("num:\t" + num);
			// System.out.println("type:\t" + type);

			switch (type.toLowerCase().charAt(0)) {
			case 'b': // binary
				convertFromBinary(num);
				break;
			case 'd': // decimal
				convertFromDecimal(num);
				break;
			case 'h': // hexadecimal
				convertFromHexadecimal(num);
				break;
			case 'o': // octal
				convertFromOctal(num);
				break;
			default: // unknown
				System.out.println("ERROR unkown type: " + type);
				System.out.println("I can convert (b)inary, (d)ecimal, (h)exadecimal, and (o)ctal");
				break;
			}
		} catch (InvalidFormatException e) {
			System.out.println(e.getMessage());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
