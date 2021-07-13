# API Automation x Karate
# Introduction
Karate is the only open-source tool to combine API test-automation,  [mocks](https://github.com/intuit/karate/blob/master/karate-netty),  [performance-testing](https://github.com/intuit/karate/blob/master/karate-gatling)  and even  [UI automation](https://github.com/intuit/karate/blob/master/karate-core)  into a  **single**,  _unified_  framework. The BDD syntax popularized by Cucumber is language-neutral, and easy for even non-programmers. Assertions and HTML reports are built-in, and you can run tests in parallel for speed.

There's also a cross-platform  [stand-alone executable](https://github.com/intuit/karate/blob/master/karate-netty#standalone-jar)  for teams not comfortable with Java. You don't have to compile code. Just write tests in a  **simple**,  _readable_  syntax - carefully designed for HTTP, JSON, GraphQL and XML. And you can mix API and  [UI test-automation](https://github.com/intuit/karate/blob/master/karate-core)  within the same test script.

A  [Java API](https://github.com/intuit/karate#java-api)  also exists for those who prefer to programmatically integrate Karate's rich automation and data-assertion capabilities.

## Karate Test Automation Features
Karate has a really long feature list, and it grows day by day. Looking at the feature list is like Christmas. You’re excited about new things and you don’t know how many presents you will get. But you are pretty sure that you will have something to play with. Every time I look at the karate feature list, I discover new things I want to play with. Although you can look up the  [full Karate feature list](https://intuit.github.io/karate/#features)  by yourself, I want to share the most important Karate features:

- API, Web UI and desktop UI testing automation support and you can mix these in one integration flow – this is huge!
- Easy to write and read tests.
- Express expected results as readable
- Scripts are plain-text, require no compilation, fast execution, and teams can collaborate using Git / standard SCM
- JSON and XML: Karate has native support for these languages.
- Comprehensive assertion capabilities
- Fully featured debugger that can step _backwards_
- Scripts are reusable, you can call them by other scripts
- Built-in support for switching configuration across different environments (e.g. dev, QA, pre-prod)
- Built-in test-reports compatible with Cucumber so you have the option of using third-party (open-source) maven-plugins for even [better-looking reports](https://intuit.github.io/karate/karate-demo#example-report)
- API mocks or test-doubles that even maintain CRUD ‘state’ across multiple calls – enabling TDD for micro-services and Consumer Driven Contracts
- Comprehensive support for different flavors of HTTP calls


![If you are familiar with Cucumber / Gherkin, the big difference here is that you don't need to write extra "glue" code or Java "step definitions" !](https://raw.githubusercontent.com/intuit/karate/master/karate-demo/src/test/resources/karate-hello-world.jpg)

# Getting Started
If you are a Java developer - Karate requires at least  [Java](http://www.oracle.com/technetwork/java/javase/downloads/index.html)  8 and then either  [Maven](http://maven.apache.org/),  [Gradle](https://gradle.org/),  [Eclipse](https://github.com/intuit/karate#eclipse-quickstart)  or  [IntelliJ](https://github.com/intuit/karate/wiki/IDE-Support#intellij-community-edition)  to be installed. Note that Karate works fine on OpenJDK.

If you are new to programming or test-automation, refer to this video for  [getting started with just the (free) IntelliJ Community Edition](https://youtu.be/W-af7Cd8cMc). Other options are the  [quickstart](https://github.com/intuit/karate#quickstart)  or the  [standalone executable](https://github.com/intuit/karate/blob/master/karate-netty#standalone-jar).

## Maven
If you are using Maven, you need the two following dependencies

```xml
<dependencies>  
    <dependency> <groupId>com.intuit.karate</groupId>  
	    <artifactId>karate-junit4</artifactId>  
	    <version>1.0.1</version>  
	    <scope>test</scope>  
    </dependency> 
    <dependency> 
	    <groupId>com.intuit.karate</groupId>  
	    <artifactId>karate-apache</artifactId>  
	    <version>0.9.6</version>  
	    <scope>test</scope>  
    </dependency>
</dependencies>
```

## Gradle
Alternatively, if you are using Gradle, you need
```bash
testCompile 'com.intuit.karate:karate-junit4:1.6.1'
testCompile 'com.intuit.karate:karate-apache:0.9.6'
```

## Quickstart

It may be easier for you to use the Karate Maven archetype to create a skeleton project with one command. You can then skip the next few sections, as the  `pom.xml`, recommended directory structure, sample test and  [JUnit 4](https://github.com/intuit/karate#junit-4)  runners - will be created for you.

You can replace the values of `com.mycompany` and `myproject` as per your needs.
```bash
mvn archetype:generate \
-DarchetypeGroupId=com.intuit.karate \
-DarchetypeArtifactId=karate-archetype \
-DarchetypeVersion=1.0.1 \
-DgroupId=com.mycompany \
-DartifactId=myproject
```

This will create a folder called `myproject` (or whatever you set the name to).

## Folder Structure
A Karate test script has the file extension  `.feature`  which is the standard followed by Cucumber. You are free to organize your files using regular Java package conventions.

The Maven tradition is to have non-Java source files in a separate `src/test/resources` folder structure - but the creators of the Karate tool recommend that you keep them side-by-side with your `*.java` files.

![enter image description here](https://github.com/runimanrun/karate-api/blob/master/src/test/java/posts/resources/images/structure.png)

Like Cucumber, you need to have a “Runner” class which runs the feature file(s). Unlike Cucumber, however, there are no step definitions! And this is the magic of Karate.

To use the TestRunner.java class to execute the feature file, you need to have the build section in the pom.xml file.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>Tutorials</groupId>
    <artifactId>Karate</artifactId>
    <version>1.0-SNAPSHOT</version>
    <dependencies>
        <dependency>
            <groupId>com.intuit.karate</groupId>
            <artifactId>karate-apache</artifactId>
            <version>0.9.6</version>
        </dependency>
        <dependency>
            <groupId>com.intuit.karate</groupId>
            <artifactId>karate-junit4</artifactId>
            <version>1.0.1</version>
        </dependency>
    </dependencies>
    <build>
        <testResources>
            <testResource>
                <directory>src/test/java</directory>
                <excludes>
                    <exclude>**/*.java</exclude>
                </excludes>
            </testResource>
        </testResources>
    </build>
</project>
```
And your TestRunner.java class would look like
```java
package user;  
  
import com.intuit.karate.junit4.Karate;  
import org.junit.runner.RunWith;  
  
@RunWith(Karate.class)  
public class TestRunner {  
}
```

## Command Line
Normally in dev mode, you will use your IDE to run a  `*.feature`  file directly or via the companion 'runner' JUnit Java class. When you have a 'runner' class in place, it would be possible to run it from the command-line as well.

Note that the  `mvn test`  command only runs test classes that follow the  `*Test.java`  [naming convention](https://github.com/intuit/karate#naming-conventions)  by default. But you can choose a single test to run like this:
```bash
mvn test -Dtest=TestRunner
```
And then the above command in Gradle would look like:
```bash
./gradlew test -Dtest.single=TestRunner
```

## Test Reports
Here below is an actual report generated by the [cucumber-reporting](https://github.com/damianszczepanik/cucumber-reporting) open-source library.

![enter image description here](https://github.com/runimanrun/karate-api/blob/master/src/test/java/posts/resources/images/report.png)
