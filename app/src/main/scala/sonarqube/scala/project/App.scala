package sonarqube.scala.project

object App {
  private def hello(): Unit = {
    val x: Int = 10
    val y: Int = 20
    val z: Int = x + y
    println("Hello, world!")
  }

  def main(args: Array[String]): Unit = {
    hello()
  }
}