#!/bin/bash

# hello and welcome to the worse, most annoying script to look at.
# but man, is it helpful


red="\033[1;31m"
pur="\033[1;35m"
res="\033[0m"
line="*************************************"

echo "$line"
printf "${red}Hey there!${res} Let's get started.\n\n"
printf "i made this script to make pom generating efficient\n"
printf "i have a few questions for you ;).\n\n"

# prompts
printf "${pur}what is your project's name? ${res}"
read proj
echo
printf "awesome! now lets fly through the rest! \n"

printf "${pur}groupId${res}: "
read groupId
echo
groupId="$groupId" | awk '{print tolower$(0)}'
echo "$groupId.${proj}"
printf "${pur}description${res}: "
read desc
echo
printf "${pur}who are you?${res} "
read dev_name
echo
printf "${pur}email${res} "
read dev_mail
echo
printf "${pur}main class, full cp: ${res} "
read class_path
echo
printf "${pur}junit?${res} (y/n) "
read junit
echo

mkdir -p src/main/java/"${groupId//[.]//}/${proj}"
mkdir src/main/resources
mkdir -p src/test/java/

sh -c plugin_yaml.sh "$proj" "$class_path" "$dev_name"

touch pom.xml
echo '<?xml version="1.0" encoding="UTF-8"?>' >> pom.xml
echo '<project xmlns="http://maven.apache.org/POM/4.0.0"' >> pom.xml
echo '         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' >> pom.xml
echo '         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">' >> pom.xml
echo '    <modelVersion>4.0.0</modelVersion>' >> pom.xml
echo "    <groupId>${groupId}</groupId>" >> pom.xml
echo "    <artifactId>${proj}</artifactId>" >> pom.xml
echo '    <version>1.0</version>' >> pom.xml
echo >> pom.xml
echo "    <name>${proj}</name>" >> pom.xml
echo "    <description>${desc}</description>" >> pom.xml
echo >> pom.xml
echo "    <developers>" >> pom.xml
echo "        <developer>" >>pom.xml
echo "            <name>${dev_name}</name>" >> pom.xml
echo "            <email>${dev_mail}</email>" >>  pom.xml
echo >> pom.xml
echo "        </developer>" >> pom.xml
echo "    </developers>" >> pom.xml
echo >> pom.xml
echo "    <properties>" >> pom.xml
echo '        <maven.compiler.source>8</maven.compiler.source>' >> pom.xml
echo '        <maven.compiler.target>8</maven.compiler.target>' >> pom.xml
echo '    </properties>' >> pom.xml
echo >> pom.xml

echo '    <build>' >> pom.xml
echo     '   <plugins>' >> pom.xml
echo '           <!--- MAVEN PLUGINS -->' >> pom.xml
echo '            <plugin>' >> pom.xml
echo '                <groupId>org.apache.maven.plugins</groupId>' >> pom.xml
echo '                <artifactId>maven-shade-plugin</artifactId>'  >> pom.xml
echo '                <version>3.2.3</version>'  >> pom.xml
echo '                <configuration>' >> pom.xml
echo '                   <minimizeJar>true</minimizeJar>' >> pom.xml
echo '                    <filters>' >> pom.xml
echo '                        <filter>' >> pom.xml
echo '                            <artifact>*:*</artifact>' >> pom.xml
echo '                        </filter>' >> pom.xml
echo '                    </filters>' >> pom.xml
echo '                </configuration>' >> pom.xml
echo '                <executions>' >> pom.xml
echo '                    <execution>' >> pom.xml
echo '                        <phase>package</phase>' >> pom.xml
echo '                        <goals>' >> pom.xml
echo '                            <goal>shade</goal>' >> pom.xml
echo '                        </goals>' >> pom.xml
echo '                    </execution>' >> pom.xml
echo '                </executions>' >> pom.xml
echo '            </plugin>' >> pom.xml
echo '            <plugin>' >> pom.xml
echo '                <groupId>org.apache.maven.plugins</groupId>' >> pom.xml
echo '                <artifactId>maven-jar-plugin</artifactId>' >> pom.xml
echo '                <version>3.2.0</version>' >> pom.xml
echo '                <configuration>' >> pom.xml
echo '                    <archive>' >> pom.xml
echo '                        <manifest>' >> pom.xml
echo '                            <addClasspath>true</addClasspath>' >> pom.xml
echo "                            <mainClass>${class_path}</mainClass>" >> pom.xml
echo '                        </manifest>' >> pom.xml
echo '                    </archive>' >> pom.xml
echo '                </configuration>' >> pom.xml
echo '            </plugin>' >> pom.xml
echo '            <plugin>' >> pom.xml
echo '                <groupId>org.apache.maven.plugins</groupId>' >> pom.xml
echo '                <artifactId>maven-compiler-plugin</artifactId>' >> pom.xml
echo '                <version>3.8.1</version>' >> pom.xml
echo '                <configuration>' >> pom.xml
echo '                    <source>1.8</source>' >> pom.xml
echo '                    <target>1.8</target>' >> pom.xml
echo '                </configuration>' >> pom.xml
echo '            </plugin>' >> pom.xml
echo '        </plugins>' >> pom.xml
echo '    </build>' >> pom.xml

echo '    <dependencies>' >> pom.xml


echoJunit() {
   echo '        <dependency>' >> pom.xml
   echo '            <groupId>junit</groupId>' >> pom.xml
   echo '            <artifactId>junit</artifactId>' >> pom.xml
   echo '            <version>4.10</version>' >> pom.xml
   echo '            <scope>test</scope>' >> pom.xml
   echo '        </dependency>' >> pom.xml   
}

case $junit in
   y) echoJunit;;
   *) echoDone;;
esac

echo '    </dependencies>' >> pom.xml
echo >> pom.xml
echo '</project>' >> pom.xml
echo
printf "${gre}done!${res}\n\n"
echo "$line"

# initialize git
git init
git add .
# maven wrapper
mvn -N io.takari:maven:wrapper
