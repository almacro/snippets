import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import java.util.stream.Collectors;
import java.util.stream.Stream;

@SuppressWarnings("serial")
class InvalidFormatException extends Exception {
    InvalidFormatException(String num, String type) {
	super(String.format("ERROR %s is not a %s number", num, type));
    }
}

public class NumSys {
    static final String TYPE_BINARY      = "binary";	   
    static final String TYPE_DECIMAL     = "decimal";	
    static final String TYPE_HEXADECIMAL = "hexadecimal";	
    static final String TYPE_OCTAL       = "octal";

    static final String[] KEYS = {
	    TYPE_BINARY,
	    TYPE_HEXADECIMAL,
	    TYPE_OCTAL,
	    TYPE_DECIMAL,
    };
    
    static final Map<String,String> binToHex = Stream.of(new String[][] {
	    { "0000", "0" },
	    { "0001", "1" },
	    { "0010", "2" },
	    { "0011", "3" },
	    { "0100", "4" },
	    { "0101", "5" },
	    { "0110", "6" },
	    { "0111", "7" },	    	    
	    { "1000", "8" },
	    { "1001", "9" },
	    { "1010", "a" },
	    { "1011", "b" },	    	    	    	    
	    { "1100", "c" },
	    { "1101", "d" },	    	    	    	    
	    { "1110", "e" },
	    { "1111", "f" },
	}).collect(Collectors.toMap(data -> data[0], data -> data[1]));
    
    static final String HEX_DIGITS = "0123456789abcdef";

    static long powerBase(final int BASE, final int EXP) {
	long r = 1;
	for(int i=0; i<EXP; ++i)
	    r *= BASE;
	return r;
    }
    
    static long power16(int exp) {
	return powerBase(16, exp);
    }
    static long power8(int exp) {
	return powerBase(8, exp);
    }
    
    static Map<String, String> getFormats(long n) {
	Map<String, String> formats = new HashMap<>();
	
	formats.put(TYPE_DECIMAL,     "" + n);
	formats.put(TYPE_BINARY,      Long.toBinaryString(n));
	formats.put(TYPE_OCTAL,       Long.toOctalString(n));
	formats.put(TYPE_HEXADECIMAL, Long.toHexString(n));
		    
	return formats;
    }

    static void printFormats(long n) {
	Map<String,String> fmts = getFormats(n);	
	for(String key : KEYS) 
	    System.out.printf("%-15s\t%s\n", key+":", fmts.get(key));
    }

    static long hexToDec(String hex) {
	long dec = 0;
	final int LEN = hex.length();
	for(int i = LEN; i > 0; --i) {
	    char ch = hex.charAt(i-1);
	    dec += HEX_DIGITS.indexOf(ch) * power16(LEN-i);
	}
	return dec;
    }
    
    static long octToDec(String oct) {
	long dec = 0;
	final int LEN = oct.length();
	for(int i = LEN; i > 0; --i) {
	    char ch = oct.charAt(i-1);
	    dec += HEX_DIGITS.indexOf(ch) * power8(LEN-i);
	}
	return dec;
    }
    static boolean compareDigits(final String DIGITS, String num) {
	boolean result = true;
	for(int i=0; i<num.length(); ++i) {
	    if(!DIGITS.contains(num.subSequence(i,i+1))) {
		result = false;
		break;
	    }
	}
	return result;
    }
    static boolean isBinary(String binaryNum) {
	final String DIGITS = HEX_DIGITS.substring(0, 2);
	return compareDigits(DIGITS, binaryNum);
    }
    static boolean isOctal(String octalNum) {
	final String DIGITS = HEX_DIGITS.substring(0, 8);
	return compareDigits(DIGITS, octalNum);
    }
    static boolean isDecimal(String decimalNum) {
	final String DIGITS = HEX_DIGITS.substring(0, 10);
	return compareDigits(DIGITS, decimalNum);
    }
    static boolean isHexadecimal(String hexNum) {
	return compareDigits(HEX_DIGITS, hexNum);
    }
    
    static void convertFromBinary(String bin) throws InvalidFormatException {
	final String TYPE = TYPE_BINARY;
	if(!isBinary(bin)) 
	    throw new InvalidFormatException(bin, TYPE);

	final int LEN = bin.length();
	final int PAD_LEN = LEN % 4;
	final String PAD = "000".substring(0,PAD_LEN);
	bin = PAD + bin;
	int i = 0;
	StringBuilder hexBuilder = new StringBuilder();
	while(i < LEN) {
	    String sub = bin.substring(i,i+4);
	    hexBuilder.append( binToHex.get(sub) );
	    i += 4;
	}
	printFormats(hexToDec(hexBuilder.toString()));
    }
    
    static void convertFromDecimal(String dec) throws InvalidFormatException {
	if(!isDecimal(dec))
	    throw new InvalidFormatException(dec, TYPE_DECIMAL);
	
	long num = Long.valueOf(dec).longValue();
	printFormats(num);
    }
    
    static void convertFromHexadecimal(String hex) throws InvalidFormatException {
	if(!isHexadecimal(hex))
	    throw new InvalidFormatException(hex, TYPE_HEXADECIMAL);

	printFormats(hexToDec(hex));
    }
    
    static void convertFromOctal(String oct) throws InvalidFormatException {
	if(!isOctal(oct))
	    throw new InvalidFormatException(oct, TYPE_OCTAL);

	printFormats(octToDec(oct));
    }
    
    public static void main(String[] args) {
	try (Scanner sc = new Scanner(System.in)) {
	    String num = sc.next();
	    String type = sc.next();

	    switch(type.toLowerCase().charAt(0)) {
	    case 'b': // binary
		convertFromBinary(num);
		break;
	    case 'd': // decimal
		convertFromDecimal(num);
		break;
	    case 'h': // hexadecimal
		convertFromHexadecimal(num);
		break;
	    case 'o': // octal;
		convertFromOctal(num);
		break;
	    default:  // unknown
		System.out.println("ERROR unknown type: " + type);
		System.out.println("I can convert (b)inary, (d)ecimal, (h)exadecimal, (o)ctal");
		break;
	    }
	} catch(InvalidFormatException e) {
	    System.out.println(e.getMessage());
	} catch(Exception e) {
	    e.printStackTrace();
	}
    }
}
