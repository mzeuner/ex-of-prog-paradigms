import java.util.Random;

class Dice {
    private int number_of_dice;
    private int number_of_sides;
    private Random random = new Random(1);

    public Dice(int number_of_dice, int number_of_sides) {
	this.number_of_dice = number_of_dice;
	// this.random = new Random();

	if(number_of_sides == 4 || number_of_sides == 6
	                        || number_of_sides == 8
	                        || number_of_sides == 12
	                        || number_of_sides == 20){
	    this.number_of_sides = number_of_sides;
	}
	else{
	    throw new IllegalArgumentException ("Incorrect number of sides") ;
	}
    }

    public int get_number_of_dice(){
	return this.number_of_dice;
    }

    public int get_number_of_sides(){
	return this.number_of_sides;
    }

    public int roll_dice(){
	return random.ints(number_of_dice, 1,number_of_sides+1).sum();
    }

    public int roll_dice_many_times(int n){
	int sum = 0;
	for (int i = 0; i < n ; i++){
	    sum += roll_dice();
	}
	return sum;
    }
}


class Dice6 extends Dice {
    public Dice6() {
	super(1,6);
    }
}


public class java_live_demo {
   public static void main ( String[] args ) {
      Dice TwoDice20 = new Dice (2 ,20) ;
      System.out.println(TwoDice20.roll_dice());
      System.out.println(TwoDice20.roll_dice());
      System.out.println(TwoDice20.roll_dice_many_times(10));
      Dice6 D6 = new Dice6 ();
      System.out.println(D6.roll_dice());
      System.out.println(D6.roll_dice());
      System.out.println(D6.roll_dice_many_times(20));
   }
}
