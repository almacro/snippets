import static java.lang.System.*;
public class PalindromeChecker {
  public static void main(String[] args) {
    if(args == null || args.length < 1) {
      err.println("String is required!!");
      exit(1);
    }
    out.printf("The string {%s} is a Palindrome!! %b %n",
               args[0],
               StringUtils.isPalindrome(args[0]));
  }
}
public class StringUtils {
  public static Boolean isPalindrome(String word) {
    return (new StringBuilder(word))
        .reverse()
        .toString()
        .equalsIgnoreCase(word);
  }
}
