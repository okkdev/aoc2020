import scala.io.Source

object Day4Part1 {
  def split_file(file: String): Array[String] = {
    return "\\s\\s".r.split(Source.fromFile(file).mkString)
  }

  def check_contents(passports: Array[String]): Int = {
    var matches = 0
    val pattern =
      "(?=.*byr:)(?=.*iyr:)(?=.*eyr:)(?=.*hgt:)(?=.*hcl:)(?=.*ecl:)(?=.*pid:).*".r

    for (p <- passports) {
      if (pattern matches p.replaceAll("\n", "")) {
        matches += 1
      }
    }

    return matches
  }

  def main(args: Array[String]): Unit = {
    val input = split_file("input.txt")

    println("Valid Passwords: " + check_contents(input))
  }
}
