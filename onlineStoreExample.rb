# Assume that there is an unlimited inventory of digital media.
# Propose that each music CD has a base price_per_unit of $9.99
# Propose that each movie DVD has a base price_per_unit of $12.99
# Propose that each movie Blu-ray has a base price_per_unit of $15.99

store_options = ["CD", "DVD", "BLU-RAY"]
cost_per_unit = {"CD"=>9.99, "DVD"=>12.99, "BLU-RAY"=>15.99}
discount_rates = {"CD"=>0.5, "DVD"=>0.25, "BLU-RAY"=>0.15}
total_cost = 0
total_savings = 0

puts "Welcome! Today we are having an Independence Day Sale!\nAll CDs are 50% off!  All DVDs are 25% off! All BLU-RAYs are 15% off!\nPLUS...Buy 5 or more DVDs and they are 30% off!\n\n"


store_options.each do |media|
  puts "How many #{media}'s would you like to buy today?"
  quantity = gets.chomp.to_i  # Assumes 0 if given non-number entry
  total_cost += cost_per_unit[media] * quantity
  if media == "DVD" && quantity >= 5
    total_savings += (cost_per_unit[media] * quantity * 0.3)
  else
    total_savings += (cost_per_unit[media] * quantity * discount_rates[media])
  end
end

puts "Your total today is $#{(total_cost - total_savings).round(2)}."
