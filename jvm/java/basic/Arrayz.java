package basic;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Deque;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.StringJoiner;
import java.util.function.IntPredicate;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 *
 * @author almacro
 */
public class Arrayz {
    
    static int findMissingNumber(int[] arr) {
        final int SUM = IntStream.rangeClosed(1,100).sum(); // 5050
        final int sum = Arrays.stream(arr).sum();
        return SUM - sum;
    }
    static void demoFindMissingNumber() {
        final int LIMIT = 100;
        final int x = (new Random()).nextInt(LIMIT + 1);
        System.out.printf("selected missing number: %d\n", x);
        
        int[] arr = new int[LIMIT];
        IntStream.range(0,LIMIT)
                .filter((n) -> n+1 != x)
                .forEach((n) -> arr[n] = n+1);
        System.out.printf("found missing number: %d\n", findMissingNumber(arr));
    }
    
    static int findDuplicateNumber(int[] arr) {
        final int EXPECTED = IntStream.rangeClosed(0,arr.length-2).sum();
        //System.out.println(EXPECTED);
        final int sum = Arrays.stream(arr).sum();
        //System.out.println(sum);
        return sum - EXPECTED;
    }
    static void demoFindDuplicateNumber() {
        final int N = (new Random()).nextInt(30)+1; 
        final int x = (new Random()).nextInt(N + 1);
        System.out.printf("selected duplicate number: %d\n", x);
        
        final int M = N - 1;
        int[] arr = new int[M];
        IntStream.range(0,M).forEach((i) -> arr[i] = i);
        
        int[] arr2 = new int[N];
        final int idx = (new Random()).nextInt(N);
        System.arraycopy(arr, 0, arr2, 0, idx);
        System.arraycopy(arr, idx, arr2, idx+1, arr.length - idx);
        arr2[idx] = x;
        
        System.out.printf("found duplicate number: %d\n", findDuplicateNumber(arr2));
    }
    
    
    static boolean sequentialSearch(int[] arr, int n) {
        boolean r = false;
        for(int i =0; i<arr.length; i++) {
            if(arr[i] == n) {
                r = true;
                break;
            }
        }
        return r;
    }
    static boolean binarySearch(int[] arr, int n) {
        int[] t = new int[arr.length];
        System.arraycopy(arr, 0, t, 0, arr.length);
        Arrays.sort(t);
        
        int min = 0, max = t.length;
        boolean r = false;
        while(min < max - 1) {
            int mid = (min + max)/2;
            
            if(t[mid] == n) {
                r = true;
                break;
            }
            
            if(t[mid] > n) {
                max = mid;
            } else {
                min = mid;
            }
        }
        return r;
    }
    static boolean searchForNumber(int[] arr, int n) {
        boolean r = sequentialSearch(arr, n);
        //boolean r = binarySearch(arr, n);
        return r;
    }
    static void demoSearchForNumber() {
        final int LEN = 1000;
        int[] arr = new int[LEN];
        Random rand = new Random();
        IntStream.range(0,LEN).forEach((i) -> arr[i] = rand.nextInt(LEN));
        
        final int x = rand.nextInt(LEN);
        System.out.printf("value %d%s found in array\n", x, searchForNumber(arr, x) ? "" : " NOT");
    }

    static class Nums {

        private final int[] vals;

        Nums(int[] _vals) {
            vals = _vals;
            Arrays.sort(vals);
        }

        public boolean contains(int n) {
            int min = 0;
            int max = vals.length-1;
            boolean r = false;
            
            while (min < max) {
                int mid = (min + max) / 2;
                int t = mid;
                int a = vals[t];
                if (a == n) {
                    int b = t > 0 ? vals[t - 1] : 0;
                    int c = t < vals.length - 1 ? vals[t + 1] : 0;
                    r = (a == b) || (a == c);
                    break;
                }

                if (n < a) {
                    max = mid - 1;
                } else {
                    min = mid + 1;
                }
            }

            return r;
        }
    }
    
    static void demoContainsDuplicateNumber() {
        final int P = (new Random()).nextInt(30)+1; 
        final int N = 3+P;
        final int x = (new Random()).nextInt(P);
        System.out.printf("selected duplicate number: %d\n", x);
        
        final int M = N - 1;
        int[] arr = new int[M];
        IntStream.range(0,M).forEach((i) -> arr[i] = i);
        
        int[] arr2 = new int[N];
        final int idx = (new Random()).nextInt(N);
        System.arraycopy(arr, 0, arr2, 0, idx);
        System.arraycopy(arr, idx, arr2, idx+1, arr.length - idx);
        arr2[idx] = x;
        
        Nums nums = new Nums(arr);
        System.out.printf("arr contains duplicate number %d => %B\n", x, nums.contains(x));
        Nums nums2 = new Nums(arr2);
        System.out.printf("arr2 contains duplicate number %d => %B\n", x, nums2.contains(x));
    }
    
    // sequential
    /*
    static void findLargestAndSmallestNumber(int[] arr) {
        int min = Integer.MAX_VALUE;
        int max = Integer.MIN_VALUE;
        for(int n : arr) {
            if(n > max) {
                max = n;
            } else if(n < min) {
                min = n;
            }
        }
        System.out.printf("{ largest: %d smallest: %d }\n", max, min);
    }
    */
    // using sort
    static void findLargestAndSmallestNumber(int[] arr) {
        int[] ns = Arrays.copyOf(arr, arr.length);
        Arrays.sort(ns);
        int min = ns[0];
        int max = ns[ns.length - 1];
        System.out.println(arr);
        System.out.printf("{ largest: %d smallest: %d }\n", max, min);        
    }
    
    static final Random PRNG = new Random();
    static int getRandomInteger() {
        int a = PRNG.nextInt();
        int b = PRNG.nextInt();
        if((b & 1) == 0) {
            a = -a;
        }
        return a;
    }
    static void demoFindLargestAndSmallestNumber() {
        final int P = (new Random()).nextInt(30) + 1;
        final int N = 3 + P;
        int[] arr = new int[N];
        IntStream.range(0,N).forEach((i) -> arr[i] = getRandomInteger());
        findLargestAndSmallestNumber(arr);
    }
    
    static void findAllPairsEqualingSum(int[] as, int[] bs, int sum) {
        for(int i=0; i<as.length; i++) {
            for(int j = 0; j < bs.length; j++) {
                int a = as[i];
                int b = bs[j];
                if(a+b == sum) {
                    System.out.printf("{ %d, %d }\n", a, b);
                }
            }
        }
    }
   static void  demoFindAllPairsEqualingSum() {
       IntPredicate isEven = i -> i % 2 == 0;
       int[] xs = IntStream.rangeClosed(-10,10).filter(isEven).toArray();
       int[] ys =  IntStream.rangeClosed(-10,10).filter(isEven.negate()).toArray();
       findAllPairsEqualingSum(xs, ys, 5);
    }
   static void findMultipleDuplicateNumbers(int[] arr) {
       Map<Integer,Integer> map = new HashMap<>();
       for(Integer n : arr) {
           int c = 1;
           if(map.containsKey(n)) {
               c += map.get(n);
           }
           map.put(n, c);
       }
       map.entrySet().stream()
               .filter(e -> e.getValue() > 1)
               .forEach(e -> System.out.printf("array has %d %d's\n",
                       e.getValue(), 
                       e.getKey()));
   }
    static void demoFindMultipleDuplicateNumber() {
        final Random PRNG = new Random();
        final int N = PRNG.nextInt(30) + 1;
        Set<Integer> set = IntStream.range(1, N).map(x -> PRNG.nextInt(N)).boxed().collect(Collectors.toSet());
        System.out.printf("selected duplicate numbers: %s\n", set);

        final int M = N - 1;
        int[] arr0 = new int[M];
        IntStream.range(0, M).forEach((i) -> arr0[i] = i);

        int[] arr = arr0;
        System.out.println("starting array = " + Arrays.toString(arr));
        for (int i : set) {
            System.out.println("i = " + i);
            int r = PRNG.nextInt(5) + 1;
            int[] arr2 = new int[arr.length + r];
            for (int j = 0; j <= r; j++) {
                int pos = PRNG.nextInt(arr.length);
                //System.out.printf("pos = %d, arr.len = %d, arr2.len = %d\n", pos, arr.length, arr2.length);
                System.arraycopy(arr, 0, arr2, 0, pos);
                System.arraycopy(arr, pos, arr2, pos + 1, arr.length - pos - 1);
                arr2[pos] = i;
                //System.out.println("working array = " + Arrays.toString(arr2));
                arr = arr2;
            }
        }
        System.out.println("final array = " + Arrays.toString(arr));

        findMultipleDuplicateNumbers(arr);
    }
    static int[] removeDuplicates(int[] arr) {
        Set<Integer> set = new HashSet<>();
        List<Integer> list = new ArrayList<>();
        
        for(int i=0; i < arr.length; i++) {
            int n = arr[i];
            if(!set.contains(n)) {
                set.add(n);
                list.add(n);
            }
        }
       return list.stream().mapToInt(Integer::intValue).toArray();
    }
    static void demoRemoveDuplicates() {
        final Random PRNG = new Random();
        final int N = PRNG.nextInt(30) + 1;
        Set<Integer> set = IntStream.range(1, N).map(x -> PRNG.nextInt(N)).boxed().collect(Collectors.toSet());

        final int M = N - 1;
        int[] arr0 = new int[M];
        IntStream.range(0, M).forEach((i) -> arr0[i] = i);

        int[] arr = arr0;
        for (int i : set) {
            int r = PRNG.nextInt(5) + 1;
            int[] arr2 = new int[arr.length + r];
            for (int j = 0; j <= r; j++) {
                int pos = PRNG.nextInt(arr.length);
                System.arraycopy(arr, 0, arr2, 0, pos);
                System.arraycopy(arr, pos, arr2, pos + 1, arr.length - pos - 1);
                arr2[pos] = i;
                arr = arr2;
            }
        }
        
        System.out.println("input array  = " + Arrays.toString(arr));
        System.out.println("result array = " + Arrays.toString(removeDuplicates(arr)));
    }

    static int partition(int[] nums, int pos, int start, int end) {
        int lo = start;
        int hi = end - 2;
        int pv= nums[pos];
        swap(nums, pos, end-1);
        
        while(lo < hi)  {
            if(nums[lo] < pv) {
               lo++;
            } else if (nums[hi] >= pv) {
                hi--;
            } else {
                swap(nums, lo, hi);
            }
        }
        
        int idx = hi;
        if(nums[hi] < pv) {
            idx++;
        }
        swap(nums, end - 1, idx);
        return idx;
    }
    static void swap(int[] a, int i, int j) {
        int t = a[i];
        a[i] = a[j];
        a[j] = t;
    }
    // iterative
    /*
    static void quicksort(int[] ns) {
        if(ns == null || ns.length <= 1) 
            return;
        
        Deque<Integer> stack = new LinkedList<>();
        stack.push(0);
        stack.push(ns.length);
        
        while(!stack.isEmpty()) {
            int end = stack.pop();
            int start = stack.pop();
            if(end - start < 2) continue;
            
            int p = start + ((end - start)/2);
            p = partition(ns, p, start, end);

            stack.push(p+1);            
            stack.push(end);
            
            stack.push(start);
            stack.push(p);            
        }
    }
    */
    
    // recursive
    static void qsort(int[] nums, int lo, int hi) {
        int i = lo;
        int j = hi;
        int v = nums[lo + (hi - lo)/2];
        
        while(i <= j) {
            while(nums[i] < v) {
                i++;
            }
            while(nums[j] > v) {
                j--;
            }
            if(i <= j) {
                swap(nums, i, j);
                i++;
                j--;
            }
        }
        
        if(lo < j) {
            qsort(nums, lo, j);
        }
        if(i < hi) {
            qsort(nums, i, hi);
        }
    }
    static void quicksort(int[] ns) {
        if (ns == null || ns.length <= 1) {
            return;
        }
        qsort(ns, 0, ns.length - 1);
    }
    // functional
    /*
        TODO make an array variant of this code
    
        public static <T> List<T> Quicksort(List<T> v, BiFunction<T, T, Integer> comparer) {
            if (v.size() < 2) {
                return v;
            }

            T pivot = v.get(v.size() / 2);

            List<T> l = new LinkedList<T>(Quicksort(v.stream().filter(x -> comparer.apply(x, pivot) < 0).collect(Collectors.toList()), comparer));
            l.addAll(v.stream().filter(x -> comparer.apply(x, pivot) == 0).collect(Collectors.toList()));
            l.addAll(Quicksort(v.stream().filter(x -> comparer.apply(x, pivot) > 0).collect(Collectors.toList()), comparer));

            return l;
        }
    */
    
    static String toCSV(int[] arr) {
        StringJoiner sj = new StringJoiner(", ");
        IntStream.of(arr).forEach(i -> sj.add("" + i));
        return "{ "+sj+" }";
    }
    static void demoQuicksort() {
        int[][] samps = {
            {3, 8, 7, 5, 2, 1, 9, 6, 4},
            {34, 32, 43, 12, 11, 32, 22, 21, 32},
            {5, 1024, 1, 88, 0, 1024},
            { 6, 5, 3, 1, 8, 7, 2, 4 },
            {3, 4, 7, 6, 2, 1, 8, 10, 9, 5, 3, 4, 7, 6, 2, 1, 8, 10, 9, 5, 3, 4, 7, 6, 2, 1, 8, 10, 9, 5, 3, 4, 7, 6, 2, 1, 8, 10, 9, 5, 3, 4},
            { 1 },
        };
        for (int[] nums : samps) {
            System.out.println("----\ninput = " + toCSV(nums));
            quicksort(nums);
            System.out.println("sorted = " + toCSV(nums));
        }
    }
    static void scratch() {
        int d = 2101;
        int dollars = d / 100;
        int cents = d % 100;
        System.out.printf("$%d.%02d\n", dollars, cents);
        
        /*
         Predicate<Integer> isEven = i -> i % 2 == 0;
         //IntStream.rangeClosed(-10,10).boxed().filter(isEven).forEach(System.out::println);
         IntStream.rangeClosed(-10,10).boxed().filter(isEven.negate()).forEach(System.out::println);
         */
    }
    static void demoHello() {
        System.out.println("hello arrayz");
    }
    
    public static void main(String[] args) {
        //demoFindMissingNumber();
        //demoFindDuplicateNumber();
        //demoSearchForNumber();
        //demoFindLargestAndSmallestNumber();
        //demoFindAllPairsEqualingSum();
        //demoFindDuplicateNumber();
        //demoFindMultipleDuplicateNumber();
        //demoRemoveDuplicates();
        demoQuicksort();
        
        //scratch();
        //demoContainsDuplicateNumber();
    }
}

