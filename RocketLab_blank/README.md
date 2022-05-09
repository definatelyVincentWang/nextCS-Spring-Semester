# Name: Vincent Wang and Vincent Lin
# Pd: 3
# Rocket Lab Design Questions:
What parts of Gene, Individual and Population can be used exactly as they already are written? Why?
We can probably reuse our mate, Gene class, and mating season. We can also still use our select() function
What parts of Gene, Individual and Population will need to be modified? How will you modify them?
We might need to modify our fitness function and our Individual class
How are you going to use Gene objects to encode the angles and magnitudes of each move?
We will convert the magnitude and angle, which will be in a vector format, into two different Genes, and then just use an array of two Genes to represent a single vector
How is the main driver file going to differ from the regulargon version?
You would have to create a target and save the best objects 