package basic;

import java.util.ArrayDeque;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Deque;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.Stack;
import java.util.TreeSet;
import java.util.function.Predicate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

/**
 *
 * @author almacro
 */
public class Strings {
    
    static Set findDupes(String s) {
        if (s == null || s.isEmpty()) {
            return null;
        }
        
        Map<Character, Integer> charCount = new HashMap<>();
        int i = 0;
        while (i < s.length()) {
            Character ch = Character.toLowerCase(Character.valueOf(s.charAt(i)));
            int c = 1;
            if (charCount.containsKey(ch)) {
                c += charCount.get(ch);
            }
            charCount.put(ch, c);
            ++i;
        }
        return charCount.entrySet().stream()
                .filter(map -> map.getValue() > 1)
                .collect(Collectors.toMap(p -> p.getKey(),
                                p -> p.getValue()))
                .keySet();
    }
    
    static void demoDupeChars() {
        List<String> strList = Arrays.asList("Java", "Programming", "Collections", "Advanced", "Combiner", null, "");
        
        for (String s : strList) {
            System.out.printf("word %s has dupe chars: %s\n", s, findDupes(s));
        }
    }
    
     final static String WHITESPACE = " \n\r";
     final static Predicate<Character> isNotWhitespace = (c) -> !WHITESPACE.contains( ""+c);
     
     final static String PUNCTUATION = "(){}[]-.,;?!:;'\"";
     final static Predicate<Character> isNotPunctuation = (c) ->!PUNCTUATION.contains(""+c);
       
    static String normalizeString(String s) {
        String r = s.toLowerCase();
        return IntStream.range(0, s.length())
                .mapToObj(i -> r.charAt(i))
                .filter(isNotWhitespace.and(isNotPunctuation))
                .map(c -> "" + c)
                .sorted()
                .collect(Collectors.joining());
    }
     
    static boolean isAnagram(String a, String b) {
        if (a != null && b != null) {

            if(a.length() != b.length()) return false;
            
            a = normalizeString(a);
            b = normalizeString(b);

            return a.equals(b);
        } else {
            return false;
        }
    }
 
    static void demoAnagramCheck() {
        String[] ss = {
            "mary", "army",
            "stop", "tops",
            "ccc", "cccccccc",
            "fill", "fil",
            "a", "a",
            "sisters", "resist",
            "steaks", "stakes",
            "sadder", "dread's",
            
            "Said the little boy, \"Sometimes I drop my spoon.\"\n"
            + "Said the old man, \"I do that too.\"\n"
            + "The little boy whispered, \"I wet my pants.\"\n"
            + "\"I do that too,\" laughed the little old man.\n"
            + "Said the little boy, \"I often cry.\"\n"
            + "The old man nodded, \"So do I.\"\n"
            + "\"But worst of all,\" said the boy, \"it seems\n"
            + "Grown-ups don't pay attention to me.\"\n"
            + "And he felt the warmth of a wrinkled old hand.\n"
            + "\"I know what you mean,\" said the little old man.\n",
            
            "The tiny tot went: \"When I eat I mess up.\"\n"
            + "The elder replied: \"O, that makes two of us.\"\n"
            + "\"I soil myself,\" went the tot with shame\n"
            + "And the elder added: \"O, I do the same.\"\n"
            + "On the tot told him: \"I sob a lot.\"\n"
            + "\"O, not only you,\" answered gramps to the tot.\n"
            + "\"And what's totally bad,\" the tiny tot told,\n"
            + "\"I think mom and dad don't love me at all.\"\n"
            + "While grandpa simply, pitiably smiled,\n"
            + "then said: \"O, I understand, my child.\"\n"
        };
 
        for (int i = 0; i < ss.length; i += 2) {
            String p1 = ss[i], p2 = ss[i + 1];
            System.out.printf("strings %s and %s are%s anagrams.\n", 
                    p1, p2, 
                    (isAnagram(p1,p2) ? "" : " NOT"));
        }
    }
     
    static Character findFirstUnique(String s) {
        if (s == null || s.isEmpty()) {
            throw new RuntimeException("empty input!");
        }
        
        String r = s.toLowerCase();
        HashMap<Character, Integer> charCount = new LinkedHashMap<>();
        for( int i = 0; i < s.length(); i++) {
            Character ch = r.charAt(i);
            int c = 1;
            if (charCount.containsKey(ch)) {
                c += charCount.get(ch);
            }
            charCount.put(ch, c);            
        }

        Character result = null;
        for(Map.Entry<Character, Integer> entry : charCount.entrySet()) {
            if(entry.getValue() == 1) {
                result = entry.getKey();
                break;
            }
        }
        
        int i = r.indexOf(result);
        return s.charAt(i);
    }
    
    static boolean isUnique(char ch, String s) {
        int c = 0;
        for(int i=0; i<s.length(); i++) {
            if(s.charAt(i) == ch) {
                ++c;
            }
        }
        return (c == 1);
    }
    static Character findFirstUnique2(String s) {
        if(s == null || s.isEmpty()) {
            throw new RuntimeException("empty input!");
        }
        
        String r = s.toLowerCase();
        int i =0;
        Character result = null;
        while(i < s.length()) {
            char ch = r.charAt(i);
            if(isUnique(ch,r)) {
                result = s.charAt(i);
                break;
            }
            ++i;
        }
        return result;
    }
    
    static void demoFindFirstUnique() {
        String[] ss = { "Morning", "Goodnight", "anaconda", "antidisestablishmentarianism", "anarchist" };
        for(String s : ss) {
            System.out.printf("the first unique character in \'%s\' is %c\n", s, findFirstUnique(s));
            System.out.printf("the first unique character in \'%s\' is %c\n", s, findFirstUnique2(s));
        }
    }
    
    static String iterativeReverseString(String s) {
        char[] chars = s.toCharArray();
        int i = s.length();
        int j = 0;
        while(i > j) {
            char t = chars[j];
            chars[j++] = chars[--i];
            chars[i] = t;
        }
        return new String(chars); 
    }
    
    static String reverseRecurse(char[] arr, int i, int j) {
        String s = "";
        j -= 1;
        if (i == j) {
            s = "" + arr[i];
        }
        if (i < j) {
            s = arr[j] + reverseRecurse(arr, i + 1, j) + arr[i];
        }
        return s;
    }
    static String recursiveReverseString(String s) { 
        char[] chars = s.toCharArray();
        return reverseRecurse(chars, 0, chars.length);
    }
    
    static void demoReverseString() {
        String[] ss = { "radar", "mirror", "racecar", "reed", "top" };
        for(String s : ss) {
            System.out.printf("reverse of %s is %s\n", s, iterativeReverseString(s));
            System.out.printf("reverse of %s is %s\n", s, recursiveReverseString(s));
        }
    }
    
    static boolean isNumbersOnly(String s) {
        return s.matches("^\\d+$");
    }
    
    static void demoNumericCheck() {
        //  check if a string only contains numbers via regex
        /*
        
        echo 1234 | grep '[0-9]\+'
        echo 1234 | grep '^[0-9]\+$'
        echo 1234 | grep '^\d\+$'
        echo 1234 | grep '[[:digit:]]\+'
        
        echo 1234 | egrep '[0-9]+'
        echo 1234 | egrep '^[0-9]+$'
        echo 1234 | egrep '[[:digit:]]+'
        
        echo 1234 | perl -ne '/^[0-9]+$/ && print'
        echo 1234 | python -c "import sys,re; [print(re.search(r'^\d+$', line).group()) for line in sys.stdin]"
        */
        String[] ss = { "1234", "10000100000", "12r49b", "0xdeadbeef", "987543",
                              "10^20", "50-49-1995", "1122334455", "1,3,2,00,59", "*787*1234"  };
        
        for(String s: ss) {
                  System.out.printf("string %s%s only digits.\n", 
                    s, 
                    (isNumbersOnly(s) ? " contains" : " does NOT contain"));      
        }
    }
   
    static boolean isANumber(String s) {
        return false;
    }

    static void demoNumberCheck() {
        /*
        -9.0
        -9/0
        +10
        +/-10
        1
        2.34
        1/3
        1/2/2017
        0.9999999999999999999999
        0.9999999999999999999.999
        ++i
        c++
        169.254.169.254
        5 1 1 1
        123abcdefg
        1.41421E-9
        5.678e+23
        001.2345
        1,000,000
        
        */
    }
    
    static void reportDupeChars(String s) {
        if (!(s == null || s.isEmpty())) {

            String r = s.toLowerCase();
            HashMap<Character, Integer> map = new LinkedHashMap<>();
            for (int i = 0; i < r.length(); i++) {
                Character ch = r.charAt(i);
                int j = 1;
                if (map.containsKey(ch)) {
                    j += map.get(ch);
                }
                map.put(ch, j);
            }

            map.entrySet().stream()
                    .filter(m -> m.getValue() > 1)
                    .forEach(m -> {
                        System.out.printf("%c : %d\n", m.getKey(), m.getValue());
                    });
        }
    }
    
    static void demoReportDupeChars() {
        String[] ss = { "Programming", "antidisestablishmentarianism", "110010011111000011011000" };
        for(String s: ss) {
            System.out.println("----\nduplicate chars for "+s);
            reportDupeChars(s);
        }
    }
    
    final static String VOWELS = "aeiou";
    static String filterCharsToString(IntStream intStream, Predicate<Character> pred) {
        return intStream.mapToObj(c -> (char)c)
                .filter(pred)
                .map(c -> ""+c)
                .collect(Collectors.joining());
    }
    static String CONSONANTS = filterCharsToString(IntStream.rangeClosed('a', 'z'), c -> !VOWELS.contains(""+c));

    /*
    static void countVowelsAndConsonants(String s) {
        String r = s.toLowerCase();
        int vc = filterCharsToString(r.chars(), c -> VOWELS.contains("" + c)).length();
        int cc = filterCharsToString(r.chars(), c -> !VOWELS.contains("" + c)).length();
        /* if s contains non-alpha cars use:
            int cc = filterCharsToString(r.chars(), c -> CONSONANTS.contains("" + c)).length();
        * /
        System.out.printf("%d vowels and %d consonants\n", vc, cc);
    }
    */

    // implement count method with regex
    static int getPatternCount(String regex, String s) {
        int c = 0;
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(s);
        while(matcher.find()) {
            ++c;
        }
        return c;
    }
    
    static void countVowelsAndConsonants(String s) {
        String r = s.toLowerCase();

        int vc = getPatternCount("["+VOWELS+"]",s);
        int cc = getPatternCount("[\\p{Alpha}&&[^"+VOWELS+"]]",s);
        System.out.printf("%d vowels and %d consonants\n", vc, cc);
    }

    static void demoCountVowelsAndConsonants() {
        String[] ss = { "Java", "antidisestablishmentarianism", "Haskell", "functor", "Scala", "monoid" };
        for(String s : ss) {
            System.out.printf("----\ncounts for string %s\n",s);
            countVowelsAndConsonants(s);
        }
    }
    /* classic 
    static int countChars(char ch, String s) {
        int c = 0;
        if (s != null && !s.isEmpty()) {
            for (int i = 0; i < s.length(); i++) {
                if (ch == s.charAt(i)) {
                    ++c;
                }
            }
        }
        return c;
    }
     */
    /* lambda */
    
    static int countChars(char ch, String s) {
        int n = 0;
        if (s != null && !s.isEmpty()) {
            n = s.chars()
                    .boxed()
                    .filter(c -> ch == c)
                    .map(c -> "" + c)
                    .collect(Collectors.joining())
                    .length();
        }
        return n;
    }
    
    
    //  implement with regex
    /*
    static int countChars(char ch, String s) {
        return getPatternCount(""+ch, s);
    }
    */
    
    static void demoCountChars() {
        String[] ss = {"Java", "antidisestablishmentarianism", "Haskell", "functor", "Scala", "monoid"};
        for (String s : ss) {
            String r = s.toLowerCase();
            int i = (new Random()).nextInt(s.length());
            char ch = r.charAt(i);
            System.out.printf("count of %c's in \"%s\" is %d\n", ch, s, countChars(ch, r));
        }
    }
    
    static int stringToInt(String s) {
        final char ZERO = '0';
        int n = 0;
        int sgn = 1;
        if (s != null && !s.isEmpty()) {
            for (int i = 0; i < s.length(); i++) {
                char ch = s.charAt(i);
                switch(ch) {
                    case '-':
                        sgn = -1;
                        break;
                    case '+':
                        break;
                    default:
                        n = n * 10 + ch - ZERO;
                }        
            }
        }
        return n * sgn;
    }
    
    static void demoStringToInt() {
        String[] ss = { "67263", "+12345", "-98765", "", null, "+", "-" };
        for(String s: ss) {
            System.out.printf("\"%s\" converted to int is %d\n", s, stringToInt(s));
        }
    }
    /*
    static String replaceChar(char ch, CharSequence seq, String s) {
        StringBuilder r = new StringBuilder();
        if(s != null && !s.isEmpty()) {
            int i = 0, j;
            while((j = s.indexOf(ch,i)) > 0) {
                r.append( s.substring(i,j) + seq );
                i = j+1;
            }
            r.append( s.substring(i,s.length()) );
        }
        return r.toString();
    }
    */
    
    static String replaceChar(char ch, CharSequence seq, String s) {
        if(s == null) return null;
        return s.replace(""+ch, seq);
    }
    
    static void demoReplaceChar() {
        String[] ss = { "Java is Great", "", null, "Automate all the things"};
        for(String s : ss) {
            String r = replaceChar(' ', "%20", s);
            System.out.printf("%s => %s\n", s, r);
        }
    }
    
    static Set<String> NULL_SET = Collections.singleton("");
   /* recursive
    static Set<String> permute(String s) {
        Set<String> r = NULL_SET;
        if(s != null && !s.isEmpty()) {
            r = new TreeSet<>();
            for(int i=0; i<s.length(); i++) {
                char ch = s.charAt(i);
                Set<String> t = permute(s.substring(0,i)+s.substring(i+1, s.length()));
                for(String str: t) {
                    r.add(ch + str);
                }
            }
        }
        return r;
    }
   */
    static int factorial(int n) {
        int r = 1;
        int i = n;
        while(i > 1) {
            r *= i--;
        }
        return r;
    }
    
    static String getPermutation(int n, String s) {
        final int LEN = s.length();
        int[] f = new int[LEN];
        
        switch(n) {
            case 0:
                break;
            case 1:
                f[LEN-2] = 1;
                break;
            default:
                for(int i=1; i<=LEN; i++) {
                    f[LEN-i] = n % i;
                    n = n / i;
                }
        }
        
        StringBuilder bag = new StringBuilder(s);
        StringBuilder res = new StringBuilder();
        for(int i=0; i<LEN; i++) {
            int j = f[i];
            j = Math.min(j, bag.length()-1);
            char ch = bag.charAt(j);
            res.append(ch);
            bag.deleteCharAt(j);
        }
        
        return res.toString();
    }
    
    static Set<String> permute(String s) {
        Set<String> r = NULL_SET;
        if(s != null && !s.isEmpty()) {
            r = new TreeSet<>();
            int i = 0;
            final int LIMIT = factorial(s.length());
            while(i < LIMIT) {
                r.add(getPermutation(i, s));
                ++i;
            }
        }
        return r;
    }
    
    static void demoPermute() {
        String[] ss = { "abc", "wxyz", "radar", "stop", null, "" };
        for(String s: ss) {
            Set<String> permutations = permute(s);
            System.out.printf("-----\npermutations of %s: %s\n", s, permutations.stream().collect(Collectors.joining(", ")));
        }
    }
    
    /*
    static String reverseWords(String s) {
        String r = "";
        if (s != null && !s.isEmpty()) {
            String[] ws = s.split("\\s");
            int i = ws.length;
            int j = 0;
            while (i > j) {
                String t = ws[j];
                ws[j++] = ws[--i];
                ws[i] = t;
            }
            r = Arrays.stream(ws).collect(Collectors.joining(" "));
        }
        return r;
    }
    */
    
    //  implement with regex
    static String reverseWords(String s) {
        String r = "";
        if(s != null && !s.isEmpty()) {
            Deque<String> stack = new ArrayDeque<>();
            Pattern pattern = Pattern.compile("(\\w)+");
            Matcher matcher = pattern.matcher(s);
            while(matcher.find()) {
                stack.push(matcher.group());
            }
            Iterable<String> iterable = () -> stack.iterator();
            r = StreamSupport.stream(iterable.spliterator(), false).collect(Collectors.joining(" "));
        }
        return r;
    }
    
    static void demoReverseWords() {
        String s = "Java is best programming language";
        System.out.printf("%s => %s\n", s, reverseWords(s));
    }
    /// iterative
    /*
    static boolean isPalindrome(String s) {
        boolean r = false;
        if (s != null && !s.isEmpty()) {
            s = s.toLowerCase().replaceAll("[^\\p{Alnum}]", "");
            r = true;
            int i = 0;
            int j = s.length();
            while (i < j) {
                if(s.charAt(i++) != s.charAt(--j)) {
                    r = false;
                    break;
                }
            }
        }
        return r; 
    }
    */
    
    // regex
    static boolean isPalindrome(String s) {
        boolean r = false;
        if (s != null && !s.isEmpty()) {
            r = s.matches(PALINDROME);
        }
        return r;
    }

    static void demoPalindromeCheck() {
        String[] ss = { "radar", "madam", "Java", "redder", "Race car", "pasta", "fullstop", "pop", null, "s'madam's" };
        for(String s : ss) {
            System.out.printf("%s is%s a palindrome\n", s, (isPalindrome(s) ? "" : " NOT"));
        }
    }
    
    static String removeDupeChars(String s) {
        String r = "";
        if(s != null && !s.isEmpty()) {
            for(int i=0; i< s.length(); i++) {
                char ch = s.charAt(i);
                if(!r.contains("" + ch)) {
                    r = r + ch;
                }
            }
        }
        return r;
    }
    
    static void demoRemoveDupeChars() {
        String[] ss = { "bananas", "x", "redder", "Java", "", null, "antidisestablishmentarianism" };
        for(String s: ss) {
            System.out.printf("%s => %s\n", s, removeDupeChars(s));
        }
    }
    
    static boolean isShuffle(String a, String b, String c) {
        boolean r = false;
        if(c.length() == a.length() + b.length()) {
            r = true;
            
            final int A_LEN = a.length();
            final int B_LEN = b.length();
            final int DIFF = A_LEN - B_LEN;
            
            String tail = "";
            if(DIFF > 0) {
                tail = a.substring(A_LEN-DIFF, A_LEN);
            } else if(DIFF < 0) {
                tail = b.substring(B_LEN+DIFF, B_LEN);
            }

            for(int i=0; i< 2 * Math.min(A_LEN,B_LEN); i+=2) {
                int j = i/2;
                char ac = a.charAt(j);
                char bc = b.charAt(j);
                String p = "" + ac+bc, q= ""+ bc + ac;
                String t = c.substring(i,i+2);
                if(!(t.equals(p) || t.equals(q))) {
                    r = false;
                    break;
                }
            }
            if(r) {
                r = r && c.endsWith(tail);
            }
        }
        return r;
    }
    
    static void demoShuffleCheck() {
        String[] as = {"abc", "abc", "def", "wxyz", "xxx"};
        String[] bs = {"def", "def", "xyz", "bb8", "cat"};
        String[] cs = {"dabecf", "abcdef", "xdyefz", "wbbx8yz", "cxaxtx"};

        for (int i = 0; i < cs.length; i++) {
            System.out.printf("%3$s is%4$s a shuffle of %1$s and %2$s\n", as[i], bs[i], cs[i], isShuffle(as[i], bs[i], cs[i]) ? "" : " NOT");
        }
    }
    /*
    static int indexOfString(String s, String f) {
        int r = -1;
        final char F1 = f.charAt(0);
        int i = 0;
        while(i < s.length()) {
            char sc = s.charAt(i);
            if(sc == F1) {
                    if(i + f.length() > s.length()) {
                        break;
                    }
                    
                    int j = 1;
                    boolean match = true;
                    while(j < f.length()) {
                        if(f.charAt(j) != s.charAt(i+j)) {
                            match = false;
                            break;
                        }
                        ++ j;
                    }
                    if(match) {
                        r = i;
                        break;
                    }
            }
            ++i;
        }
        return r;
    }
    */
    
    static int indexOfString(String s, String f) {
        int r = -1;
        final char F1 = f.charAt(0);
        
        final int F_LEN = f.length();
        final int S_LEN = s.length();
        
        int i = 0;
        while (i < S_LEN) {
            char sc = s.charAt(i);
            if (sc == F1) {
                if (i + F_LEN > S_LEN) {
                    break;
                }
                if (f.hashCode() == s.substring(i, i+F_LEN).hashCode()) {
                    r = i;
                    break;
                }
            }
            ++i;
        }
        return r;
    }

    /*
    static int indexOfString(String s, String f) {
        int r = -1;
        final int LEN = f.length();
        for(int i=0; i<s.length()-LEN+1; i++) {
            if(f.equals(s.substring(i, i+LEN))) {
                r = i;
                break;
            }
        }
        return r;
    }
    */
    
    static void demoIndexOfString() {
        String[] ss = { "antidisestablishmentarianism", "antidisestablishmentarianism", "star trek", "star wars", "star trek" };
        String[] fs = { "est", "estr", "trek", "trek", "reki" };
        
        for(int i=0; i<ss.length; i++) {
            System.out.printf("indexOfString(%s, %s) = %d\n", ss[i], fs[i], indexOfString(ss[i],fs[i]));
        }
    }

    // display last, most common char
    /*
    static void printMostCommonChar(String s) {
        if (s == null || s.isEmpty()) {
            throw new RuntimeException("empty input!");
        }
        
        String r = s.toLowerCase();
        HashMap<Character, Integer> charCount = new LinkedHashMap<>();
        for( int i = 0; i < s.length(); i++) {
            Character ch = r.charAt(i);
            int c = 1;
            if (charCount.containsKey(ch)) {
                c += charCount.get(ch);
            }
            charCount.put(ch, c);            
        }

        Character result = null;
        int c = 0;
        for(Map.Entry<Character, Integer> entry : charCount.entrySet()) {
            int i =entry.getValue();
            if(i == Math.max(i, c)) {
                c = i;
                result = entry.getKey();
            }
        }
        System.out.println(result);
    }
    */
    
    // display first most common char
    /*
    static void printMostCommonChar(String s) {
        if (s == null || s.isEmpty()) {
            throw new RuntimeException("empty input!");
        }
        
        String r = s.toLowerCase();
        HashMap<Character, Integer> charCount = new LinkedHashMap<>();
        for( int i = 0; i < s.length(); i++) {
            Character ch = r.charAt(i);
            int c = 1;
            if (charCount.containsKey(ch)) {
                c += charCount.get(ch);
            }
            charCount.put(ch, c);            
        }

        Stack<Map.Entry<Character, Integer>> stack = new Stack<>();
        charCount.entrySet().stream().forEach( (entry) -> stack.push(entry) );
        
        Character result = null;
        int c = 0;
        while(!stack.isEmpty()) {
            Map.Entry<Character, Integer> entry = stack.pop();
            int i =entry.getValue();
            if(i == Math.max(i, c)) {
                c = i;
                result = entry.getKey();
            }
        }
        System.out.println(result);
    }
    */
    
    static void printMostCommonChar(String s) {
        if (s == null || s.isEmpty()) {
            throw new RuntimeException("empty input!");
        }
  
        String r = s.toLowerCase();
        HashMap<Character, Integer> charCount = new LinkedHashMap<>();
        for( int i = 0; i < s.length(); i++) {
            Character ch = r.charAt(i);
            int c = 1;
            if (charCount.containsKey(ch)) {
                c += charCount.get(ch);
            }
            charCount.put(ch, c);            
        }

        Set<Character> result = new HashSet<>();
        int c = 0;
        for(Map.Entry<Character, Integer> entry : charCount.entrySet()) {
            int i =entry.getValue();
            if (i == c) {
                result.add(entry.getKey());
            } else if(i == Math.max(i, c)) {
                c = i;
                result.clear();
                result.add(entry.getKey());
            }
        }
        System.out.println(result.size() == 1 ? result.toArray()[0] : result);
    }
        
    static void demoMostCommonChar() {
        String[] ss = { "aaaaaaaaaaaaaaaaabbbbcddddeeeeee", "antidisestablishmentarianism", "xylophone", "noosphere", "supercalifragilisticexpialidocious", "hypertonicity" };
        for(String s : ss) {
            System.out.print("the most common char in " + s + " is: ");
            printMostCommonChar(s);
        }
    }
    
    // iterative
    /*
    static String removeChar(String s, char ch) {
        if(s == null) {
            throw new RuntimeException("null input!");
        }
        
        String r ="";
        char CH = Character.isLowerCase(ch) ?
                Character.toUpperCase(ch) :
                Character.toLowerCase(ch);

        for(int i=0; i<s.length(); i++) {
            char c = s.charAt(i);
            if(!(c == ch || c == CH) ) {
                r += c;
            }
        }
        return r;
    }
    */
    
    // functional
    /*
    static String removeChar(String s, char ch) {
        if(s == null) {
            throw new RuntimeException("null input!");
        }
       
        char CH = Character.isLowerCase(ch) ?
                Character.toUpperCase(ch) :
                Character.toLowerCase(ch);
        return s.chars()
                .filter(c -> c != ch && c != CH)
                .mapToObj(c -> (char) c)
                .map(c -> "" + c)
                .collect(Collectors.joining());
    }
    */
    
    //  recursive
    /*
    static String removeChar(String s, char ch) {
        if(s == null) {
            throw new RuntimeException("null input!");
        }
        if(s.equals("")) {
            return s;
        }
        char h = s.toLowerCase().charAt(0);
        char H = Character.toUpperCase(h);
        String t = s.substring(1, s.length());
        return
                ((h == ch || H ==ch) ? "" : h)
                + removeChar(t, ch);
    }
    */

    // regex
    static String removeChar(String s, char ch) {
       if(s == null) {
            throw new RuntimeException("null input!");
        }
        char CH = Character.isLowerCase(ch)
                ? Character.toUpperCase(ch)
                : Character.toLowerCase(ch);

        return s.replaceAll("["+ch+CH+"]", "");
    }
    
    static void demoRemoveChar() {
        String[] ss = { "bananas", "x", "redder", "Java",  "antidisestablishmentarianism" };
        for(String s: ss) {
            int i = (new Random()).nextInt(s.length());
            char ch = s.charAt(i);
            System.out.printf("removeChar(%s,%c) => %s\n", s, ch, removeChar(s, ch));
        }
        
        String s = "foobar";
        char ch = 'x';
        System.out.printf("removeChar(%s,%c) => %s\n", s, ch, removeChar(s, ch));

        s = "";
        ch = 'x';
        System.out.printf("removeChar(%s,%c) => %s\n", s, ch, removeChar(s, ch));

        try {
            s = null;
            System.out.printf("removeChar(%s,%c) => %s\n", s, ch, removeChar(s, ch));
        } catch (Exception e) {
            System.out.println("exception raised: " + e);
        }
    }
    
    // asserts that the entirety of the string matches the given pattern    
    static String assertEntirety(String pattern) {
        return "(?<=(?=^pattern$).*)".replace("pattern", pattern);
    }
    static final String  PALINDROME =
             "(?x) | (?:(.) add)+ chk"
                .replace("add", assertEntirety(".*? (\\1 \\2?)"))
                .replace("chk", assertEntirety("\\2"));
    
    static void  demoPalindrome() {
    
        System.out.println(PALINDROME);
        // (?x) | (?:(.) (?<=(?=^.*? (\1 \2?)$).*))+ (?<=(?=^\2$).*)

        String[] tests = {
            "",     // true
            "x",    // true
            "xx",   // true
            "xy",   // false
            "xyx",  // true
            "xxx",  // true
            "xxyx", // false
            "racecar",                // true
            "step on no pets",        // true
            "aManaPlanaCanalPanaMa",  // true
            "this is impossible",     // FALSE!!!
        };
        for (String test : tests) {
            System.out.printf("[%s] %s%n", test, test.matches(PALINDROME));
        }
    }
    //  longest palindrome
    static String longestPalindrome(String s) {
        String r = null;
        if (s != null) {
            final String REGEX = "(\\w)(\\w).*?{2}(\\2)(\\1)";
            Pattern pattern = Pattern.compile(REGEX);
            Matcher matcher = pattern.matcher(s);
           
            int l = 0;
            while (matcher.find()) {
                String p = matcher.group();
                String q = p.replaceAll("\\p{Punct}", p);
                if (q.matches(PALINDROME)) {
                    int n = p.length();
                    if (n > l) {
                        r = p;
                        l = n;
                    }
                }
            }
        }
        return r; 
    }
    
    static void demoLongestPalindrome() {
        String[] ss = {
            "sir, that package is madam's",
             "the radar on that racecar is getting redder",
             "abba records have many fans"
        };
        
        for(String s : ss) {
            System.out.printf("%s => %s\n", s, longestPalindrome(s));
        }
    }
    
    //  sort strings by length
    static String[] sortByLength(String[] ss) {
        Comparator<String> compByLength = (a, b) -> a.length() - b.length();
        List<String> list = Arrays.stream(ss).sorted(compByLength).collect(Collectors.toList());
        return list.toArray(new String[]{});
    }
    
    static void demoSortByLength() {
        String[] ss = { "once", "upon", "a", "time", "in", "a", "galaxy", "far", "far", "away" };
        for(String s : sortByLength(ss)) {
            System.out.println(s);
        }
    }

    static void demoNotRegexMatch() {
        String[] ss = { "foobar", "fiji-water", "ReportSC", "reportSEO" };

        final String PAT = "^(?!.*ReportSC).*$";

        for (String s : ss) {            
            System.out.println(s + " does NOT match? " + s.matches(PAT));
        }
    }
    
    static void demoIsDashAlphanum() {
        String[] ss = { "foobar", "abc123", "789xyz", "901-1845", "-", "!@#$%^&", "1_44" };

        final String PAT = "\\p{Alnum}+";

        for (String s : ss) {            
            System.out.println(s + " is alnum? " + s.matches(PAT));
        }
    
    }

    static boolean isBalanced(String s) {
	final char OPEN_PAREN = '(';
        final char CLOSE_PAREN = ')';
        final char OPEN_BRACE = '{';
        final char CLOSE_BRACE = '}';

        if (s.isEmpty()) {
            return true;
        }

        final int LEN = s.length();
        if (LEN % 2 != 0) {
            return false;
        }

        Stack<Character> stack = new Stack<>();
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            switch (ch) {
                case CLOSE_BRACE:
                    if (stack.peek() == OPEN_BRACE) {
                        stack.pop();
                    } else {
                        return false;
                    }
                    break;
                case CLOSE_PAREN:
                    if (stack.peek() == OPEN_PAREN) {
                        stack.pop();
                    } else {
                        return false;
                    }
                    break;
                case OPEN_BRACE:
                case OPEN_PAREN:
                    stack.push(ch);
                    break;
                default:
                    throw new RuntimeException("got unexpected char: " + ch);
            }
        }
        return stack.empty();
    }
    
    static void demoIsBalanced() {
        String[] ss = {"(){}", "({()})", "{}(", "{})"};
        for (String s : ss) {
            boolean check = isBalanced(s);
            System.out.printf("%B\t%s\n", check, s);
        }	
    }
    
    static void scratch() {
        String s = "foo bar's";
        /*
         char[] ch = s.toCharArray();
         Arrays.stream(ch).forEach(System.out.println());
         */
        
        //s.chars().forEach(i -> System.out.println((char)i));        
        
        //System.out.println( normalizeString(s) );

        /*
        String VOWELS = "aeiou";
        String CONSONANTS = IntStream.rangeClosed('a', 'z')
                .mapToObj(c -> (char)c)
                .filter(c -> !VOWELS.contains(""+c))
                .map(c -> ""+c)
                .collect(Collectors.joining());
        System.out.println(CONSONANTS);
        System.out.println(CONSONANTS.length());
        */
/*        
        System.out.printf("5! = %d\n", factorial(5));
        System.out.printf("20! = %d\n", factorial(20));
        
        int[] xs = new int[10];
        System.out.printf("xs = %s\n", Arrays.toString(xs));
        */
        System.out.printf("3/2 = %d, 3%%2 = %d\n", (3/2), (3%2));
    }
    public static void main(String[] args) {
       // demoDupeChars();
        //demoAnagramCheck();
        //demoFindFirstUnique();
        //demoReverseString();
        //demoNumericCheck();
        //demoReportDupeChars();
        //demoCountVowelsAndConsonants();
        //demoCountChars();
        //demoStringToInt();
        //demoReplaceChar();
        //demoPermute();
        //demoReverseWords();
        //demoPalindromeCheck();
        //demoRemoveDupeChars();
        //demoShuffleCheck();
        //demoIndexOfString();
        //demoMostCommonChar();
        //demoRemoveChar();
        //demoPalindrome();
        //demoLongestPalindrome();
        //demoSortByLength();
        //demoNotRegexMatch();
        demoIsDashAlphanum();
	demoIsBalanced();
        //scratch();
    }
}

