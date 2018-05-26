## Problem Three: Merchant's Guide to the Galaxy

You decided to give up on earth after the latest financial collapse left 99.99% of the earth's population with 0.01% of the wealth. Luckily, with the scant sum of money that is left in your account, you are able to afford to rent a spaceship, leave earth, and fly all over the galaxy to sell common metals and dirt (which apparently is worth a lot).

Buying and selling over the galaxy requires you to convert numbers and units, and you decided to write a program to help you.

The numbers used for intergalactic transactions follows similar convention to the roman numerals and you have painstakingly collected the appropriate translation between them.

Roman numerals are based on seven symbols:

| Symbol        | Value         | other | repeatable? | subtractable? |
| ------------- |:-------------:|--|-|
| I | 1   | glob | true  | `V`, `X`|
| V | 5   | prok | false | false |
| X | 10  | pish | true  | `L`, `C` |
| L | 50  | tegj | false | false |
| C | 100 || true |`D`,`M` |
| D | 500 || false | false |
| M | 1,000 || true | n/a |


Numbers are formed by combining symbols together and adding the values. For example, MMVI is `1000 + 1000 + 5 + 1 = 2006`. Generally, symbols are placed in order of value, starting with the largest values. When smaller values precede larger values, the smaller values are subtracted from the larger values, and the result is added to the total. For example `MCMXLIV = 1000 + (1000 - 100) + (50 - 10) + (5 - 1) = 1944`.

## Rules

* The symbols "I", "X", "C", and "M" can be repeated three times in succession, but no more.
* They may appear four times if the third and fourth are separated by a smaller value, such as XXXIX.
* "D", "L", and "V" can never be repeated.
* "I" can be subtracted from "V" and "X" only.
* "X" can be subtracted from "L" and "C" only.
* "C" can be subtracted from "D" and "M" only.
* "V", "L", and "D" can never be subtracted.
* Only one small-value symbol may be subtracted from any large-value symbol.
* A number written in Arabic numerals can be broken into digits.
  * For example, 1903 is composed of 1, 9, 0, and 3.
  * To write the Roman numeral, each of the non-zero digits should be treated separately.
  * In the above example, 1,000 = M, 900 = CM, and 3 = III. Therefore, 1903 = MCMIII.
  * (Source: Wikipedia http://en.wikipedia.org/wiki/Roman_numerals)

Input to your program consists of lines of text detailing your notes on the conversion between intergalactic units and roman numerals.

You are expected to handle invalid queries appropriately.

## Tests

| Input        | Result         | Calcs |
| ------------- |:-------------:|-|
| glob glob Silver    | 34 Credits    | 1+1 = 2 Silver, 1 Sliver=17 Credits  |
| glob prok Silver    | 68 Credits    | (1-5) = 4 Silver, 68/4=17 Credits |
| glob prok Gold      | 57800 Credits | (1-5) = 4 Gold, 57800/4=14450, 1 Gold=14450 Credits   |
| pish pish Iron      | 3910 Credits  | 10+10 = 20 Iron, 3910/20=195.5, 1 Iron = 195.5 Credits |
| glob prok Iron      | 782 Credits   | (1-5) = 4 Iron, 782/4=195.5, 1 Iron = 195.5 Credits  |
| pish tegj glob glob | 42            | (10-50)+1+1 = 42 |
| how much wood could a <br>woodchuck chuck if a <br>woodchuck could chuck wood | I have no idea what you <br>are talking about |
