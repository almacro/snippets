import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;
import static java.lang.System.out;

public class Rands {
    public static void main(String[] args) {
        int count = 15;
        final long seed = 20240112015622L;

        List<Integer> rands = (new Random(seed)).ints(0,100).distinct().limit(count).boxed().collect(Collectors.toList());
        //(new Random(seed)).ints(0,100).distinct().limit(count).boxed().sorted().collect(Collectors.toList());
            //.forEach(System.out::println);

        for(Integer rand: rands) {
            out.print(rand+" ");
        }
        out.println();
    }
}
