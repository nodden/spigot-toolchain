# spigot-toolchain
*Tools for Spigot Plugin Development*

## TL;DR
This is the repository holding most of the tools used for more ***complicated*** Spigot development. 
Going into NMS, we'll need a decompiler, as well as @[FabricMC](https://github.com/FabricMC)'s yarn (enigma) mappings. 

## What's seen
Simple descriptions / instructions for the inclusions in this toolchain

### pom/pom.sh
Quick script for generating pom files in the current directory.

```
$ ./pom.sh
```

### Recaf
A modern bytecode decompiler

A personal favorite, in which effectively decompiles most things -- in dark mode! It's also the only decompiler I've seen decompile the "closed source premium Spigot jars" effectively. Premium Spigot jars suck, use the opensource ones. They're probably just TacoSpigot anyways, just with pricing.

### Yarn
A fork of Enigma, maintained by FabricMC. Used for modding, and applying the Minecraft mappings to Minecraft jars.

```
$ ./gradlew yarn
```
