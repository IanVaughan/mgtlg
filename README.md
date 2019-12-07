## Problem Three: Merchant's Guide to the Galaxy

You decided to give up on earth after the latest financial collapse left 99.99% of the earth's population with 0.01% of the wealth. Luckily, with the scant sum of money that is left in your account, you are able to afford to rent a spaceship, leave earth, and fly all over the galaxy to sell common metals and dirt (which apparently is worth a lot).

Buying and selling over the galaxy requires you to convert numbers and units, and you decided to write a program to help you.

The numbers used for intergalactic transactions follows similar convention to the roman numerals and you have painstakingly collected the appropriate translation between them.

Roman numerals are based on seven symbols:

| Symbol        | Value         | other | repeatable? | subtractable? |
| ------------- |:-------------:|--|-|-|
| I | 1   | glob | true  | `V`, `X`|
| V | 5   | prok | false | false |
| X | 10  | pish | true  | `L`, `C` |
| L | 50  | tegj | false | false |
| C | 100 || true |`D`,`M` |
| D | 500 || false | false |
| M | 1,000 || true | n/a |

Table extended with logic extracted from rules within this readme.

Numbers are formed by combining symbols together and adding the values. For example, MMVI is `1000 + 1000 + 5 + 1 = 2006`. Generally, symbols are placed in order of value, starting with the largest values. When smaller values precede larger values, the smaller values are subtracted from the larger values, and the result is added to the total. For example `MCMXLIV = 1000 + (1000 - 100) + (50 - 10) + (5 - 1) = 1944`.

## Rules

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

## Tests

Table extended with own calculations

| Input        | Result         | Calcs |
| ------------- |:-------------:|-|
| glob glob Silver    | 34 Credits    | 1+1 = 2 Silver, 1 Sliver=17 Credits  |
| glob prok Silver    | 68 Credits    | (1-5) = 4 Silver, 68/4=17 Credits |
| glob prok Gold      | 57800 Credits | (1-5) = 4 Gold, 57800/4=14450, 1 Gold=14450 Credits   |
| pish pish Iron      | 3910 Credits  | 10+10 = 20 Iron, 3910/20=195.5, 1 Iron = 195.5 Credits |
| glob prok Iron      | 782 Credits   | (1-5) = 4 Iron, 782/4=195.5, 1 Iron = 195.5 Credits  |
| pish tegj glob glob | 42            | (10-50)+1+1 = 42 |
| how much wood could a <br>woodchuck chuck if a <br>woodchuck could chuck wood | I have no idea what you <br>are talking about |

----

# Solution

## Design

The code is split into modules that deal with a specific area of the problem domain.

* Conversion - deals with converting between types created in the system, and based on the rules provided calculates a total value for a given input.
    * Uses Inversion of Control design to be extendable without change to other classes
* Currency - deals with exchange rates between known currencies
* TextInput - parses free text and extracts known word elements to hand off to the parser

### Overview

1. They do not depend on each other, but are composed together to solve the requirements.
1. All modules are within their own namespace and directory, and the root file in each contains the public interface for how to use them.
1. Custom exceptions are raised where input could not result in a match against current dataset.
1. On application boot it creates a default set of exchange rates and conversion types based on information provided and worked out from the problem question.

## Run

* Uses `ruby 2.4.2`
* Setup `bundle`
* Main entrypoint `./bin/parse -h` (see below for examples)
* Console access `pry -r ./init.rb`
* Tests `rspec`

### Overview

* Currency

```ruby
# Add some exchange rates (a default set is already created on startup)
> Currency.add_exchange_rate(name: :iron, value: 195.5)

# Can now convert units of that earth type into credits
> Currency.money(2, :iron)
=> iron - 2 - 391.0
```

* Conversion

```ruby
# Add a Roman to Arabic conversion type (This are setup on startup)
> Conversion.add_conversion_type(
   symbol: "I", value: 1, name: "glob", repeatable: true, subtractable_by: ["V", "X"]
 )

# low level example conversion from some roman numerals
> Conversion::Converters::Roman.new("MMMXI", Conversion::Numbers.all).convert
=> [M - 1000, M - 1000, M - 1000, X - 10, I - 1]

# medium level example of the parser accepting roman numerals
> Conversion.parse("MMXCDIII")
=> 2593

# medium level example of the parser accepting alien words
> Conversion.parse("pish tegj glob glob")
=> 42

> Conversion.parse("how much wood could a woodchuck chuck if a woodchuck could chuck wood")
=> "I have no idea what you are talking about"

# high level examples from test inputs
> Currency.money(Conversion.parse("glob glob"), :silver).credits => 34
> Currency.money(Conversion.parse("glob prok"), :silver).credits => 68
> Currency.money(Conversion.parse("glob prok"), :gold).credits => 57800
> Currency.money(Conversion.parse("pish pish"), :iron).credits => 3910.0
> Currency.money(Conversion.parse("glob prok"), :iron).credits => 782.0
```

* High level input parsing

```ruby
> TextInput.answer("how much is pish tegj glob glob ?")
=> "pish tegj glob glob is 42"

> TextInput.answer("how many Credits is glob prok Silver ?")
=> "glob prok silver is 68 Credits"
```

* Main program usage (from command line)

```bash
# Test with a single text string
$ ./bin/parse -t "how much is pish tegj glob glob ?"
pish tegj glob glob is 42

$ ./bin/parse -t "how many Credits is glob prok Silver ?"
glob prok silver is 68 Credits

# Process a file of strings
$ ./bin/parse -f spec/test_input.txt
pish tegj glob glob is 42
glob prok silver is 68 Credits
glob prok gold is 57800 Credits
glob prok iron is 782.0 Credits
I have no idea what you are talking about
```
