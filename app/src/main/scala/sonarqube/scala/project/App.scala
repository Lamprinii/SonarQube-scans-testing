package sonarqube.scala.project

object App {
  private def hello(): Unit = {
    val x: Int = 10
    val y: Int = 20
    val z: Int = x + y
    println("Hello, world!")
  }

  def main(args: Array[String]): Unit = {
    //    hello()
    describeAnimal("Giraffe")
  }

  // Exhaustiveness check
  // This will generate an error because the `match` expression does not handle the case where the animal is not a `Dog` or a `Cat`.
  def describeAnimal(animal: String): String = {
    animal match {
      case "Dog" => "A dog is a furry four-legged animal that barks."
      case "Cat" => "A cat is a furry four-legged animal that meows."
    }
  }

  // Duplicate case class definitions
  sealed trait Animal
}