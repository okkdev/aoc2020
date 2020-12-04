import scala.io.Source

object Day4Part2 {
  def split_file(file: String): Array[String] = {
    return "\\s\\s".r.split(Source.fromFile(file).mkString)
  }

  def check_passports(passports: Array[String]): Int = {
    var matches: Int = 0
    val pattern =
      raw"(?=.*byr:(19[2-9]\d|200[0-2])\b)(?=.*iyr:(201\d|2020)\b)(?=.*eyr:(202\d|2030)\b)(?=.*hgt:((1[5-8]\d|19[0-3])cm|(59|6\d|7[0-6])in))\b(?=.*hcl:#[0-f]{6}\b)(?=.*ecl:(amb|blu|brn|gr(y|n)|hzl|oth)\b)(?=.*pid:\d{9}\b).*".r

    for (p <- passports) {
      if (pattern matches p.replaceAll("\n", " ")) {
        matches += 1
      }
    }

    return matches
  }

  def main(args: Array[String]): Unit = {
    val input = split_file("input.txt")

    println("Valid Passwords: " + check_passports(input))
  }
}
