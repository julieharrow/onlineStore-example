import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class ZiftMedia {

	public static void main(String[] args) {

		System.out.println("Welcome! Today we are having our Independence Day Sale!  All CDs are 50% off!  All DVDs are 25% off! AND All BLU-RAYs are 15% off!  PLUS...Buy 5 or more DVDs and they are 30% off!");

    // build list of store items and create cost and discount hashes (versus loading database)
    List<String> storeItems = new ArrayList<String>();
    storeItems.add("CD");
    storeItems.add("DVD");
    storeItems.add("BLU-RAY");
    Map<String, Double> costPerUnit = new HashMap<String, Double>();
		costPerUnit.put("CD", 9.99);
		costPerUnit.put("DVD", 12.99);
		costPerUnit.put("BLU-RAY", 15.99);
    Map<String, Double> discountRates = new HashMap<String, Double>();
		discountRates.put("CD", 0.50);
		discountRates.put("DVD", 0.25);
		discountRates.put("BLU-RAY", 0.15);

    // initialize pre-discounted total cost and total savings variables
		Double totalCost = 0.00;
		Double totalSavings = 0.00;

    // loop through all store items
		for (int i = 0; i < storeItems.size(); i++) {
			String item = storeItems.get(i);

			// accept quantity as input from user
			System.out.println("How many " + item + "s would you like to buy today?");
			Scanner input = new Scanner(System.in);
    			int quantity = input.nextInt();

  		// add associated cost per item to total cost
  		totalCost = totalCost + costPerUnit.get(item) * quantity;

  		// add associated savings per item to total savings
  		// account for DVD quantity-driven discount factor
  		if (item == "DVD" && quantity >= 5) {
  			totalSavings = totalSavings + costPerUnit.get(item) * quantity * 0.30;
  		} else {
  			totalSavings = totalSavings + costPerUnit.get(item) * quantity * discountRates.get(item);
  		}

		}

		// calculate final total and print to screen
		Double finalOutput = Math.round((totalCost - totalSavings) * 100.0) / 100.0;
		System.out.print("Your total today is $" + finalOutput + ".");

	}

}
